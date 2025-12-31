defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep([], _fun), do: []
   def keep(list, fun) do
    if is_list(list), do: do_keep(list, fun, []), else: {:error, "The argument is not a list"}
   end

  @spec do_keep(list :: list(any), fun :: (any -> boolean), list) :: list(any)
  defp do_keep([], _fun, acc), do: reverse(acc)
  defp do_keep([h | t], fun, acc) do
    if fun.(h), do: do_keep(t, fun, [h | acc]), else: do_keep(t, fun, acc)
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard([], _fun), do: []
  def discard(list, fun) do
    if is_list(list), do: do_discard(list, fun, []), else: {:error, "The argument is not a list"}
  end

  @spec do_discard(list :: list(any), fun :: (any -> boolean), list) :: list(any)
  defp do_discard([], _fun, acc), do: reverse(acc)
  defp do_discard([h | t], fun, acc) do
    if fun.(h), do: do_discard(t, fun, acc), else: do_discard(t, fun, [h | acc])
  end

  @spec reverse(list) :: list
  defp reverse([]), do: []
  defp reverse(list) when is_list(list), do: do_reverse(list, [])

  @spec do_reverse(list, list) :: list
  defp do_reverse([], acc), do: acc
  defp do_reverse([h |t], acc), do: do_reverse(t, [h | acc])
end
