defmodule Day13b do
  def folder(points, folds) do
    folds |> Enum.reduce(points, fn {dir, n}, points -> points |> Enum.map(&fold(dir, n, &1)) |> MapSet.new end)
  end

  def fold("x", n, {x, y} = p), do: if x > n, do: {n - (x-n), y}, else: p
  def fold("y", n, {x, y} = p), do: if y > n, do: {x, n - (y-n)}, else: p
end

[points, folds] = "day13.txt" |> File.read! |> String.split("\n\n", trim: true)

folds =
  folds
  |> String.split("\n", trim: true)
  |> Enum.map(&(&1 |> String.split("=") |> then(fn [x, num] -> {x |> String.codepoints |> List.last, String.to_integer(num)} end)))

points =
  points
  |> String.split("\n", trim: true)
  |> Enum.filter(&String.match?(&1, ~r/\d+/))
  |> Enum.map(fn line -> line |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1) |> List.to_tuple end)
  |> Day13b.folder(folds)

{x, y} = points |> Enum.unzip |> then(fn {xs, ys} -> {Enum.max(xs), Enum.max(ys)} end)

Enum.map_join(0..y, "\n", fn y -> Enum.map_join(0..x, "", fn x -> (if MapSet.member?(points, {x, y}), do: "#", else: " ") end)  end)
|> IO.puts()
