"day2.txt"
|> File.read!
|> String.split("\n", trim: true)
|> Enum.map(&String.split/1)
|> Enum.map(fn [a, b] -> {a, String.to_integer(b)} end)
|> Enum.reduce(
	{0, 0, 0},
	fn {"up", x}, {aim, depth, distance} -> {aim - x, depth, distance}
           {"down", x}, {aim, depth, distance} -> {aim + x, depth, distance}
           {"forward", x}, {aim, depth, distance} -> {aim, depth + (aim * x), distance + x}
        end
)
|> then(fn {_, depth, distance} -> depth * distance end)
|> IO.inspect