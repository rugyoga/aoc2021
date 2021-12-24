defmodule Day17 do
  @target {139..187, -148..-89}

  def step_x(x, vx), do: x + v_x + if(x > 0, do: -1, else: if(x < 0, do: 1 else: 0))
  def step_y(y, vy), do: y + v_y - 1

  def compute(start, f, min..max) do
    Stream.iterate(start, f)
    |> Enum.take_while(&(&1 > min))
  end

  def compute({x_target_min..x_target_max, y__target_min..y_target_max} = target \\ @target) do
    x_min = 1..x_target_min |> Enum.find(fn x -> x*(x+1)/2 >= x_min end)

    Enum.reduce(x_min..x_target_max, [], fn vx, acc ->
      Enum.reduce(y_target_min..100, acc, fn vy, acc ->
        Stream.iterate({{0, 0}, {vx, vy}}, &step/1)
        |> Stream.drop_while(fn {{x, y}, {vx, vy}} -> (x < x_target_min and vx > 0) or y > y_target_max end)
        |> Stream.take_while(fn {{x, y}, _}) -> x in x_target and y in y_target end
      end)
    end)
      Stream.iterate({0,0}, )
  end


end

Day17.compute() |> IO.inspect
