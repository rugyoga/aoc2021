h0 = SkewHeap.empty()
|> SkewHeap.push(5)
|> SkewHeap.push(3)
|> SkewHeap.push(8)
|> SkewHeap.push(1)
|> SkewHeap.push(4)
|> SkewHeap.push(2)
|> SkewHeap.push(7)
|> SkewHeap.push(6)

with  {a1, h1} = SkewHeap.pop(h0),
      {a2, h2} = SkewHeap.pop(h1),
      {a3, h3} = SkewHeap.pop(h2),
      {a4, h4} = SkewHeap.pop(h3),
      {a5, h5} = SkewHeap.pop(h4),
      {a6, h6} = SkewHeap.pop(h5),
      {a7, h7} = SkewHeap.pop(h6),
      {a8, _} = SkewHeap.pop(h7)
do
  IO.inspect([a1,a2,a3,a4,a5,a6,a7,a8])
end
