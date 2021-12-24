defmodule Day9b do
  def neighbours({{x, y}, _}, map) do
    [{x+1, y}, {x-1, y}, {x, y+1}, {x, y-1}]
    |> Enum.filter(&(Map.has_key?(map, &1)))
    |> Enum.map(&{&1, map[&1]})
  end

  def low_point?({_, value} = pv, map), do: pv |> neighbours(map)|> Enum.all?(fn {_, v} -> v > value end)

  def upward({_, value} = pv, map), do: pv |> neighbours(map) |> Enum.filter(fn {_, v} -> v > value end)

  def basin_rec(x, map), do: [x | upward(x, map) |> Enum.map(&basin_rec(&1, map))]

  def basin(x, map), do: basin_rec(x, map) |> List.flatten |> Enum.uniq
end

map =
  "day9.txt"
  |> File.read!
  |> String.split("\n", trim: true)
  |> Enum.map(fn line -> line |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) |> Enum.with_index end)
  |> Enum.with_index
  |> Enum.map(fn {list, row} -> list |> Enum.map(fn {num, col} -> {{row, col}, num} end) end)
  |> List.flatten
  |> Enum.reject(fn {_, v} -> v == 9 end)
  |> Map.new

map
  |> Enum.filter(&Day9b.low_point?(&1, map))
  |> Enum.map(&(&1 |> Day9b.basin(map) |> length))
  |> Enum.sort()
  |> Enum.take(-3)
  |> Enum.product()
  |> IO.inspect
