defmodule Day8b do

    def segments_to_numbers(digits) do
        digits
            |> Enum.map(&String.split(&1, "", trim: true))
            |> Enum.zip(0..9)
            |> Enum.reduce(
                %{},
                fn {segments, digit}, map -> 
                    segments |>
                    Enum.reduce(map,
                        fn segment, map ->
                             map |> Map.update(segment, [digit], &([digit | &1]))
                        end)
                end)
            |> Enum.group_by(fn {_segment, numbers} -> length(numbers) end)
    end

    def read_input(filename) do
        filename
            |> File.read!
            |> String.split("\n", trim: true)
            |> Enum.map(fn line -> line |> String.split(" | ") |> Enum.map(&String.split/1) end)
    end

    def find_by_length(lhs, length), do: lhs |> Enum.find(fn s -> String.length(s) == length end) |> String.split("", trim: true)

    def solve([lhs, rhs], segments_map) do
        map = lhs |> segments_to_numbers
        get_segments = fn x -> map[x] |> Enum.unzip |> elem(0) end
        one = lhs |> find_by_length(2) |> MapSet.new
        four = lhs |> find_by_length(4) |> MapSet.new
        g_or_d = get_segments.(7) |> MapSet.new
        a_or_c = get_segments.(8) |> MapSet.new
        translation = %{ 
            MapSet.difference(a_or_c, one) |> Enum.at(0) => "a",
            get_segments.(6) |> Enum.at(0) => "b",
            MapSet.intersection(a_or_c, one) |> Enum.at(0) => "c",
            MapSet.intersection(g_or_d, four) |> Enum.at(0) => "d",
            get_segments.(4) |> Enum.at(0) => "e",
            get_segments.(9) |> Enum.at(0) => "f",
            MapSet.difference(g_or_d, four) |> Enum.at(0) => "g",
         }
       rhs 
       |> Enum.map(fn segments -> segments |> String.split("", trim: true) |> Enum.map(&(translation[&1])) |> Enum.sort |> Enum.join("") |> then(&segments_map[&1]) end)
       |> then(fn [a, b, c, d] -> 1000*a + 100*b + 10*c + d end)
    end
end

map = %{ "abcefg" => 0, "cf" => 1, "acdeg" => 2, "acdfg" => 3, "bcdf" => 4, "abdfg" => 5, "abdefg" => 6, "acf" => 7, "abcdefg" => 8, "abcdfg" => 9}

"day8.txt"
    |> Day8b.read_input()
    |> Enum.map(&Day8b.solve(&1, map))
    |> Enum.sum
    |> IO.inspect
