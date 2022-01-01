defmodule Day18 do
    def addition(a, b), do: reduce([a, b])

    def reduce(l) do
      cond do
      l = explode(l, 1) -> l |> elem(1) |> reduce
      l = split(l) -> l |> reduce
      true -> l
      end
    end

    def merge([a, b], c), do: [a, merge(b, c)]
    def merge(a, [b, c]), do: [merge(a, b), c]
    def merge(a, b), do: a + b

    def explode([a, b], 5), do: {a, 0, b}
    def explode([a, b], depth) do
      with {aa, n, ab} <- explode(a, depth+1) do
        {aa, [n, merge(ab, b)], 0}
      end ||
      with {ba, n, bb} <- explode(b, depth+1) do
        {0, [merge(a, ba), n], bb}
      end
    end
    def explode(_, _), do: false 

    def split([a, b]) do
      cond do
      a_split = split(a) -> [a_split, b]
      b_split = split(b) -> [a, b_split]
      true -> false
      end
    end
    def split(n) when n >= 10 do
      half = div(n, 2)
      [half, n - half]
    end
    def split(_), do: false

    def magnitude(n) when is_integer(n), do: n
    def magnitude([a, b]), do: 3*magnitude(a) + 2*magnitude(b) 

    def data(file \\ "day18.txt"), do: file |> File.read! |> String.split("\n", trim: true) |> Enum.map(fn line -> line |> Code.eval_string() |> elem(0) end)
end