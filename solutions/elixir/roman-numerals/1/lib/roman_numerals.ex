defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) when number <= 3999 do
    number
    |> expand_number()
    |> convert_to_roman()
  end

  @spec expand_number(pos_integer) :: [{pos_integer, non_neg_integer}]
  defp expand_number(num) do
    digits = Integer.digits(num)
    factor = length(digits) - 1
    Enum.with_index(digits, fn elem, index -> {elem, factor - index} end)
  end

  @spec convert_to_roman([{pos_integer, non_neg_integer}]) :: String.t()
  defp convert_to_roman(list) do
    Enum.reduce(list, "", fn tuple, acc -> acc <> decimal_to_roman(tuple) end) 
  end
  
  defp decimal_to_roman({num, 3}) do
    String.pad_leading("", num, "M")
  end
  
  defp decimal_to_roman({num, 2}) do
      case(num) do
      num when num < 4 -> String.pad_leading("", num, "C")
      num when num == 4 -> "CD"
      num when num >= 5 and num < 9 ->  String.pad_trailing("D", num - 4, "C")
      num when num == 9 -> "CM"
    end    
  end
  
  defp decimal_to_roman({num, 1}) do
      case(num) do
      num when num < 4 -> String.pad_leading("", num, "X")
      num when num == 4 -> "XL"
      num when num >= 5 and num < 9 ->  String.pad_trailing("L", num - 4, "X")
      num when num == 9 -> "XC"
    end
  end
  
  defp decimal_to_roman({num, 0}) do
    case(num) do
      num when num < 4 -> String.pad_leading("", num, "I")
      num when num == 4 -> "IV"
      num when num >= 5 and num < 9 ->  String.pad_trailing("V", num - 4, "I")
      num when num == 9 -> "IX"
    end
  end
end
