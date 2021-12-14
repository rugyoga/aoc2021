defmodule Day14 do
  def cycle(chars, transforms) do
    chars
    |> Enum.chunk_every(2, 1)
    |> Enum.map(fn [a, _] = ab -> [a, transforms[Enum.join(ab, "")]]
                    [b] -> [b] end)
    |> List.flatten()
  end
end

[sequence, transforms] = "day14.txt" |> File.read! |> String.split("\n\n", trim: true)

transforms =
  transforms
  |> String.split("\n", trim: true)
  |> Enum.map(fn line -> line |> String.split(" -> ", trim: true) |> List.to_tuple end)
  |> Map.new

sequence = sequence |> String.codepoints|> Stream.iterate(&Day14.cycle(&1, transforms))
{{_,min}, {_, max}} = Enum.at(sequence, 10) |> Enum.frequencies() |> Enum.min_max_by(fn {_,y} -> y end)
IO.puts (max - min)
