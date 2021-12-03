freqs = "day3.txt"
|> File.read!
|> String.split("\n", trim: true)
|> Enum.map(fn s -> s |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) end)
|> Enum.zip_with(&Enum.frequencies/1)

gamma = fn m -> if m[0] > m[1], do: "0", else: "1" end
epsilon = fn m -> if m[0] < m[1], do: "0", else: "1" end
combine = fn f -> freqs |> Enum.map(f) |> Enum.join |> String.to_integer(2) end

IO.inspect(combine.(gamma) * combine.(epsilon))