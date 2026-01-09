defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate("", _), do: ""
  def rotate(text, 0) when is_binary(text), do: text
  def rotate(text, 26) when is_binary(text), do: text
  def rotate(text, shift) do
    {:ok, result} = parse(text, shift)
    result
  end

  @spec parse(String.t(), pos_integer, String.t()) :: {:ok, String.t()}
  defp parse(text, shift, acc \\ "")
  defp parse("", _, acc), do: {:ok, acc}
  defp parse(<<char, rest::binary>>, shift, acc) do
    parse(rest, shift, acc <> <<encode(char, shift)>>)
  end

  @spec encode(pos_integer, pos_integer) :: pos_integer
  defp encode(char, shift) do
    cond do
      char in ?a..?z -> if (char + shift) <= ?z, do: char + shift, else: char - (26 -shift)
      char in ?A..?Z -> if (char + shift) <= ?Z, do: char + shift, else: char - (26 -shift)
      true -> char
    end
  end
end