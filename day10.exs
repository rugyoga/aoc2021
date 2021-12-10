defmodule Day10 do
    @match %{"{" => "}",
             "[" => "]",
             "(" => ")",
             "<" => ">"}
    @value %{ ")" => 3,
              "]" => 57,
             "}" => 1197,
             ">" => 25137}
    def find_error([], _), do: nil
    def find_error([x | xs], [y | ys]) when x == y, do: find_error(xs, ys)
    def find_error([x | xs], ys) do
        if Map.has_key?(@match, x) do
          find_error(xs, [@match[x] | ys])
        else
          x
        end
    end
    
    def score(x), do: @value[x]
end

"day10.txt"
|> File.read!
|> String.split("\n", trim: true)
|> Enum.map(&String.codepoints/1)
|> Enum.map(&Day10.find_error(&1, []))
|> Enum.filter(&(&1 != nil))
|> Enum.map(&Day10.score/1)
|> Enum.sum
|> IO.inspect