defmodule SkewHeap do
  @type heap(a) :: node(a) | nil
  @type node(a) :: {a, heap(a), heap(a)}

  @spec tree(a, heap(a), heap(a)) :: heap(a) when a: var
  def tree(x, l \\ nil, r \\ nil), do: {x, l, r}

  @spec new :: heap(term)
  def new, do: nil

  @spec union(heap(a), heap(a)) :: heap(a) when a: var
  def union(nil, t2), do: t2
  def union(t1, nil), do: t1
  def union({x1, l1, r1}, {x2, _, _} = t2) when x1 <= x2, do: tree(x1, union(t2, r1), l1)
  def union(t1, {x2, l2, r2}), do: tree(x2, union(t1, r2), l2)

  @spec push(heap(a), a) :: heap(a) when a: var
  def push(heap, x), do: x |> tree |> union(heap)

  @spec pop(heap(a)) :: :empty | {a, heap(a)} when a: var
  def pop(nil), do: :empty
  def pop({x, l, r}), do: {x, union(l, r)}
end
