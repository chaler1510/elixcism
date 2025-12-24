defmodule HighSchoolSweetheart do
  def first_letter(name) do
    String.trim_leading(name) |> String.first()
  end

  def initial(name) do
    first_letter(name) |> String.upcase() |>  Kernel.<>(".")
  end
1
  def initials(full_name) do
    [first_name, last_name | _] = String.split(full_name)
    initial(first_name) <> " " <> initial(last_name)
  end

  def pair(full_name1, full_name2) do
   pair = initials(full_name1) <> "  +  " <> initials(full_name2)
   """    
   ❤-------------------❤
   |  #{pair}  |
   ❤-------------------❤
   """
  end
end
