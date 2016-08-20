# mini-handas
mini 2D-table Haskell library like pandas

## Overview

 * under construction
 * This is an experimental library with table access UI.  
 * If you need performance and useful functions, you should use [vector][1], [hmatrix][2], [cassava][3], [Frames][4] and any packages.



## Examples

### column extraction (!|)
```haskell
tbl = readCSV "file.csv"

col1 = tbl !| 1
col2 = tbl !| "year"

-- fancy index
col3 = tbl !| [1,5,4]
col4 = tbl !| ["year", "value"]

-- slice index
col5 = tbl !| (2,5)

-- boolean index
col6 = tbl !| [True, False, True]
```

### column boolean operation
```haskell
cond1 = tbl !| 5 >? 0
cond2 = tbl !| 4 >? 0 &&? tbl !| 5 ==? "2016"
```

### column functional operation
```haskell
col1 = fmap (+1) (tbl !| 3)
col2 = (+1) <$> (tbl1 !| 3)
```

### inter column operation
```haskell
col1 = (tbl !| 3) + (tbl !| 4)
col2 = zipWith (+) (tbl !| 3) (tbl !| 4)
col3 = (>) <$> (tbl !| 3) <*> (tbl !| 4)
```

### in-column operation
```haskell
r1 = foldr (+) 0 (tbl !| 3)
r2 = filter (>0) (tbl !| 3)
```

### row extraction (!#)
```haskell
df1 = tbl !# 1
df2 = tbl !# "id100"
df3 = tbl !# [50, 51]
df4 = tbl !# ["id100", "id101"]
df5 = tbl !# (100,200)
df6 = tbl !# [True, False, True]
df7 = tbl !# (tbl !| >? 0)
df8 = tbl !# ((>0) <$> tbl !| 3)
df9 = tbl !# ((>) <$> col1 <*> col2)
df10 = tbl !# (tbl !| 4 ==? "Apl")

```

[1]: https://hackage.haskell.org/package/vector
[2]: https://hackage.haskell.org/package/hmatrix
[3]: https://hackage.haskell.org/package/cassava
[4]: https://hackage.haskell.org/package/Frames

