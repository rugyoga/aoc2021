defmodule Day12b do
  def paths(x, path, graph, once, twice) do
    graph[x]
    |> Enum.filter(&(is_nil(twice) or (!MapSet.member?(once, &1) && twice != &1)))
    |> Enum.flat_map(
      fn "start" -> []
         "end" -> [["end" | path]]
         x ->
          if lower?(x) do
            if MapSet.member?(once, x) do
              paths(x, [x| path], graph, once, x)
            else
              paths(x, [x| path], graph, MapSet.put(once, x), twice)
            end
          else
            paths(x, [x| path], graph, once, twice)
          end
      end)
  end

  def lower?(s), do: s == String.downcase(s, :ascii)

  def add_node([a, b], map) do
    map
      |> Map.update(a, MapSet.new([b]), &MapSet.put(&1, b))
      |> Map.update(b, MapSet.new([a]), &MapSet.put(&1, a))
  end
end

paths =
  "day12.txt"
  |> File.read!
  |> String.split("\n", trim: true)
  |> Enum.map(&(String.split(&1, "-", trim: true)))

graph = paths |> Enum.reduce(%{}, &Day12b.add_node/2)

Day12b.paths("start", ["start"], graph, MapSet.new(), nil) |> length |> IO.inspect
