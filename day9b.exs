defmodule Day9b do
  def neighbours({{x, y}, _}, map) do
    [{x+1, y}, {x-1, y}, {x, y+1}, {x, y-1}]
    |> Enum.filter(&Map.has_key?(map, &1))
    |> Enum.map(&{&1, map[&1]})
  end
    
  def low_point?({_, value} = pv, map) do
    neighbours(pv, map) |> Enum.all?(fn {_, v} -> v > value end)
  end

  def basin_rec({_, value} = low_point, map) do
    [low_point | 
     neighbours(low_point, map) 
     |> Enum.filter(fn {_, v} -> v > value end) 
     |> Enum.map(&basin_rec(&1, map))]
  end

  def basin(low_point, map), do: basin_rec(low_point, map) |> List.flatten

end

map =
  "day9.txt"
  |> File.read!
  |> String.split("\n", trim: true)
  |> Enum.map(fn line -> line |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) |> Enum.with_index end)
  |> Enum.with_index
  |> Enum.map(fn {list, row} -> list |> Enum.map(fn {num, col} -> {{row, col}, num} end) end)
  |> List.flatten
  #|> Enum.reject(fn {_, v} -> v == 9 end)
  |> Map.new

map
|> Enum.filter(&Day9b.low_point?(&1, map))
|> Enum.map(fn {_, v} -> v end)
|> Enum.sum
# |> Enum.map(&(Day9b.basin(&1, map) |> length))
# |> Enum.sort
# |> Enum.reverse
# |> Enum.take(-3)
# |> Enum.product
|> IO.inspect
 