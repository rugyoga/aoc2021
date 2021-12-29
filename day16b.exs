defmodule Day16b do
    def evaluate({_version, 0, parts}), do: parts |> Enum.map(&evaluate/1) |> Enum.sum
    def evaluate({_version, 1, parts}), do: parts |> Enum.map(&evaluate/1) |> Enum.product
    def evaluate({_version, 2, parts}), do: parts |> Enum.map(&evaluate/1) |> Enum.min
    def evaluate({_version, 3, parts}), do: parts |> Enum.map(&evaluate/1) |> Enum.max
    def evaluate({_version, 4, value}), do: value
    def evaluate({_version, 5, [a, b]}), do: if(evaluate(a) > evaluate(b), do: 1, else: 0)
    def evaluate({_version, 6, [a, b]}), do: if(evaluate(a) < evaluate(b), do: 1, else: 0)
    def evaluate({_version, 7, [a, b]}), do: if(evaluate(a) == evaluate(b), do: 1, else: 0)
end

Day16.data |> Day16b.evaluate |> IO.inspect