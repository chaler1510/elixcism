defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    trim = String.trim(input)
    cond() do
      trim == "" -> "Fine. Be that way!"
      not contains_letter?(trim) and question?(trim) -> "Sure."
      not contains_letter?(trim) -> "Whatever."
      all_caps?(trim) and question?(trim) -> "Calm down, I know what I'm doing!" 
      question?(trim) -> "Sure."
      all_caps?(trim) -> "Whoa, chill out!"   
      true -> "Whatever."      
    end
  end

  defp contains_letter?(str) do   
    str
    |> String.graphemes()
    |> Enum.any?(&letter?/1)
  end

  defp letter?(char) do
   String.downcase(char) != String.upcase(char)
  end  
  
  defp question?(str) do
    String.ends_with?(str, "?")
  end

  defp all_caps?(str) do
  str == String.upcase(str)
  end  
end
