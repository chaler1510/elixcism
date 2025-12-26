defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene
  @type error :: {:error, String.t()}
  @type result :: {:ok, kind} | error

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: result
  def kind(a, b, c) do
    with :ok <- args_are_numbers?(a,b,c),
         :ok <- args_are_positive?(a, b, c),
         :ok <- args_conform_inequality?(a, b, c) do
      {:ok, get_kind(a, b, c)}
    else
      {:error, reason} -> {:error, reason}
    end         
  end

  @spec get_kind(number, number, number) :: kind
  defp get_kind(a, a, a), do: :equilateral
  defp get_kind(a, a, _), do: :isosceles
  defp get_kind(a, _, a), do: :isosceles
  defp get_kind(_, a, a), do: :isosceles
  defp get_kind(_,_,_), do: :scalene

  @spec args_are_numbers?(number, number, number) :: :ok | error
  defp args_are_numbers?(a, b, c) do
    if is_number(a) and is_number(b) and is_number(c) do
      :ok
    else
      {:error, "Number expected"}      
    end
  end

  @spec args_are_positive?(number, number, number) :: :ok | error
  defp args_are_positive?(a, b, c) do
    if a > 0 and b > 0 and c > 0 do
      :ok
    else
      {:error, "all side lengths must be positive"}
    end
  end

   @spec args_conform_inequality?(number, number, number) :: :ok | error
  defp args_conform_inequality?(a, b, c) do
    if a + b >= c and b + c >= a and a + c >= b do
      :ok
    else
      {:error, "side lengths violate triangle inequality"}
    end
  end
end