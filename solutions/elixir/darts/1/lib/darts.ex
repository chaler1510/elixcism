defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) when is_number(x) and is_number(y) do
    radius = (x ** 2 + y ** 2) ** 0.5

    cond do
      radius > 10 -> 0
      radius <= 10 and radius > 5 -> 1
      radius <= 5 and radius > 1 -> 5
      radius <= 1 and radius >= 0 -> 10
    end
  end
end
