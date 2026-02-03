defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _key), do: :not_found
  def search({key}, key), do: {:ok, 0}

  def search(numbers, key) do
    left = 0
    right = tuple_size(numbers) - 1

    if key < elem(numbers, left) or key > elem(numbers, right) do
      :not_found
    else
      search(numbers, left, right, key)
    end
  end

  defp search(numbers, left, right, key) when left == right do
    cond do
      key == elem(numbers, left) -> {:ok, left}
      true -> :not_found
    end
  end

  @spec search(tuple, integer, integer, integer) :: {:ok, integer} | :not_found
  defp search(numbers, left, right, key) when right - left == 1 do
    cond do
      key == elem(numbers, left) -> {:ok, left}
      key == elem(numbers, right) -> {:ok, right}
      true -> :not_found
    end
  end

  defp search(numbers, left, right, key) do
    middle = div(left + right, 2)

    cond do
      key < elem(numbers, middle) -> search(numbers, left, middle - 1, key)
      key > elem(numbers, middle) -> search(numbers, middle + 1, right, key)
      true -> {:ok, middle}
    end
  end
end
