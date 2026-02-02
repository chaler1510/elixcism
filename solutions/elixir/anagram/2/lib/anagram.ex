defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) when is_binary(base) do
    low_base = String.downcase(base)
    map_base = to_map(low_base)
    Enum.filter(candidates, &anagram?(&1, low_base, map_base))
  end

  @spec anagram?(String.t(), String.t(), map()) :: boolean()
  defp anagram?(str, low_base, _map_base) when byte_size(str) != byte_size(low_base), do: false

  defp anagram?(str, low_base, map_base) do
    low_str = String.downcase(str)

    if low_str == low_base, do: false, else: to_map(low_str) == map_base
  end

  @spec to_map(String.t()) :: map()
  defp to_map(str) when is_binary(str), do: to_map(str, %{})

  @spec to_map(String.t(), map()) :: map()
  defp to_map("", acc), do: acc

  defp to_map(<<char::utf8, rest::binary>>, acc) do
    to_map(rest, Map.update(acc, char, 1, &(&1 + 1)))
  end
end