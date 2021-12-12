defmodule Day12 do

  def paths(x, path, graph, seen) do
    graph[x]
    |> Enum.reject(&MapSet.member?(seen, &1))
    |> Enum.flat_map(
      fn "end" -> [["end" | path]]
         x -> paths(x, [x| path], graph, (if lower?(x), do: MapSet.put(seen, x), else: seen))
      end)
  end

  def lower?(s), do: s == String.downcase(s, :ascii )
end

paths =
  "day12.txt"
  |> File.read!
  |> String.split("\n", trim: true)
  |> Enum.map(&(String.split(&1, "-", trim: true)))

graph =
  paths
  |> Enum.reduce(%{}, fn [a, b], map ->

  map
   |> Map.update(a, MapSet.new([b]), &MapSet.put(&1, b))
   |> Map.update(b, MapSet.new([a]), &MapSet.put(&1, a))
  end)
|> IO.inspect

Day12.paths("start", ["start"], graph, MapSet.new(["start"]))
|> length
|> IO.inspect
