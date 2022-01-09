defmodule Day23 do
  @valid String.codepoints("ABCD.")

  def data do
    filename
    |> File.read!
    |> String.split("\n", trim: true)
    |> Enum.with_index
    |> Enum.map(fn {line, row} -> line |> String.split("", trim: true) |> Enum.with_index() |> Enum.filter(fn {ch, col} -> ch in @valid end) |> Enum.map() end)
  end
end
