defmodule HighScore do
  
  def new(), do: %{}

  def add_player(scores, name, score \\ 0) do
    Map.put(scores, name, score)
  end

  def remove_player(scores, name), do: Map.delete(scores, name)
  
  def reset_score(scores, name), do: Map.put(scores, name, 0)
  
  def update_score(scores, name, score) do
    {:ok, result} = Map.get_and_update(scores, name, fn
      nil -> {:ok, score}
      current -> {:ok, current + score}
    end)
    result
  end

  def get_players(scores), do: Map.keys(scores)
end
