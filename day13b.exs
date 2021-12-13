defmodule Day13 do
  def folder(folds, points) do
    folds |> Enum.reduce(points, fn {dir, n}, points -> points |> Enum.map(&fold(dir, n, &1)) |> MapSet.new end)
  end

  def fold("x", n, {x, y} = p), do: if x > n, do: {n - (x-n), y}, else: p
  def fold("y", n, {x, y} = p), do: if y > n, do: {x, n - (y-n)}, else: p
end

[coords, folds] =
  "day13.txt"
  |> File.read!
  |> String.split("\n\n", trim: true)


 coords =
  coords
  |> String.split("\n", trim: true)
  |> Enum.filter(&String.match?(&1, ~r/\d+/))
  |> Enum.map(fn line -> line |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1) |> then(fn [x, y] -> {x, y} end) end)
  |> MapSet.new

folds =
  folds
  |> String.split("\n", trim: true)
  |> Enum.map(fn line ->
                line
                |> String.split("=")
                |> then(fn [x, num] -> {x |> String.codepoints |> Enum.reverse |> List.first, String.to_integer(num)} end)
  end)

  points = Day13.folder(folds, coords)
  {x, _} = points |> Enum.max_by(fn {x, _} -> x end)
  {_, y} = points |> Enum.max_by(fn {_, y} -> y end)

  Enum.map(0..y, fn y -> Enum.map(0..x, fn x -> (if MapSet.member?(points, {x, y}), do: "X", else: " ") end) |> Enum.join("") end)
  |> Enum.join("\n")
  |> IO.puts()
