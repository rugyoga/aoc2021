Day20.data()
|> Stream.iterate(&Day20.step/1)
|> Enum.at(50)
|> then(fn {_bits, grid, _} -> grid |> Enum.filter(fn {_, v} -> v == 1 end) |> Enum.count end)
|> IO.inspect