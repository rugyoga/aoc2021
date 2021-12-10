defmodule Day10 do
    @match %{"{" => "}", "[" => "]", "(" => ")", "<" => ">"}
    def find_error([], ys), do: ys
    def find_error([x | xs], [y | ys]) when x == y, do: find_error(xs, ys)
    def find_error([x | xs], ys) do
        if Map.has_key?(@match, x) do
          find_error(xs, [@match[x] | ys])
        else
          nil
        end
    end
end

value = %{ ")" => 1, "]" => 2, "}" => 3, ">" => 4}

"day10.txt"
|> File.read!
|> String.split("\n", trim: true)
|> Enum.map(&String.codepoints/1)
|> Enum.map(&Day10.find_error(&1, []))
|> Enum.filter(&(&1 != nil))
|> Enum.map(&Enum.reduce(&1, 0, fn x, v -> v*5 + value[x] end))
|> Enum.sort
|> then(&Enum.at(&1, div(length(&1),2)))
|> IO.inspect