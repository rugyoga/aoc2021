defmodule Day3 do
  def finder(bits, _, _) when length(bits) == 1, do: bits |> List.first |> Enum.join |> String.to_integer(2)
  def finder(bits, f, i) do
    get = &Enum.at(&1, i)
    target = bits |> Enum.map(get) |> Enum.frequencies |> f.()
    bits |> Enum.filter(&(get.(&1) == target)) |> finder(f, i+1)
  end

  def p(freqs, a, b), do: if map_size(freqs) == 1, do: Map.keys(freqs) |> List.first, else: if freqs[0] <= freqs[1], do: a, else: b
end

bits = "day3.txt"
|> File.read!
|> String.split("\n", trim: true)
|> Enum.map(fn s -> s |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) end)

IO.inspect(Day3.finder(bits, &Day3.p(&1, 1, 0), 0) * Day3.finder(bits, &Day3.p(&1, 0, 1), 0))
