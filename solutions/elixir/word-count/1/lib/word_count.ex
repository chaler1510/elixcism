defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @apostrophe 39
  @spec count(String.t()) :: map
  def count(""), do: %{}

  def count(sentence) do
    {:ok, result} = parse(sentence, :out, "", %{})
    result
  end

  @spec parse(pos_integer, :in | :out, String.t(), map) :: function | {:ok, map}
  defp parse("", :in, buf, acc), do: {:ok, update(acc, buf)}
  defp parse("", :out, _, acc), do: {:ok, acc}

  defp parse(<<@apostrophe, next, rest::binary>>, :in, buf, acc) do
    if alphanum?(next) do
      parse(rest, :in, buf <> <<@apostrophe, normalize(next)>>, acc)
    else
      parse(rest, :out, "", update(acc, buf))
    end
  end

  defp parse(<<@apostrophe>>, :in, buf, acc), do: {:ok, update(acc, buf)}
  defp parse(<<@apostrophe, rest::binary>>, :out, buf, acc), do: parse(rest, :out, buf, acc)

  defp parse(<<char, rest::binary>>, state, buf, acc) do
    cond do
      state == :in and alphanum?(char) -> parse(rest, :in, buf <> <<normalize(char)>>, acc)
      state == :in -> parse(rest, :out, "", update(acc, buf))
      state == :out and alphanum?(char) -> parse(rest, :in, <<normalize(char)>>, acc)
      true -> parse(rest, :out, buf, acc)
    end
  end

  @spec update(map, String.t()) :: map
  defp update(map, key), do: Map.update(map, key, 1, fn value -> value + 1 end)

  @spec alphanum?(pos_integer) :: boolean
  defp alphanum?(char) do
    char in ?A..?Z or char in ?a..?z or char in ?0..?9
  end

  @spec normalize(pos_integer) :: pos_integer()
  defp normalize(char) do
    if char in ?A..?Z, do: char + 32, else: char
  end
end

