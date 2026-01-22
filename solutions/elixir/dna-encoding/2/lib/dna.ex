defmodule DNA do
  @spec encode_nucleotide(integer()) :: integer()
  def encode_nucleotide(code_point) when code_point in [?\s, ?A, ?C, ?G, ?T] do
    case code_point do
      ?\s -> 0
      ?A -> 1
      ?C -> 2
      ?G -> 4
      ?T -> 8
      _ -> "Not a valid character"
    end
  end

  @spec decode_nucleotide(integer()) :: integer()
  def decode_nucleotide(encoded_code) when encoded_code in [0, 1, 2, 4, 8] do
    case encoded_code do
      0 -> ?\s
      1 -> ?A
      2 -> ?C
      4 -> ?G
      8 -> ?T
      _ -> "Not a valid number"
    end
  end

  @spec encode(charlist()) :: bitstring()
  def encode(dna), do: encode(dna, <<>>)

  @spec encode(charlist(), bitstring()) :: bitstring()
  defp encode([], acc), do: acc

  defp encode([char | chars], acc) do
    code = encode_nucleotide(char)
    encode(chars, <<acc::bits, code::4>>)
  end

  @spec decode(bitstring()) :: charlist()
  def decode(dna), do: decode(dna, [])

  @spec decode(bitstring(), charlist()) :: charlist()
  defp decode(<<>>, acc), do: reverse(acc)

  defp decode(<<code::4, rest::bits>>, acc) do
    char = decode_nucleotide(code)
    decode(rest, [char | acc])
  end

  @spec reverse(list) :: list
  defp reverse(l) when is_list(l), do: reverse(l, [])

  @spec reverse(list, list) :: list
  defp reverse([], acc), do: acc
  defp reverse([h | t], acc), do: reverse(t, [h | acc])
end