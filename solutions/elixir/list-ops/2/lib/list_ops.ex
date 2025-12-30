defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) when is_list(l) do
    do_count(l, 0)
  end

  @spec do_count(list, non_neg_integer) :: non_neg_integer
  defp do_count([], acc), do: acc
  defp do_count([_h | t], acc), do: do_count(t, acc + 1)

  @spec reverse(list) :: list
  def reverse(l) when is_list(l) do
    do_reverse(l, [])
  end

  @spec do_reverse(list, list) :: list
  defp do_reverse([], acc), do: acc
  defp do_reverse([h | t], acc), do: do_reverse(t, [h | acc])

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    do_map(l, f, [])
  end

  @spec do_map(list, (any -> any), list) :: list
  defp do_map([], _f, acc), do: reverse(acc)
  defp do_map([h | t], f, acc), do: do_map(t, f, [f.(h) | acc])

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    do_filter(l, f, [])
  end

  @spec do_filter(list, (any -> as_boolean(term)), list) :: list
  defp do_filter([], _f, acc ), do: reverse(acc)
  defp do_filter([h | t], f, acc) do
    if f.(h), do: do_filter(t, f, [h | acc]), else: do_filter(t, f, acc)
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl([], acc, _f ), do: acc
  def foldl([h | t], acc, f), do: foldl(t, f.(h, acc), f)

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr([], acc, _f), do: acc
  def foldr([h | t], acc, f) do
    f.(h, foldr(t, acc, f))
  end

  @spec append(list, list) :: list
  def append(a, b) when is_list(a) and is_list(b) do
    do_append(b, reverse(a))
  end

  @spec do_append(list, list) :: list
  defp do_append([], acc), do: reverse(acc)
  defp do_append([h | t], acc), do: do_append(t, [h | acc])

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    do_concat(ll, [])
  end

  @spec do_concat([[any]], list) :: [any]
  defp do_concat([], acc), do: acc
  defp do_concat([h | t], acc), do: do_concat(t, append(acc, h))
end

