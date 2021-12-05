line = fn a, b -> if a == b, do: Stream.cycle([a]), else: a..b end

"day5.txt"
 |> File.read!
 |> String.split("\n", trim: true)
 |> Enum.map(fn x -> x
                |> String.split(" -> ", trim: true)
                |> Enum.map(fn pair -> pair |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1) end)
                end)
 |> Enum.map( fn [[x1, y1], [x2, y2]] -> if x1 != x2 && y1 != y2, do: [], else: Enum.zip(line.(x1, x2), line.(y1, y2)) end)
 |> List.flatten
 |> Enum.frequencies
 |> Enum.filter(fn {_, count} -> count >= 2 end)
 |> length
 |> IO.inspect
