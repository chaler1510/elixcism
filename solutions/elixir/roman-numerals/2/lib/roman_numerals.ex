defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) when is_integer(number) and number <= 3999 do
    {0, romans} = convert({number, []})    
    romans
    |> Enum.reverse()
    |> Enum.join("")
  end

  @type acc :: {non_neg_integer, list | [String.t()]}
  @spec convert(acc) :: acc
  defp convert({0, romans}), do: {0, romans}
  defp convert({number, romans}) do
    result =
      cond do
        number >= 1000 -> {number - 1000, ["M" | romans]}
        number >= 900 -> {number - 900, ["CM" | romans]}
        number >= 500 -> {number - 500, ["D" | romans]}
        number >= 400 -> {number - 400, ["CD" | romans]}
        number >= 100 -> {number - 100, ["C" | romans]}
        number >= 90 -> {number - 90, ["XC" | romans]}
        number >= 50 -> {number - 50, ["L" | romans]}
        number >= 40 -> {number - 40, ["XL" | romans]}
        number >= 10 -> {number - 10, ["X" | romans]}
        number >= 9 -> {number - 9, ["IX" | romans]}
        number >= 5 -> {number - 5, ["V" | romans]}
        number >= 4 -> {number - 4, ["IV" | romans]}
        true -> {number - 1, ["I" | romans]}
      end
      convert(result)
  end
end
