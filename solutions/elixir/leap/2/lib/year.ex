defmodule Year do
  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400
  """
  @spec leap_year?(non_neg_integer) :: boolean
  def leap_year?(year) do
    a = rem(year, 400) == 0
    b = rem(year, 4) == 0
    c = rem(year, 100) != 0
    a or (b and c)
  end
end
