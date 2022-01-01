numbers = Day18.data
for a <- numbers, b <- numbers, a != b do
    [Day18.magnitude(Day18.addition(a, b)), Day18.magnitude(Day18.addition(b, a))]
end
|> List.flatten
|> Enum.max
|> IO.inspect