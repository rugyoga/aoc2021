defmodule Day9b do
  def neighbours({x, y}, map) do
    [{x+1, y}, {x-1, y}, {x, y+1}, {x, y-1}]
    |> Enum.filter(&(Map.has_key?(map, &1))
    |> Enum.map(&{&1, map[&1]})
  end

  def upward({point, value}, map) do
    neighbours(point) |> Enum.filter(&(elem(&1, 1) > value))
  end

  def expand(current, basin, map) do
    upward(current, map) |> Enum.reduce(&expand(&1, &2, map))
  end
end

by_position =
  "day9.txt"
  |> File.read!
  |> String.split("\n", trim: true)
  |> Enum.map(fn line -> line |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) |> Enum.with_index end)
  |> Enum.with_index
  |> Enum.map(fn {list, row} -> list |> Enum.map(fn {num, col} -> {{row, col}, num} end) end)
  |> List.flatten
  |> Enum.reject(fn {_, v} -> v == 9 end)
  |> Map.new

low_points =
  |> Enum.reduce(%{}, fn item, path -> basin(item, path, data) |> elem(1) end)
  |> Enum.map(&elem(&1, 1))
  |> Enum.frequencies()
  |> Map.values()
  |> Enum.sort()
  |> Enum.take(-3)
  |> Enum.product()
low_points = by_position |> Enum.filter(&low_point?.(&1, by_position))
