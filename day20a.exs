Day20.data()
|> Day20.step
|> Day20.step
|> then(fn {_bits, grid, _} -> grid |> Enum.filter(fn {_, v} -> v == 1 end) |> Enum.count end)
|> IO.inspect