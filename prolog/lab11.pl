/*
1. Определите отношение trim(L1,L2), которое удаляет в списке L1 первый и последний элемент.
*/
trim([_|T], R):-reverse(T, [_|S]), reverse(S,R).
trim([], R):-append([], [], R).

/*
2. Определите отношение first_last(L1,L2), которое выполнено, если список L1 совпадает со списком L2, но в L2 первый и последний элемент поменялись местами.
*/
first_last([H|T],R):-reverse(T, [L|T1]), reverse(T1, T2), append([L|T2], [H], R).
first_last([], R):-append([], [], R).

/*
3. Определите процедуру total/2, которая подсчитывает произведение элементов списка целых чисел.
*/
total([H|T], N):-total(T, N1), N is (N1+H).
total([], N):-N is 0.

/*
4. Определите процедуру place/3, которая первый свой аргумент помещает во второй аргумент, являющийся списком, таким образом, что первый аргумент последовательно занимает место между элементами второго  аргумента.
*/
place(X, L, R):-append(L1, L2, L), append(L1, [X], L3), append(L3, L2, R).

/*
5. Напишите процедуру double(L,LL), в которой   каждый элемент списка L удваивается в списке LL.
*/
double([H|T], R):-append([H], [H], L1), double(T, R1), append(L1, R1, R).
double([], R):-append([], [], R).

/*
6. Определите процедуру split(L1,L2,L3), которая разбивает список целых чисел L1 на два списка: четных чисел L2 и нечетных - L3.
Порядок элементов в двух новых списках должен быть обратный,  как показано в примере.
*/
even(X) :- 0 is mod(X, 2).
odd(X) :- 1 is mod(X, 2).
split(L1,L2,L3):-
    findall(X1, (member(X1, L1), even(X1)), L21),
    findall(X2, (member(X2, L1), odd(X2)), L31),
    reverse(L21, L2),
    reverse(L31, L3).

/*
7. Определите отношение repeat3(L1,L2) c аргументами - списками. В списке L2 первый и последний элемент списка L1 меняются местами и  повторяются три раза.
*/
make3(X, R):-append([X], [X], L1), append([X], L1, R).
repeat3(L, R):-
    first_last(L, [H1|T1]),
    make3(H1, L1),
    reverse(T1, [H2|T2]),
    reverse(T2, L4),
    make3(H2, L2),
    append(L1, L4, L3),
    append(L3, L2, R).
repeat3([], R):-append([], [], R).

/*
8. Определите процедуру combi(L1,L2,L3), которая помещает элементы второго списка между элементами первого.
*/
combi([H1|T1], [H2|T2], R):-append([H1], [H2], L1), combi(T1, T2, L2), append(L1, L2, R).
combi([], [], R):-append([], [], R).
combi([], L, R):-append([], L, R).
combi(L, [], R):-append([], L, R).
