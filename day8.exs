"day8.txt"
 |> File.read!
 |> String.split("\n", trim: true)
 |> Enum.map(fn line -> line |> String.split(" | ") |> Enum.map(&String.split/1) end)
 |> Enum.map(fn [_, rhs] -> rhs |> Enum.map(&String.length/1) |> Enum.count(&(&1 in [2, 4, 3, 7])) end)
 |> Enum.sum
 |> IO.inspect
