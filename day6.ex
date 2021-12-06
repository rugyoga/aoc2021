defmodule Day6 do
  def cycle(fish, 0), do: fish
  def cycle(fish, n) do
    {zero_count, fish} = Map.pop(fish, 0, 0)
    fish
    |> Enum.map(fn {n, k} -> {n-1, k} end)
    |> Enum.into(%{8 => zero_count})
    |> Map.update(6, zero_count, &(&1 + zero_count))
    |> cycle(n-1)
  end

  def run(n) do
    "day6.txt"
    |> File.read!
    |> String.trim
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.frequencies
    |> cycle(n)
    |> Map.values
    |> Enum.sum
  end
end
