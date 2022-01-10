Day25.data
|> Stream.iterate(&Day25.step/1)
|> Enum.take_while(fn {{_, dirty}, _} -> dirty end)
|> length
|> IO.inspect