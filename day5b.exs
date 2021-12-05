"day5.txt"
 |> File.read!
 |> String.split("\n", trim: true)
 |> Enum.map(fn x -> 
                x 
                |> String.split(" -> ", trim: true)
                |> Enum.map(fn pair -> pair |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1) end)
                end)
 |> Enum.reduce(
   %{},
   fn [[x1, y1], [x2, y2]], counts ->
     if x1 == x2 do
       Enum.map(y1..y2, &[x1, &1])
     else
       if y1 == y2, do: Enum.map(x1..x2, &[&1, y1]), else: Enum.zip_with(x1..x2, y1..y2, &[&1, &2])
     end
     |> Enum.reduce(counts, fn position, counts -> Map.update(counts, position, 1, &(&1+1)) end)
   end
 )
 |> Enum.filter(fn {_, count} -> count >= 2 end)
 |> length
 |> IO.inspect