defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene
  @type error :: {:error, String.t()}

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: kind | error
  def kind(a, b, c) do
    with true <- args_are_numbers?(a,b,c),
         true <- args_are_positive?(a, b, c),
         true <- args_conform_inequality?(a, b, c) do
      get_kind(a, b, c)
    else 
      {:error, reason} -> {:error, reason}
    end         
  end

  @spec get_kind(number, number, number) :: {:ok, kind}
  defp get_kind(a, a, a), do: {:ok, :equilateral}
  defp get_kind(a, a, _), do: {:ok, :isosceles}
  defp get_kind(a, _, a), do: {:ok, :isosceles}
  defp get_kind(_, a, a), do: {:ok, :isosceles}
  defp get_kind(_,_,_), do: {:ok, :scalene}

  @spec integer_or_float?(number) :: true | error
  defp integer_or_float?(n) do
    if is_integer(n) or is_float(n), do: true, else: {:error, "#{inspect(n)} is not an integer or float"}
  end

  @spec args_are_numbers?(number, number, number) :: true | error
  defp args_are_numbers?(a, b, c) do
    with true <- integer_or_float?(a),
         true <- integer_or_float?(b),
         true <- integer_or_float?(c) do
      true
    else
      {:error, reason} -> {:error, reason}
    end
  end

  @spec is_positive?(number) :: boolean
  defp is_positive?(n) do
    if n > 0, do: true, else: false
  end

  @spec args_are_positive?(number, number, number) :: true | error
  defp args_are_positive?(a, b, c) do
    with true <- is_positive?(a),
         true <- is_positive?(b),
         true <- is_positive?(c) do
      true
    else
      false -> {:error, "all side lengths must be positive"}
    end
  end

   @spec args_conform_inequality?(number, number, number) :: true | error
  defp args_conform_inequality?(a, b, c) do
    with true <- a + b >= c,
         true <- b + c >= a,
         true <- a + c >= b do
           true
         else
           _-> {:error, "side lengths violate triangle inequality"}
         end
  end
end
