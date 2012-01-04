-- -*- coding: utf-8 -*-

--module BinaryTree where
data BTree a = Empty 
             | Leaf a
             | Node (BTree a) a (BTree a) deriving (Eq, Ord)

instance Show a => Show (BTree a) where
    show Empty = "E"
    show (Leaf a) = show a
    show (Node l a r) = "(L:" ++ show l ++ ", V:" ++ show a ++ ", R:" ++ show r ++ ")"

listToBTree :: (Ord a) => [a] -> BTree a
listToBTree l = foldl insertValue Empty l

toList :: (Ord a) => BTree a -> [a]
toList Empty = []
toList (Leaf x) = [x]
toList (Node l x r) = toList l ++ (x : toList r)

insertValue :: (Ord a) => BTree a -> a -> BTree a
insertValue (Empty) v = Leaf v
insertValue (Leaf x) v
    | v < x = Node (Leaf v) x (Empty)
    | otherwise = Node (Empty) x (Leaf v)
insertValue (Node l x r) v
    | v < x = Node (insertValue l v) x r
    | otherwise = Node l x (insertValue r v)

searchValue :: (Ord a) => BTree a -> a -> Maybe a
searchValue (Empty) v = Nothing
searchValue (Leaf x) v = if v == x
                         then Just x
                         else Nothing
searchValue (Node l x r) v
    | v < x = searchValue l v
    | v > x = searchValue r v
    | otherwise = Just x

maxValue :: (Ord a) => BTree a -> Maybe a
maxValue (Empty) = Nothing
maxValue (Leaf x) = Just x
maxValue (Node l x r) 
    | r == Empty = Just x
    | otherwise = maxValue r

minValue :: (Ord a) => BTree a -> Maybe a
minValue (Empty) = Nothing
minValue (Leaf x) = Just x
minValue (Node l x r) 
    | r == Empty = Just x
    | otherwise = maxValue l

deleteValue :: (Ord a) => BTree a -> a -> Maybe (BTree a)
deleteValue (Empty) v = Nothing
deleteValue (Leaf x) v = if v == x
                         then Just (Empty)
                         else Nothing
deleteValue (Node l x r) v
    | v < x = deleteValue l v
    | v > x = deleteValue r v
    | otherwise = Just (recompose l r)

recompose :: (Ord a) => BTree a -> BTree a -> BTree a
recompose a b = case (a, b) of
                  (Empty, Empty) -> Empty
                  (Node xl x xr, Node yl y yr) -> Node a y (recompose yl yr)
                  (Empty, _) -> b
                  (_, Empty) -> a


main = print $ deleteValue (listToBTree [3, 4, 2, 1, 5]) 3
