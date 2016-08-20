
{-# LANGUAGE FlexibleInstances #-} -- instance Num a
{-# LANGUAGE UndecidableInstances #-} -- instance Num a
{-# LANGUAGE IncoherentInstances #-} -- String
{-# LANGUAGE MultiParamTypeClasses #-} -- Handas a b

module Data.MinHandas (
    Series(..)  -- tmporary
  , DFrame(..)  -- tmporary
  , (!|)
--, (!#)
  ) where

import Data.Dynamic

------------------------------------------------------------------------
--  NOTE:
--    * UNDER CONSTRUCTION!
--    * now, cheap implementation only for basic UI test
--    * to use Data.Vector instead of List
------------------------------------------------------------------------


----------------------------------------
-- define data types
----------------------------------------
data Series a = Series [a]
              | SeriesNothing
                deriving (Typeable, Show)

data DFrame = DFrame [Dynamic]
              deriving Show


----------------------------------------
-- define core classes and operation
----------------------------------------
--
class Handas a b where
  (!|) :: DFrame -> a -> b

-- x !| 0
instance (Integral a, Num a, Typeable b) => Handas a b where
  (DFrame xs) !| n = justDyn $ xs !! (num2int n)

-- x !| "1"
instance Typeable b => Handas String b where
  (DFrame xs) !| n = justDyn $ xs !! (read n)

-- x !| [0,2]
instance (Integral a, Num a) => Handas [a] DFrame where
  (DFrame xs) !| ns = DFrame [xs !! n | n <- map num2int ns]

-- x !| ["0", "2"]
instance Handas [String] DFrame where
  (DFrame xs) !| ns = DFrame [xs !! n | n <- map read ns]

-- x !| (1,2)
instance (Integral a, Num a, Integral b, Num b) => Handas (a,b) DFrame where
  (DFrame xs) !| (x,y) = DFrame (drop x' . take (y'+1) $ xs)
                           where x' = num2int x
                                 y' = num2int y

-- x !| [True, False, True]
instance Handas [Bool] DFrame where
  (DFrame xs) !| ps = DFrame [x | (x,p) <- zip xs ps, p]



----------------------------------------
-- utilities
----------------------------------------
num2int :: (Integral a, Num a) => a -> Int
num2int = fromInteger . toInteger

justDyn :: Typeable a => Dynamic -> a
justDyn x = case (fromDynamic x) of
              Just y -> y
              Nothing -> error "fail"

