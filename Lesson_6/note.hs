catAt = (!!) "cat"

myRepeat n =  cycle [n]
subseq start end lst = take seq dropped
  where dropped = drop start lst
        seq = end - start

inFirstHalf a lst = elem a halfLst
  where half = div (length lst) 2
        halfLst = take half lst