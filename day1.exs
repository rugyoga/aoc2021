"day1.txt"
|> File.read!
|> String.split("\n", trim: true)
|> Enum.map(&String.to_integer/1)
|> Enum.chunk_every(2, 1, :discard)
|> Enum.filter(fn [a, b] -> a < b end)
|> length
|> IO.inspect
