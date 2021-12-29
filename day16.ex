defmodule Day16 do
    def bits_to_int(bits), do: bits |> Enum.join("") |> String.to_integer(2)
    def n_bits_to_int(bits, n), do: bits |> Enum.split(n) |> on_tuple(0, &bits_to_int/1)

    def on_tuple(t, i, f), do: put_elem(t, i, f.(elem(t, i)))

    def parse_literal(["1" | bits], accum), do: parse_literal(Enum.drop(bits, 4), [Enum.take(bits, 4) | accum])
    def parse_literal(["0" | bits], accum), do: Enum.split(bits, 4) |> on_tuple(0, fn x -> [x | accum] |> Enum.reverse |> List.flatten |> bits_to_int end)

    def parse_packet(bits) do
        {version, bits} = bits |> n_bits_to_int(3)
        {type, bits} = bits |> n_bits_to_int(3)
        {packet, bits} = if(type == 4, do: parse_literal(bits, []), else: parse_operator(bits))
        {{version, type, packet}, bits}
    end

    def parse_packets(bits, ps, n) when length(bits) == 0 or n == 0, do: {ps |> Enum.reverse, bits}
    def parse_packets(orig_bits, ps, n), do: parse_packet(orig_bits) |> then(fn {p, bits} -> parse_packets(bits, [p | ps], n-1) end)

    def parse_operator(["0" | orig_bits]) do 
        {op_size, bits} = n_bits_to_int(orig_bits, 15)
        bits |> Enum.take(op_size) |> parse_packets([], -1) |> on_tuple(1, fn _ -> Enum.drop(bits, op_size) end)
    end

    def parse_operator(["1" | orig_bits]) do 
        {op_size, bits} = n_bits_to_int(orig_bits, 11)
        bits |> parse_packets([], op_size)
    end

    def data do
        "day16.txt"
        |> File.read!
        |> String.split("", trim: true)
        |> Enum.map(fn ch -> ch |> String.to_integer(16) |> Integer.to_string(2) |> String.pad_leading(4, "0") |> String.split("", trim: true) end)
        |> List.flatten
        |> Day16.parse_packet
        |> elem(0)
    end
end