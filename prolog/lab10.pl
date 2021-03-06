seg(1, point(1, 11), point(14, 11)).
seg(2, point(2, 4), point(13, 4)).
seg(3, point(2, 2), point(9, 2)).
seg(4, point(3, 1), point(3, 10)).
seg(5, point(7, 10), point(13, 10)).
seg(6, point(8, 0), point(8, 13)).
seg(7, point(10, 3), point(10, 12)).
seg(8, point(11, 3), point(11, 13)).
seg(9, point(12, 2), point(12, 12)).

/*
1. Напишите правило, определяющее номер горизонтального отрезка. Голова правила представлена термом horiz/1.
*/
horiz(N):-seg(N, point(_,Y), point(_,Y)).

/*
1. Напишите  правило, определяющее номер вертикального отрезка. Голова правила представлена термом vertical/1.
*/
vertical(N):-seg(N, point(X, _), point(X, _)).

/*
2. Введите в базу данных правило, определяющее пересекающиеся отрезки.
Голова правила представлена структурой cross/5, два аргумента которой N и M - номера пересекающихся отрезков,
третий - point(X,Y), описывает точку пересечения, а четвертый и пятый - длины пересекающихся отрезков.
(Если необходимо, для нахождения квадратного корня воспользуйтесь правилом sqrt(N,X), где N - число, X - квадратный корень от числа N.)

http://algolist.ru/maths/geom/intersect/lineline2d.php
*/
cross(N, M, point(X, Y), NL, ML):-
    seg(N, point(X1, Y1), point(X2, Y2)),
    seg(M, point(X3, Y3), point(X4, Y4)),
    UA_DIV is (Y4-Y3)*(X2-X1)-(X4-X3)*(Y2-Y1),
    UA_DIV \= 0,
   	UA is ((X4-X3)*(Y1-Y3)-(Y4-Y3)*(X1-X3))/(UA_DIV),
    UB_DIV is (Y4-Y3)*(X2-X1)-(X4-X3)*(Y2-Y1),
    UB_DIV \= 0,
    X is X1 + UA * (X2 - X1),
    Y is Y1 + UA * (Y2 - Y1),
    ML is sqrt((X2-X1)*(X2-X1)+(Y2-Y1)*(Y2-Y1)),
    NL is sqrt((X4-X3)*(X4-X3)+(Y4-Y3)*(Y4-Y3)).

/*
3. Добавьте в базу данных правило определения периметра и площади прямоугольников, образуемых пересекающимися отрезками.
Голова правила представлена структурой per_sq/6, четыре  аргумента которой - номера отрезков, образующих прямоугольник.
Пятый аргумент - P, периметр прямоугольника. Шестой аргумент - S, площадь периметра.
*/
per_sq(A, B, C, D, P, S):-
    cross(A, B, point(X1, Y1), _, _),
    cross(B, C, point(X2, Y2), _, _),
    cross(C, D, point(X3, Y3), _, _),
    cross(D, A, point(X4, Y4), _, _),
    LAB is sqrt((X2-X1)*(X2-X1)+(Y2-Y1)*(Y2-Y1)),
    LBC is sqrt((X3-X2)*(X3-X2)+(Y3-Y2)*(Y3-Y2)),
    LCD is sqrt((X4-X3)*(X4-X3)+(Y4-Y3)*(Y4-Y3)),
    LDA is sqrt((X1-X4)*(X1-X4)+(Y1-Y4)*(Y1-Y4)),
    P is (LAB + LBC + LCD + LDA), P > 0,
    S is (LAB * LBC), S > 0.
