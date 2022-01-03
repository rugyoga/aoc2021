defmodule Day24 do
    def data(filename \\ "Day24.txt") do
        filename
        |> File.read!
        |> String.split("\n", trim: true)
        |> Enum.map(&(&1 |> String.split(" ", trim: true) |> List.to_tuple))
    end

    #def var_or_num(op, state), do: if(Map.has_key?(state, op), do: state[op], else: String.to_integer(op))

    # def execute({"inp", op1}, {state, [x | input]}), do: {Map.put(state, op1, x), input}
    # def execute({"add", op1, op2}, {state, input}), do: {Map.update!(state, op1, &(&1 + var_or_num(op2, state))), input}    
    # def execute({"mul", op1, op2}, {state, input}), do: {Map.update!(state, op1, &(&1 * var_or_num(op2, state))), input}
    # def execute({"div", op1, op2}, {state, input}), do: {Map.update!(state, op1, &(div(&1, var_or_num(op2, state)))), input}   
    # def execute({"mod", op1, op2}, {state, input}), do: {Map.update!(state, op1, &(rem(&1, var_or_num(op2, state)))), input}    
    # def execute({"eql", op1, op2}, {state, input}), do: {Map.update!(state, op1, &(if(&1 == var_or_num(op2, state), do: 1, else: 0))), input}

    # def compute(instructions, input) do
    #     instructions |> Enum.reduce({%{"x" => 0, "y" => 0, "z" => 0, "w" => 0}, input}, &execute/2) |> elem(0)
    # end

    # inp w; mul x 0; add x z; mod x 26; div z p; add x q; eql x w; eql x 0; mul y 0; add y 25; mul y x; add y 1; mul z y; mul y 0; add y w; add y r; mul y x; add z y
    # every digit is parameterized on p, q, r. the only state that matters is z (x, y get zeroed out. w comes from input)
    def compute_one({{p, q, r}, w}, z) do
        x = rem(z, 26) 
        z = div(z, p)
        x = x + q
        x = if(x != w, do: 1, else: 0)
        y = 25 * x + 1
        z = z * y
        y = (w + r) * x
        z + y
    end

    def compute(digits) do
        [{1, 11, 3}, {1, 14, 7}, {1, 13, 1}, {26, -4, 6}, {1, 11, 14}, {1, 10, 7}, {26, -4, 9}, {26, -12, 9}, {1, 10, 6}, {26, -11, 4}, {1, 12, 0}, {26, -1, 7}, {26, 0, 12}, {26, -11, 1}]
        |> Enum.zip(digits)
        |> Enum.reduce(0, &compute_one/2)
    end

    def search(_instructions) do
        92967699949891..11111111111111
        |> Stream.map(&Integer.digits(&1, 10))
        |> Stream.filter(fn digits -> Enum.all?(digits, &(&1 != 0)) end)
        |> Enum.find(fn digits -> compute(digits) == 0 end)
        |> Integer.undigits
    end
end