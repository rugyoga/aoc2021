defmodule Day20 do
    use Bitwise
    def parse_line(line), do: line |> String.split("", trim: true) |> Enum.map(&if(&1 == "#", do: 1, else: 0)) |> Enum.with_index
    def make_map(bits), do: bits |> Enum.map(fn{bit, index} -> {index, bit} end) |> Map.new
    def parse_grid(grid) do
        grid
        |> String.split("\n", trim: true)
        |> Enum.map(&parse_line/1)
        |> Enum.with_index
        |> Enum.map(fn {list, y} -> list |> Enum.map(fn {bit, x} -> {{x, y}, bit} end) |> Map.new end)
        |> Enum.reduce(&Map.merge/2)
    end

    def data(filename \\ "day20.txt") do
        [bits, grid] = filename |> File.read! |> String.split("\n\n", trim: true)
        {parse_line(bits) |> make_map, parse_grid(grid), 0}
    end

    def neighbours({bits, grid, _}, {x,y}, default) do
        on = &Map.get(&1, &2, default)
        on.(bits, Integer.undigits((for y_d <- -1..1, x_d <- -1..1, do: on.(grid, {x + x_d, y + y_d})), 2))
    end

    def step({bits, grid, step} = input) do
        default = bits[0] &&& step
        [{x_min, x_max}, {y_min, y_max}] = grid |> Map.keys |> Enum.unzip |> Tuple.to_list |> Enum.map(&Enum.min_max/1)
        for(x <- (x_min-2)..(x_max+2), y <- (y_min-2)..(y_max+2), into: Map.new, do: {{x, y}, neighbours(input, {x, y}, default)})
        |> then(&{bits, &1, step+1})
    end
end