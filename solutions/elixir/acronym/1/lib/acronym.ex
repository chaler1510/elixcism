defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(""), do: ""

  def abbreviate(string) when is_binary(string) do
    string
    |> String.upcase()
    |> String.split([" ", "-"], trim: true)
    |> words_to_acronym("")
  end

  @spec words_to_acronym([String.t()], String.t()) :: String.t()
  defp words_to_acronym([], acronym), do: acronym

  defp words_to_acronym([word | words], acronym) do
    char = first_letter(word)
    words_to_acronym(words, acronym <> <<char>>)
  end

  @spec first_letter(binary()) :: char() | <<>>
  defp first_letter(""), do: <<>>
  defp first_letter(<<char, _rest::binary>>) when char in ?A..?Z, do: char
  defp first_letter(<<_char, rest::binary>>), do: first_letter(rest)
end
