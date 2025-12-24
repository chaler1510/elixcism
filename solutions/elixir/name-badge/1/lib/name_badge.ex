defmodule NameBadge do
  
  @type id :: pos_integer() | nil
  @type name :: String.t() | nil
  @type department :: String.t() | nil
  
  @spec print(id, name, department) :: String.t()
  def print(nil, name, nil) do
    "#{name} - OWNER"
    |> check_length()
  end
    
  def print(nil, name, department) do
    "#{name} - #{String.upcase(department)}"
    |> check_length()
  end
  
  def print(id, name, nil) do
    "[#{id}] - #{name} - OWNER"
    |> check_length()
  end
    
  def print(id, name, department) do
    "[#{id}] - #{name} - #{String.upcase(department)}"
    |> check_length()
  end

  @spec check_length(String.t()) :: String.t()
  defp check_length(badge) do
    passed = String.length(badge) <= 500
    if passed, do: badge, else: String.slice(badge, 0..499)
  end
end
