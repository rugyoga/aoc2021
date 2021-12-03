defmodule Day3 do
  def finder(bits, _, _) when length(bits) == 1, do: bits |> List.first |> Enum.join |> String.to_integer(2)
  def finder(bits, f, i) do
    get = &Enum.at(&1, i)
    target = bits |> Enum.map(get) |> Enum.frequencies |> f.()
    bits |> Enum.filter(&(get.(&1) == target)) |> finder(f, i+1)
  end

  def oxygen(freqs), do: if map_size(freqs) == 1, do: Map.keys(freqs) |> List.first, else: if freqs[1] >= freqs[0], do: 1, else: 0
  def carbon(freqs), do: if map_size(freqs) == 1, do: Map.keys(freqs) |> List.first, else: if freqs[0] <= freqs[1], do: 0, else: 1
end

bits = "day3.txt"
|> File.read!
|> String.split("\n", trim: true)
|> Enum.map(fn s -> s |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) end)

IO.inspect(Day3.finder(bits, &Day3.oxygen/1, 0) * Day3.finder(bits, &Day3.carbon/1, 0))
