-- -*- coding: utf-8 -*-

merge l1 l2 =
    case (l1, l2) of
      ([], _) -> l2
      (_, []) -> l1
      (x : xs, y : ys) ->
          if x < y then x : (merge xs l2) else y : (merge l1 ys)

split l =
      case l of
        [] -> ([], [])
        x : [] -> (x : [], [])
        x : y : zs ->
            (\l' -> (x : fst l', y : snd l')) (split zs)

merge_sort l =
    case l of
      [] -> []
      x : [] -> x : []
      x : y : zs ->
        (\l' -> merge (merge_sort (fst l')) (merge_sort (snd l'))) (split l)

partition p a b l =
    case l of
      [] -> (a, b)
      x : xs ->
          if x < p then partition p (x : a) b xs
          else partition p a (x : b) xs

quick_sort l =
    case l of
      [] -> []
      p : l' -> quick_sort left ++ (p : quick_sort right)
          where
            (left, right) = partition p [] [] l'


main = print $ merge_sort [4, 2, 5, 3, 1, 6] == quick_sort [3, 1, 4, 6, 2, 5]
