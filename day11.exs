defmodule Day11 do
  def neighbours({x, y}, map) do
    [{x, y+1}, {x+1, y+1}, {x+1, y}, {x+1, y-1}, {x, y-1}, {x-1, y-1}, {x-1, y}, {x-1, y+1}]
    |> Enum.filter(&Map.has_key?(map, &1))
  end

  def cycle(map) do
    map
    |> Map.keys
    |> Enum.reduce(map, &energize/2)
    |> Enum.map(fn {point, value} -> if value > 9, do: {point, 0}, else: {point, value} end)
    |> Map.new
  end

  def energize(point, map) do
    map = Map.update!(map, point, &(&1 + 1))
    if Map.fetch!(map, point) == 10, do: neighbours(point, map) |> Enum.reduce(map, &energize/2), else: map
  end
end

by_position =
  "day11.txt"
  |> File.read!
  |> String.split("\n", trim: true)
  |> Enum.map(fn line -> line |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) |> Enum.with_index end)
  |> Enum.with_index
  |> Enum.map(fn {list, row} -> list |> Enum.map(fn {num, col} -> {{row, col}, num} end) end)
  |> List.flatten
  |> Map.new

by_position
|> Stream.iterate(&Day11.cycle/1)
|> Enum.take(101)
|> Enum.map(&Enum.count(&1, fn {_, value} -> value == 0 end))
|> Enum.sum()
|> IO.inspect
