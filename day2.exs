"day2.txt"
|> File.read!
|> String.split("\n", trim: true)
|> Enum.map(&String.split/1)
|> Enum.group_by(&List.first/1, fn [_, b] -> String.to_integer(b) end)
|> then(fn m -> (Enum.sum(m["down"]) - Enum.sum(m["up"])) * Enum.sum(m["forward"]) end)
|> IO.inspect