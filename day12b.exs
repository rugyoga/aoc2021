defmodule Day12b do
  def paths(graph, lower, parent, path, once, twice) do
    graph[parent]
    |> Enum.filter(&(is_nil(twice) or (!MapSet.member?(once, &1) && twice != &1)))
    |> Enum.flat_map(
      fn "start" -> []
         "end" -> [["end" | path]]
         child ->
          if MapSet.member?(lower, child) do
            if MapSet.member?(once, child) do
              paths(graph, lower, child, [child | path], once, child)
            else
              paths(graph, lower, child, [child | path], MapSet.put(once, child), twice)
            end
          else
            paths(graph, lower, child, [child | path], once, twice)
          end
      end)
  end

  def lower(graph), do: graph |> Map.keys |> Enum.filter(&(&1 == String.downcase(&1, :ascii))) |> MapSet.new

  def add_node([a, b], map), do: map |> Map.update(a, [b], &[b | &1]) |> Map.update(b, [a], &[a | &1])
end

"day12.txt"
|> File.read!
|> String.split("\n", trim: true)
|> Enum.map(&String.split(&1, "-", trim: true))
|> Enum.reduce(%{}, &Day12b.add_node/2)
|> then(&Day12b.paths(&1, Day12b.lower(&1), "start", ["start"], MapSet.new(["start"]), nil))
|> length
|> IO.inspect
