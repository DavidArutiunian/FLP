import Data.Map
import Data.List
import Data.Maybe

null' :: Map k a -> Bool
null' x = size(x) == 0

union' :: Ord k => Map k a -> Map k a -> Map k a
union' xs ys = fromList (Data.List.map mapper uniqueKeys)
    where
        unique = reverse . nub . reverse
        uniqueKeys = unique (Data.Map.keys(xs) ++ Data.Map.keys(ys))
        unionOfMaps = fromList ((toList xs) ++ (toList ys))
        mapper = (\v -> (v, fromJust (Data.Map.lookup v unionOfMaps)))

keys' :: Map k a -> [k]
keys' = foldrWithKey (\k _ ks -> k : ks) []

toAscList' :: Map k a -> [(k,a)]
toAscList' = foldrWithKey (\k x xs -> (k,x):xs) []

map' :: Ord k => (a -> b) -> Map k a -> Map k b
map' f xs
    | Data.Map.null xs = empty
    | otherwise = Data.Map.union mapHead mapTail
        where
            listMap = toList xs
            listMapHead = head listMap
            headKey = fst listMapHead
            headValue = f (snd listMapHead)
            mapHead = fromList [(headKey, headValue)]
            mapTail = map' f (fromList (tail listMap))

