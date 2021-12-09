"day9.txt"
 |> File.read!
 |> String.split("\n", trim: true)
 |> Enum.map(&(&1 |> String.split("", trim: true) |> Enum.map(&String.to_integer/1)))
 |> IO.inspect
