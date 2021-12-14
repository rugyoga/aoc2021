defmodule Day14 do
  def cycle(freqs, transforms) do
    freqs
    |> Enum.map(fn {[a, b] = ab, count} -> tx_ab = transforms[ab]; [{[a, tx_ab], count}, {[tx_ab, b], count}]; x -> x end)
    |> List.flatten
    |> Enum.reduce(%{}, fn {l, count}, counts -> Map.update(counts, l, count, &(&1 + count)) end)
  end
end

[sequence, transforms] = "day14.txt" |> File.read! |> String.split("\n\n", trim: true)

transforms =
  transforms
  |> String.split("\n", trim: true)
  |> Enum.map(fn line -> line |> String.split(" -> ", trim: true) |> List.to_tuple |> then(fn {lhs, rhs} -> {String.split(lhs, "", trim: true), rhs} end) end)
  |> Map.new

{{_, min}, {_, max}} =
  sequence
  |> String.codepoints
  |> Enum.chunk_every(2, 1)
  |> Enum.frequencies
  |> Stream.iterate(&Day14.cycle(&1, transforms))
  |> Enum.at(40)
  |> Enum.reduce(%{}, fn {chars, count}, counts -> Map.update(counts, chars |> List.first, count, &(&1 + count)) end)
  |> Enum.min_max_by(fn {_, count} -> count end)

IO.puts(max-min)
