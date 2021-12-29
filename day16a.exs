defmodule Day16a do
    def sum(x) when is_list(x), do: x |> Enum.map(&sum/1) |> Enum.sum
    def sum({version, _type, parts}), do: version + sum(parts)
    def sum(_), do: 0
end

Day16.data |> Day16a.sum |> IO.inspect