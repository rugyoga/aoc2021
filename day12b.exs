defmodule Day12b do

  def paths(x, path, graph, once, twice) do
    graph[x]
    |> Enum.filter(
      fn x ->
        if MapSet.size(twice) == 0 do
          true
        else
          !MapSet.member?(once, x) && !MapSet.member?(twice, x)
        end
      end)
    |> Enum.flat_map(
      fn "start" -> []
         "end" -> [["end" | path]]
         x ->
          if lower?(x) do
            if MapSet.member?(once, x) do
              paths(x, [x| path], graph, once, MapSet.new([x]))
            else
              paths(x, [x| path], graph, MapSet.put(once, x), twice)
            end
          else
            paths(x, [x| path], graph, once, twice)
          end
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

Day12b.paths("start", ["start"], graph, MapSet.new(), MapSet.new())
|> length
|> IO.inspect
