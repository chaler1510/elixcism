defmodule Username do
  def sanitize(username) do
    Enum.reduce(username, [], fn char, acc -> 
      case char do   
        ?ä -> [?e, ?a | acc]
        ?ö -> [?e, ?o | acc]
        ?ü -> [?e, ?u | acc]
        ?ß -> [?s, ?s | acc]
        ?_ -> [?_ | acc]
        char when char in ?a..?z -> [char | acc]
        _ -> acc
      end
    end)
    |> Enum.reverse()
  end 
end
