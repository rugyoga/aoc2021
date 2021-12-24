defmodule Day15 do
  def neighbours({cost, {x, y}}, map, visited) do
    [{x, y+1}, {x+1, y}] #, {x, y-1}, {x-1, y}]
    |> Enum.filter(&Map.has_key?(map, &1) and !MapSet.member?(visited, &1))
    |> Enum.map(&{cost+map[&1], &1})
    |> Enum.sort
  end

  def search(_, goal, [{cost, p} | _], _) when goal == p, do: cost
  def search(map, goal, [edge | edges], visited), do: search(map, goal, merge(edges, neighbours(edge, map, visited)), MapSet.put(visited, edge))

  def merge(as, []), do: as
  def merge([], bs), do: bs
  def merge([a | as] = l1, [b | bs] = l2), do: if a < b, do: [a | merge(as, l2)], else: [b | merge(l1, bs)]


  #def insert (a, {nil, x, size, right}) when a < x, do: insert(x, {{nil, }})
  def (start, goal)
end

  "day11.txt"
  |> File.read!
  |> String.split("\n", trim: true)
  |> Enum.map(fn line -> line |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) |> Enum.with_index end)
  |> Enum.with_index
  |> Enum.map(fn {list, row} -> list |> Enum.map(fn {num, col} -> {{row, col}, num} end) end)
  |> List.flatten
  |> Map.new
  #|> Day15.search({99, 99}, [{0, {0,0}}], MapSet.new([{0,0}]))
  |> IO.inspect
