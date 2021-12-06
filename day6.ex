defmodule Day6 do
  def cycle(fish) do
    {zero_count, fish} = Map.pop(fish, 0, 0)
    fish
    |> Enum.map(fn {n, k} -> {n-1, k} end)
    |> Map.new
    |> Map.merge(%{6 => zero_count, 8 => zero_count}, fn _, x, y -> x + y end)
  end

  def run(n) do
    "day6.txt"
    |> File.read!
    |> String.trim
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.frequencies
    |> Stream.iterate(&cycle/1)
    |> Enum.at(n)
    |> Map.values
    |> Enum.sum
  end
end
