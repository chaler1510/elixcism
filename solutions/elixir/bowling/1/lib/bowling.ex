defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @type t :: %__MODULE__{
          scores: %{},
          frame: 1..10,
          state: :one | :two | :three | :end,
          last: 0..10
        }
  defstruct scores: %{
              1 => {},
              2 => {},
              3 => {},
              4 => {},
              5 => {},
              6 => {},
              7 => {},
              8 => {},
              9 => {},
              10 => {}
            },
            frame: 1,
            last: 0,
            state: :one

  @spec start() :: any
  def start do
    %Bowling{}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful error tuple.
  """

  @spec roll(Bowling.t(), integer) :: {:ok, Bowling.t()} | {:error, String.t()}

  def roll({:error, _} = error, _), do: error

  def roll(%Bowling{} = game, roll) do
    with :ok <- validate_roll(roll),
         :ok <- validate_state(game),
         :ok <- validate_pins(game, roll) do
      {:ok, add_roll(game, roll)}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  @spec validate_roll(non_neg_integer()) :: :ok | {:error, String.t()}
  defp validate_roll(roll) when roll < 0, do: {:error, "Negative roll is invalid"}
  defp validate_roll(roll) when roll > 10, do: {:error, "Pin count exceeds pins on the lane"}
  defp validate_roll(_), do: :ok

  @spec validate_state(Bowling.t()) :: :ok | {:error, String.t()}
  defp validate_state(%Bowling{state: :end}), do: {:error, "Cannot roll after game is over"}
  defp validate_state(_), do: :ok

  @spec validate_pins(Bowling.t(), non_neg_integer()) :: :ok | {:error, String.t()}
  defp validate_pins(%Bowling{state: :three, scores: scores, last: last}, roll) do
    sum = Tuple.sum(scores[10])

    if sum not in [10, 20] and last + roll > 10,
      do: {:error, "Pin count exceeds pins on the lane"},
      else: :ok
  end

  defp validate_pins(%Bowling{state: :two, frame: 10, last: last}, roll) do
    if last != 10 and last + roll > 10,
      do: {:error, "Pin count exceeds pins on the lane"},
      else: :ok
  end

  defp validate_pins(%Bowling{state: :two, last: last}, roll) do
    if last + roll > 10, do: {:error, "Pin count exceeds pins on the lane"}, else: :ok
  end

  defp validate_pins(_, _), do: :ok

  @spec add_roll(Bowling.t(), non_neg_integer()) :: Bowling.t()
  defp add_roll(%Bowling{state: :three, scores: scores} = game, roll) do
    {a, b} = scores[10]
    %Bowling{game | state: :end, scores: %{scores | 10 => {a, b, roll}}, last: 0}
  end

  defp add_roll(%Bowling{state: :two, scores: scores, frame: 10, last: last} = game, roll) do
    if last == 10 or last + roll == 10 do
      %Bowling{game | state: :three, scores: %{scores | 10 => {last, roll}}, last: roll}
    else
      %Bowling{game | state: :end, scores: %{scores | 10 => {last, roll}}}
    end
  end

  defp add_roll(%Bowling{state: :one, scores: scores, frame: 10} = game, roll) do
    %Bowling{game | state: :two, scores: %{scores | 10 => {roll}}, last: roll}
  end

  defp add_roll(%Bowling{state: :one, scores: scores, frame: frame} = game, roll) do
    if roll == 10 do
      %Bowling{game | state: :one, frame: frame + 1, scores: %{scores | frame => {roll}}, last: 0}
    else
      %Bowling{game | state: :two, scores: %{scores | frame => {roll}}, last: roll}
    end
  end

  defp add_roll(%Bowling{state: :two, scores: scores, frame: frame, last: last} = game, roll) do
    %Bowling{
      game
      | state: :one,
        frame: frame + 1,
        scores: %{scores | frame => {last, roll}},
        last: 0
    }
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful error tuple.
  """

  @spec score(Bowling.t()) :: {:ok, integer} | {:error, String.t()}
  def score(game) do
    with :ok <- validate_score(game) do
      {:ok, calculate_score(game)}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  @spec validate_score(Bowling.t()) :: :ok | {:error, String.t()}
  defp validate_score(%Bowling{state: :end}), do: :ok
  defp validate_score(_), do: {:error, "Score cannot be taken until the end of the game"}

  @spec calculate_score(Bowling.t()) :: non_neg_integer()
  defp calculate_score(%Bowling{scores: scores}) do
    Enum.reduce(1..10, 0, fn index, acc -> acc + calculate_frame(scores, index) end)
  end

  @spec calculate_frame(Map.t(), non_neg_integer()) :: non_neg_integer()
  defp calculate_frame(scores, 10), do: Tuple.sum(scores[10])

  defp calculate_frame(scores, index) do
    frame = scores[index]
    sum = Tuple.sum(frame)

    cond do
      tuple_size(frame) == 1 and sum == 10 -> sum + bonus(scores, index, :strike)
      tuple_size(frame) == 2 and sum == 10 -> sum + bonus(scores, index, :spare)
      true -> sum
    end
  end

  @spec bonus(Map.t(), pos_integer(), :spare | :strike) :: non_neg_integer()
  defp bonus(scores, index, :spare), do: elem(scores[index + 1], 0)

  defp bonus(scores, index, :strike) do
    next = scores[index + 1]

    if tuple_size(next) >= 2 do
      elem(next, 0) + elem(next, 1)
    else
      next_2 = scores[index + 2]
      elem(next, 0) + elem(next_2, 0)
    end
  end
end
