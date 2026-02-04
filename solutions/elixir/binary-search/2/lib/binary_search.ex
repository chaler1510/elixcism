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

  def search(numbers, key) when is_integer(key) do
    check_bounds(numbers, key)
  end

  def search(_, _), do: :not_found

  @spec check_bounds(tuple, integer) :: {:ok, integer} | :not_found
  defp check_bounds(numbers, key) do
    size = tuple_size(numbers)

    cond do
      key < elem(numbers, 0) -> :not_found
      key == elem(numbers, 0) -> {:ok, 0}
      key > elem(numbers, size - 1) -> :not_found
      key == elem(numbers, size - 1) -> {:ok, size - 1}
      size == 2 -> :not_found
      true -> do_search(numbers, 1, size - 2, key)
    end
  end

  @spec do_search(tuple, integer, integer, integer) :: {:ok, integer} | :not_found
  defp do_search(_numbers, left, right, _key) when left > right, do: :not_found

  defp do_search(numbers, left, left, key) do
    if key == elem(numbers, left), do: {:ok, left}, else: :not_found
  end

  defp do_search(numbers, left, right, key) do
    middle = div(left + right, 2)

    cond do
      key == elem(numbers, middle) -> {:ok, middle}
      key < elem(numbers, middle) -> do_search(numbers, left, middle - 1, key)
      key > elem(numbers, middle) -> do_search(numbers, middle + 1, right, key)
    end
  end
end