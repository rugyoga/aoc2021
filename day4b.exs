defmodule Day4b do
  def play([number | numbers], boards) do
    boards = boards |> Enum.map(&mark_board(number, &1))
    {finished, unfinished} = Enum.split_with(boards, &complete?/1)
    if Enum.empty?(unfinished) do
      finished |> List.first |> List.flatten |> Enum.filter(&(&1 != "M")) |> Enum.sum |> then(&(&1 * number))
    else
      play(numbers, unfinished)
    end
  end

  def mark_board(number, board), do: Enum.map(board, &mark_row(number, &1))

  def mark_row(_, []), do: []
  def mark_row(number, [n | row]) when n == number, do: ["M" | row]
  def mark_row(number, [n | row]), do: [n | mark_row(number, row)]

  def complete?(board), do: Enum.any?(board, fn row -> Enum.all?(row, &(&1 == "M")) end) ||
                            Enum.any?(Enum.zip_with(board, &(&1)), fn col -> Enum.all?(col, &(&1 == "M")) end)
end

[numbers | boards] = "day4.txt" |> File.read! |> String.split("\n\n", trim: true)
numbers = numbers |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1)
boards = 
  boards
  |> Enum.map(fn b -> b |> String.split("\n", trim: true) |> Enum.map(fn r -> r |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1) end) end)

Day4b.play(numbers, boards) |> IO.inspect