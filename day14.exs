defmodule Day14 do
  def cycle(chars, transforms) do
    chars
    |> Enum.chunk_every(2, 1)
    |> Enum.map(fn [a, _] = ab -> [a, transforms[Enum.join(ab, "")]]
                    [b] -> [b] end)
    |> List.flatten()
  end
end

[sequence, transforms] =
  "day14.txt"
  |> File.read!
  |> String.split("\n\n", trim: true)

transforms =
  transforms
  |> String.split("\n", trim: true)
  |> Enum.map(fn line -> line |> String.split(" -> ", trim: true) |> List.to_tuple end)
  |> Map.new
  |> IO.inspect

sequence = sequence |> String.codepoints|> Stream.iterate(&Day14.cycle(&1, transforms))

sorted = Enum.at(sequence, 40) |> Enum.frequencies() |> Enum.sort_by(fn {_,y} -> y end)
tenth = sorted
IO.puts (List.last(sorted) |> elem(1)) - (List.first(sorted) |> elem(1))
