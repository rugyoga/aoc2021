defmodule Day9 do
    def neighbours({x, y}, by_position) do
        [{1,0}, {-1,0}, {0,1}, {0,-1}]
        |> Enum.map(fn {xd, yd} -> {x+xd, y+yd} end)
        |> Enum.filter(&Map.has_key?(by_position, &1))
    end

    def low_point?(point, by_position) do
        value = Map.get(by_position, point)
        point 
            |> neighbours(by_position) 
            |> Enum.all?(fn neighbour -> Map.get(by_position, neighbour) > value end)
    end
end

by_position =
    "day9.txt"
    |> File.read!
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> line |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) |> Enum.with_index end)
    |> Enum.with_index
    |> Enum.map(fn {list, row} -> list |> Enum.map(fn {num, col} -> {num, {row, col}} end) end)
    |> List.flatten
    |> Enum.reduce(%{}, fn {num, pos}, map -> Map.put(map, pos, num) end)

by_position
|> Map.keys
|> Enum.filter(&Day9.low_point?(&1, by_position))
|> Enum.map(&(Map.get(by_position, &1) + 1))
|> Enum.sum
|> IO.inspect
