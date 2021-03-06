low_point? = fn {{x, y}, value}, map ->
  [{x+1, y}, {x-1, y}, {x, y+1}, {x, y-1}]
  |> Enum.filter(&Map.has_key?(map, &1))
  |> Enum.all?(&(Map.get(map, &1) > value))
end

by_position =
  "day9.txt"
  |> File.read!
  |> String.split("\n", trim: true)
  |> Enum.map(fn line -> line |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) |> Enum.with_index end)
  |> Enum.with_index
  |> Enum.map(fn {list, row} -> list |> Enum.map(fn {num, col} -> {{row, col}, num} end) end)
  |> List.flatten
  |> Map.new

by_position
|> Enum.filter(&low_point?.(&1, by_position))
|> Enum.reduce(0, fn {_, value}, sum -> sum + value + 1 end)
|> IO.inspect
