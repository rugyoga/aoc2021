defmodule Day12 do
  def paths(graph, lower, parent, path, seen) do
    graph[parent]
    |> Enum.reject(fn child -> MapSet.member?(seen, child) end)
    |> Enum.flat_map(
      fn "end" -> [["end" | path]]
         child ->
          seen = if MapSet.member?(lower, child), do: MapSet.put(seen, child), else: seen
          paths(graph, lower, child, [child | path], seen)
      end)
  end

  def lower(graph), do: graph |> Map.keys |> Enum.filter(&(&1 == String.downcase(&1, :ascii))) |> MapSet.new

  def add_node([a, b], map), do: map |> Map.update(a, [b], &[b | &1]) |> Map.update(b, [a], &[a | &1])
end

"day12.txt"
|> File.read!
|> String.split("\n", trim: true)
|> Enum.map(&String.split(&1, "-", trim: true))
|> Enum.reduce(%{}, &Day12.add_node/2)
|> then(&Day12.paths(&1, Day12.lower(&1), "start", ["start"], MapSet.new(["start"])))
|> length
|> IO.inspect
