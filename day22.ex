defmodule Day22 do
    def data(filename \\ "day22.txt") do
        filename
        |> File.read!
        |> String.split("\n", trim: true)
        |> Enum.map(fn line -> line 
                                |> String.split(" ", trim: true)
                                |> then(fn [a, b] -> {a, b 
                                                         |> String.split(",", trim: true) 
                                                         |> Enum.map(fn line -> line 
                                                                                |> String.split("=")
                                                                                |> then(fn [var, range] -> {var, Code.eval_string(range) |> elem(0)} end) end)} end) end)

    end

    @core_range -50..50

    def ignore?(range), do: Range.disjoint?(@core_range, range)

    def process(lines) do
        map = %{ "on" => 1, "off" => 0}
        lines
        |> Enum.reduce(
            %{},
            fn {verb, [{"x", x_range}, {"y", y_range}, {"z", z_range}]}, core ->
                if ignore?(x_range) or ignore?(y_range) or ignore?(z_range) do
                    core
                else
                    for x <- @core_range, Enum.member?(x_range, x) do
                        for y <- @core_range, Enum.member?(y_range, y) do
                            for z <- @core_range, Enum.member?(z_range, z) do
                                {{x, y, z}, map[verb]}
                            end
                        end
                    end
                    |> List.flatten
                    |> Enum.reduce(core, fn {p, v}, core -> Map.put(core, p, v) end)
                end
            end
        )
    end

    def cube_intersection({x1, y1, z1})


    def process_cubes(lines) do
        map = %{ "on" => 1, "off" => 0}
        lines
        |> Enum.reduce(
            %{},
            fn {verb, [{"x", x_range}, {"y", y_range}, {"z", z_range}]}, core ->
                if ignore?(x_range) or ignore?(y_range) or ignore?(z_range) do
                    core
                else
                    for x <- @core_range, Enum.member?(x_range, x) do
                        for y <- @core_range, Enum.member?(y_range, y) do
                            for z <- @core_range, Enum.member?(z_range, z) do
                                {{x, y, z}, map[verb]}
                            end
                        end
                    end
                    |> List.flatten
                    |> Enum.reduce(core, fn {p, v}, core -> Map.put(core, p, v) end)
                end
            end
        )
    end
end