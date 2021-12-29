defmodule Day17 do
  def step_vx(vx), do: if(vx > 0, do: vx-1, else: if(vx < 0, do: vx+1, else: 0))
  def step_vy(vy), do: vy-1
  def step({{x, y}, {vx, vy}}), do: {{x + vx, y + vy}, {step_vx(vx), step_vy(vy)}}

  def hits({x_min..x_max = x_target, y_min.._y_max = y_target} \\ {139..187, -148..-89}) do
    vx_min = 1..x_min |> Enum.find(fn x -> x*(x+1)/2 >= x_min end)

    for vx <- vx_min..x_max do
      for vy <- y_min..-y_min do
        Stream.iterate({{0, 0}, {vx, vy}}, &step/1) |> Stream.take_while(fn {{_, y}, _} -> y >= y_min end)
      end
    end
    |> List.flatten
    |> Enum.map(&Enum.to_list/1)
    |> Enum.filter(&Enum.any?(&1, fn {{x,y}, _} -> x in x_target and y in y_target end))
  end
end
