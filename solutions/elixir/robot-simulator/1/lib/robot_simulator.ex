defmodule RobotSimulator do
  @type robot() :: any
  @type direction() :: :north | :east | :south | :west
  @type position() :: {integer(), integer()}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction, position) :: robot() | {:error, String.t()}
  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, position) do
    with :ok <- validate_direction(direction),
         :ok <- validate_position(position) do
      %{direction: direction, position: position}
    end
  end

  @spec validate_direction(any) :: :ok | {:error, String.t()}
  defp validate_direction(direction) when direction in [:north, :east, :south, :west], do: :ok
  defp validate_direction(_), do: {:error, "invalid direction"}

  @spec validate_position(any) :: :ok | {:error, String.t()}
  defp validate_position({x, y}) when is_integer(x) and is_integer(y), do: :ok
  defp validate_position(_), do: {:error, "invalid position"}

  @spec instruction?(pos_integer) :: boolean
  defp instruction?(char), do: char in [?A, ?R, ?L]

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot(), instructions :: String.t()) :: robot() | {:error, String.t()}
  def simulate(robot, ""), do: robot

  def simulate(robot, <<char, rest::binary>>) do
    if instruction?(char) do
      simulate(move(robot, char), rest)
    else
      {:error, "invalid instruction"}
    end
  end

  @spec move(robot, pos_integer()) :: robot()
  defp move(robot, ?R) do
    direction =
      case direction(robot) do
        :north -> :east
        :east -> :south
        :south -> :west
        :west -> :north
      end

    %{robot | direction: direction}
  end

  defp move(robot, ?L) do
    direction =
      case direction(robot) do
        :north -> :west
        :west -> :south
        :south -> :east
        :east -> :north
      end

    %{robot | direction: direction}
  end

  defp move(robot, ?A) do
    {x, y} = position(robot)

    advance =
      case direction(robot) do
        :north -> {x, y + 1}
        :west -> {x - 1, y}
        :south -> {x, y - 1}
        :east -> {x + 1, y}
      end

    %{robot | position: advance}
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot) :: direction()
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot) :: position()
  def position(robot) do
    robot.position
  end
end
