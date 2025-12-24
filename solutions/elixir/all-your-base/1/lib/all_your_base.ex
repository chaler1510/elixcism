defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    with :ok <- validate_base(input_base, "input"),
         :ok <- validate_base(output_base, "output"),
         :ok <- validate_digits(digits, input_base) do
    decimal = digits_to_decimal(digits, input_base)
    decimal_to_digits(decimal, output_base)
    end
  end

  @spec digits_to_decimal(list, pos_integer, non_neg_integer) :: integer
  def digits_to_decimal(list, base, acc \\ 0)
  def digits_to_decimal([], _, acc), do: acc
  def digits_to_decimal([h | t], base, acc) do
    pos = length(t)
    acc = acc + Integer.pow(base, pos) * h    
    digits_to_decimal(t, base, acc)
  end

  defp validate_base(base, _type) when base >= 2, do: :ok
  defp validate_base(_, type), do: {:error, "#{type} base must be >= 2"}

  defp validate_digits(digits, base) do
    if Enum.all?(digits, fn digit -> digit in 0..(base - 1) end) do
      :ok
    else
      {:error, "all digits must be >= 0 and < input base"}
    end
  end

  @spec decimal_to_digits(non_neg_integer, pos_integer, list) :: list
  def decimal_to_digits(num, base, acc \\ [])
  def decimal_to_digits(num, base, acc) when num < base, do: {:ok, [num | acc]}    
  def decimal_to_digits(num, base, acc) do
    left = div(num, base)
    mod = rem(num, base)
    acc = [mod | acc]     
    decimal_to_digits(left, base, acc)
  end
end