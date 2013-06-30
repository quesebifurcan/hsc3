-- | Internal types and functions, not exported.
module Sound.SC3.Internal where

type T2 a = (a,a)
type T3 a = (a,a,a)
type T4 a = (a,a,a,a)

-- | Concatentative application of /f/ at /x/ and /g/ at /y/.
mk_duples :: (a -> c) -> (b -> c) -> [(a, b)] -> [c]
mk_duples a b = concatMap (\(x,y) -> [a x, b y])

-- | Concatentative application of /g/ at /x/ and /f/ at length of /y/
-- and /g/ at each element of /y/.
mk_duples_l :: (Int -> c) -> (a -> c) -> (b -> c) -> [(a, [b])] -> [c]
mk_duples_l i a b = concatMap (\(x,y) -> a x : i (length y) : map b y)

-- | Concatentative application of /f/ at /x/ and /g/ at /y/ and /h/
-- at /z/.
mk_triples :: (a -> d) -> (b -> d) -> (c -> d) -> [(a, b, c)] -> [d]
mk_triples a b c = concatMap (\(x,y,z) -> [a x, b y, c z])