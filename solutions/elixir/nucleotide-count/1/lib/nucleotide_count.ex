defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]
  @empty_map %{?A => 0, ?T => 0, ?C => 0, ?G => 0}

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count(~c"AATAA", ?A)
  4

  iex> NucleotideCount.count(~c"AATAA", ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(~c"", _nucleotide), do: 0
  def count(strand, nucleotide) when is_list(strand) do
    do_count(strand, nucleotide, 0)
  end

  @spec do_count(charlist(), char(), non_neg_integer) :: non_neg_integer
  defp do_count(~c"", _char, count), do: count
  defp do_count([h | t], char, count) do
    if h == char, do: do_count(t, char, count + 1), else: do_count(t, char, count)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram(~c"AATAA")
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(~c""), do: @empty_map
  def histogram(strand) when is_list(strand) do
    do_histogram(strand, @empty_map)
  end

  @spec do_histogram(charlist(), map) :: map()
  defp do_histogram(~c"", result), do: result
  defp do_histogram([?A | tail],  %{?A => a, ?T => t, ?C => c, ?G => g}) do
    do_histogram(tail, %{?A => a + 1, ?T => t, ?C => c, ?G => g})
  end
  defp do_histogram([?T | tail],  %{?A => a, ?T => t, ?C => c, ?G => g}) do
    do_histogram(tail, %{?A => a, ?T => t + 1, ?C => c, ?G => g})
  end
  defp do_histogram([?C | tail],  %{?A => a, ?T => t, ?C => c, ?G => g}) do
    do_histogram(tail, %{?A => a, ?T => t, ?C => c + 1, ?G => g})
  end
  defp do_histogram([?G | tail],  %{?A => a, ?T => t, ?C => c, ?G => g}) do
    do_histogram(tail, %{?A => a, ?T => t, ?C => c, ?G => g + 1})
  end
  defp do_histogram([h | _tail], _map) when h not in @nucleotides do
    {:error, "Wrong input"}
  end
end
