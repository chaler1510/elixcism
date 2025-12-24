defmodule GuessingGame do
 
  def compare(_secret_number), do: "Make a guess"
  def compare(_secret_number, :no_guess), do: "Make a guess"

  def compare(secret_number, secret_number) when is_integer(secret_number), do: "Correct"
  def compare(secret_number, guess) when is_integer(secret_number)and is_integer(guess)         and abs(secret_number - guess) == 1, do: "So close" 
  def compare(secret_number, guess) when is_integer(secret_number)and is_integer(guess)         and secret_number < guess, do: "Too high"
  def compare(secret_number, guess) when is_integer(secret_number)and is_integer(guess)         and secret_number > guess, do: "Too low"
end
