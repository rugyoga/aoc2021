defmodule Day10 do
    @match %{"{" => "}", "[" => "]", "(" => ")", "<" => ">"}
    @value %{ ")" => 1, "]" => 2, "}" => 3, ">" => 4}
    def find_error([], ys), do: ys
    def find_error([x | xs], [y | ys]) when x == y, do: find_error(xs, ys)
    def find_error([x | xs], ys) do
        if Map.has_key?(@match, x) do
          find_error(xs, [@match[x] | ys])
        else
          nil
        end
    end
    
    def score([], v), do: v
    def score([x | xs], v), do: score(xs, v*5 + @value[x])

    def middle(xs), do: Enum.at(xs, div(length(xs),2))
end

"day10.txt"
|> File.read!
|> String.split("\n", trim: true)
|> Enum.map(&String.codepoints/1)
|> Enum.map(&Day10.find_error(&1, []))
|> Enum.filter(&(&1 != nil))
|> Enum.map(&Day10.score(&1,0))
|> Enum.sort
|> Day10.middle
|> IO.inspect