defmodule Day25 do
    @empty "."
    @east  ">"
    @south "v"
    @dirty true
    @clean false

    def data(filename \\ "day25.txt") do
        lines = filename |> File.read! |> String.split("\n", trim: true)
        map = lines
        |> Enum.with_index
        |> Enum.map(fn {line, y} -> line |> String.split("", trim: true) |> Enum.with_index |> Enum.map(fn {char, x} -> {{x, y}, char} end) end)
        |> List.flatten
        |> Enum.filter(&(elem(&1,1) != @empty))
        |> Map.new
        {x_max, y_max} = {String.length(List.first(lines)), Enum.count(lines)}
        move_east  = fn {x, y} -> {rem(x+1, x_max), y} end
        move_south = fn {x, y} -> {x, rem(y+1, y_max)} end
        {{map, @dirty}, {process(@east, move_east), process(@south, move_south) }}
    end

    def move(target, move, map) do
        fn {pos, ch} = original, dirty ->
            new_pos = move.(pos)
            if(ch != target or Map.has_key?(map, new_pos), do: {original, dirty}, else: {{new_pos, target}, @dirty})
        end
    end

    def process(target, move) do
        fn {map, dirty} ->
            local_move = move(target, move, map)
            map |> Enum.map_reduce(dirty, local_move) |> then(fn {items, dirty} -> {Map.new(items), dirty} end)
        end
    end

    def step({{map, _}, {process_east, process_south} = process}) do
        {map, @clean} |> then(process_east) |> then(process_south) |> then(&{&1, process})
    end
end