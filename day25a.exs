Day25.data
|> Stream.iterate(&Day25.step/1)
|> Stream.take_while(fn {{_, dirty}, _} -> dirty end)
|> Enum.to_list
|> length
|> IO.inspect