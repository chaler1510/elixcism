defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    trim = String.trim(input)
    cond() do
      trim == "" -> "Fine. Be that way!"
      not has_letter?(trim) and is_question?(trim) -> "Sure."
      not has_letter?(trim) -> "Whatever."
      has_all_caps?(trim) and is_question?(trim) -> "Calm down, I know what I'm doing!" 
      is_question?(trim) -> "Sure."
      has_all_caps?(trim) -> "Whoa, chill out!"   
      true -> "Whatever."      
    end
  end

  defp has_letter?(str) do   
    str
    |> String.graphemes()
    |> Enum.any?(&(is_letter?(&1)))
  end

  defp is_letter?(char) do
   String.downcase(char) != String.upcase(char)
  end  
  
  defp is_question?(str) do
    String.ends_with?(str, "?")
  end

  defp has_all_caps?(str) do
  str == String.upcase(str)
  end  
end
