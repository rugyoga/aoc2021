"day7.txt"
 |> File.read!
 |> String.split(",")
 |> Enum.map(&String.to_integer/1)
 |> Enum.frequencies
 |> then(fn m -> 
     {min, max} = m |> Map.keys |> Enum.min_max();
     Enum.map(min..max, fn col -> m |> Enum.map(fn {crab, count} -> count * abs(crab - col) end) |> Enum.sum end) 
     end)
 |> Enum.min
 |> IO.inspect
