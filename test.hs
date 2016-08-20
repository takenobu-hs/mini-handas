
import Data.MinHandas
import Data.Dynamic


-- test data
s1 :: Series Int
s1 = Series [1,2,3]

s2 :: Series String
s2 = Series ["pat1", "pat2", "pub3"]

s3 :: Series Float
s3 = Series [0.1, 0.2, 0.3]

--
df :: DFrame
df = DFrame [toDyn s1, toDyn s2, toDyn s3]


-- test 
z1 = df !| 0 :: Series Int
z2 = df !| "1" :: Series String
z3 = df !| [0,2] :: DFrame
z4 = df !| ["0","2"] :: DFrame
z5 = df !| (1,2) :: DFrame
z6 = df !| [True, False, True] :: DFrame


