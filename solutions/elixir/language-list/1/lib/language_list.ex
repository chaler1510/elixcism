defmodule LanguageList do
  def new(), do: []
    
  def add(list, language), do: [language | list]

  def remove([_h | t]), do: t

  def first([h | _t]), do: h

  def count(list), do: length(list)

  def functional_list?([]), do: false
  def functional_list?(["Elixir" | _t]), do: true
  def functional_list?([_h | t]), do: functional_list?(t)
end
