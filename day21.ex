defmodule Day21 do
    def natural_rem(n, k), do: 1+rem(n-1, k)
    def move(state, win \\ 1000) do
        roll = natural_rem(state.dice + 2, 100)
        move = if(roll > state.dice, do: Enum.sum(state.dice..roll), else: Enum.sum(state.dice..100) + Enum.sum(1..roll))
        new_position = natural_rem(state.first.position + move, 10)
        new_score = state.first.score + new_position
        if new_score >= win do
            3 * state.n * state.second.score
        else
            state = %{dice: natural_rem(roll+1, 100), n: state.n + 1, first: state.second, second: %{ position: new_position, score: new_score }}
            move(state)
        end
    end

    def move(state, path, dirac_scores, win) do
        if state.second.score >= win do
            [{ rem(state.n, 2), Enum.map(path, &(dirac_scores[&1])) |> Enum.product }]
        else
            for move <- 3..9 do
                new_position = natural_rem(state.first.position + move, 10)
                new_score = state.first.score + new_position
                move(%{n: state.n + 1, first: state.second, second: %{ position: new_position, score: new_score }}, [move | path], dirac_scores, win)
            end
        end
    end

    def dirac_dice(p1, p2) do
        dirac_scores = for(x <- 1..3, y <- 1..3, z <- 1..3, do: x + y + z) |> Enum.frequencies
        move(%{n: 1, first: %{position: p1, score: 0}, second: %{position: p2, score: 0}}, [], dirac_scores, 21)
        |> List.flatten
        |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))
        |> Enum.map(fn {player, counts} -> {player, Enum.sum(counts)} end)
    end
end