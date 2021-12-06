defmodule Day6 do
  def cycle(fish, 0), do: fish
  def cycle(fish, n) do
    zero_count = Map.get(fish, 0, 0)
    fish
    |> Enum.filter(fn {n, _} -> n > 0 end)
    |> Enum.map(fn {n, k} -> {n-1, k} end)
    |> Map.new
    |> Map.update(6, zero_count, &(&1 + zero_count))
    |> Map.put(8, zero_count)
    |> cycle(n-1)
  end
end

"day6.txt"
 |> File.read!
 |> String.trim
 |> String.split(",", trim: true)
 |> Enum.map(&String.to_integer/1)
 |> Enum.frequencies
 |> Day6.cycle(256)
 |> Map.values
 |> Enum.sum
 |> IO.inspect
