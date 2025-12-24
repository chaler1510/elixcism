defmodule KitchenCalculator do
  def get_volume({volume, ml}) when volume in 
  [:cup, :fluid_ounce, :teaspoon, :tablespoon, :milliliter] and is_number(ml), do: ml
  def get_volume(_,_), do: "Wrong arguments"
  
  def to_milliliter({:cup, num}), do: {:milliliter, num * 240}
  def to_milliliter({:fluid_ounce, num}), do: {:milliliter, num * 30}
  def to_milliliter({:teaspoon, num}), do: {:milliliter, num * 5}
  def to_milliliter({:tablespoon, num}), do: {:milliliter, num * 15}
  def to_milliliter({:milliliter, num}), do: {:milliliter, num}
  
  def from_milliliter({:milliliter, num}, :cup), do: {:cup, num / 240}
  def from_milliliter({:milliliter, num}, :fluid_ounce), do: {:fluid_ounce, num / 30}
  def from_milliliter({:milliliter, num}, :teaspoon), do: {:teaspoon, num / 5}
  def from_milliliter({:milliliter, num}, :tablespoon), do: {:tablespoon, num / 15}
  def from_milliliter({:milliliter, num}, :milliliter), do: {:milliliter, num} 

  def convert({volume, num}, unit) do
   to_milliliter({volume, num}) |> from_milliliter(unit)   
   end
  end
