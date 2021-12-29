defmodule Day15b do
  def neighbours({_, {x, y}}, visited, map) do
    [{x, y+1}, {x+1, y}, {x, y-1}, {x-1, y}]
    |> Enum.filter(&(!Map.has_key?(visited, &1) and Map.has_key?(map, &1)))
    |> Enum.map(&{map[&1], &1})
  end

  def next_edge(heap, visited) do
    {{cost, edge} = info, heap} = SkewHeap.pop(heap)
    if Map.has_key?(visited, edge) do
      next_edge(heap, visited)
    else
      {info, heap, Map.put(visited, edge, cost)}
    end
  end

  def search(heap, goal, visited, map) do
    {{path_cost, edge} = info, heap, visited} = next_edge(heap, visited) 
    if edge == goal do
      path_cost
    else
      info
      |> neighbours(visited, map)
      |> Enum.reduce(heap, fn {edge_cost, edge}, heap -> SkewHeap.push(heap, {edge_cost + path_cost, edge}) end)
      |> search(goal, visited, map)
    end 
  end

  def grids(row, col, num, n, k) do
    for i <- 0..(k-1) do
      for j <- 0..(k-1) do
        {{i*n + row, j*n + col}, Integer.mod(num + i + j - 1, 9) + 1}
      end
    end
  end

  def search(map, goal), do: search(SkewHeap.new() |> SkewHeap.push({0, {0,0}}), goal, %{}, map)
end

  "day15.txt"
  |> File.read!
  |> String.split("\n", trim: true)
  |> Enum.map(fn line -> line |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) |> Enum.with_index end)
  |> Enum.with_index
  |> Enum.map(fn {list, row} -> list |> Enum.map(fn {num, col} -> Day15b.grids(row, col, num, 100, 5) end) end)
  |> List.flatten
  |> Map.new
  |> Day15b.search({499,499})
  |> IO.inspect
