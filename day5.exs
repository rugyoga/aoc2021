defmodule Day5 do
  def update(position, counts), do: Map.update(counts, position, 1, &(&1+1))
end

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
        step = if y1 < y2, do: 1, else: -1
        for y <- y1..y2//step, do: [x1, y]
     else
      if y1 == y2 do
          step = if x1 < x2, do: 1, else: -1
          for x <- x1..x2//step, do: [x, y1]
      else
          []
      end
     end
     |> Enum.reduce(counts, &Day5.update/2)
   end
 )
 |> Enum.filter(fn {_, count} -> count >= 2 end)
 |> length
 |> IO.inspect