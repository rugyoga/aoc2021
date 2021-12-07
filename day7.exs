"day7.txt"
 |> File.read!
 |> String.trim
 |> String.split(",")
 |> Enum.map(&String.to_integer/1)
 |> then(fn l -> {min, max} = Enum.min_max(l); Enum.map(min..max, fn col -> l |> Enum.map(&(abs(col - &1))) |> Enum.sum end) end)
 |> Enum.min
 |> IO.inspect
