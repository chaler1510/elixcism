defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(""), do: ""

  def abbreviate(string) when is_binary(string) do
    string
    |> parse(:letter, "")
  end

  @spec parse(binary(), :letter | :delimiter, String.t()) :: String.t()
  defp parse("", _, acronym), do: acronym

  defp parse(<<char, rest::binary>>, state, acronym) do
    cond do
      (char in ?a..?z or char in ?A..?Z) and state == :letter ->
        parse(rest, :delimiter, acronym <> <<upcase(char)>>)

      char in [?\s, ?-] and state == :delimiter ->
        parse(rest, :letter, acronym)

      true ->
        parse(rest, state, acronym)
    end
  end

  @spec upcase(char()) :: char()
  defp upcase(char) do
    if char in ?a..?z, do: char - 32, else: char
  end
end
