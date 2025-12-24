defmodule Sieve do
  @moduledoc """
  Implementation of the Sieve of Eratosthenes algorithm for finding prime numbers.
  Optimized to skip even numbers and process only odd numbers.
  """

  @type sieve :: :array.array(boolean)
  @type prime :: pos_integer
  @type primes_result :: [] | [prime]

  @doc """
  Generates a list of primes up to a given limit.

  ## Examples
      iex> Sieve.primes_to(10)
      [2, 3, 5, 7]

      iex> Sieve.primes_to(2)
      [2]

      iex> Sieve.primes_to(1)
      []
  """

  @spec primes_to(non_neg_integer) :: primes_result
  def primes_to(limit) when limit < 2, do: []
  def primes_to(limit) when limit == 2, do: [2]
  def primes_to(limit) when limit > 2 do
    array = :array.new(limit + 1, default: true)
    sqrt_limit = :math.sqrt(limit) |> Float.ceil() |> trunc()

    array = find_odd_primes(array, 3, sqrt_limit, limit)
    collect_primes_init(array, limit)
  end

  @spec find_odd_primes(sieve, pos_integer, pos_integer, pos_integer) :: sieve
  defp find_odd_primes(sieve, current, sqrt_limit, limit) when current <= sqrt_limit do
    if :array.get(current, sieve) do
      sieve = set_composites_init(sieve, current, limit)
      find_odd_primes(sieve, current + 2, sqrt_limit, limit)
    else
      find_odd_primes(sieve, current + 2, sqrt_limit, limit)
    end
  end

  defp find_odd_primes(sieve, _, _, _), do: sieve

  @spec set_composites_init(sieve, prime, pos_integer) :: sieve
  defp set_composites_init(sieve, prime, limit) do
    start = prime * prime
    step = prime * 2

    if start <= limit do
      set_composites_run(sieve, start, step, limit)
    else
      sieve
    end
  end

  @spec set_composites_run(sieve, pos_integer, pos_integer, pos_integer) :: sieve
  defp set_composites_run(sieve, pos, step, limit) when pos <= limit do
    sieve = :array.set(pos, false, sieve)
    set_composites_run(sieve, pos + step, step, limit)
  end

  defp set_composites_run(sieve, _, _, _), do: sieve

  @spec collect_primes_init(sieve, pos_integer) :: (-> [prime])
  defp collect_primes_init(sieve, limit) do
    start = if rem(limit, 2) == 1, do: limit, else: limit - 1
    collect_primes_run(sieve, start, [])
  end

  @spec collect_primes_run(sieve, pos_integer, [] | [prime]) :: [prime]
  defp collect_primes_run(_sieve, 1, acc), do: [2 | acc]

  defp collect_primes_run(sieve, current, acc) do
    if :array.get(current, sieve) do
      collect_primes_run(sieve, current - 2, [current | acc])
    else
      collect_primes_run(sieve, current - 2, acc)
    end
  end
end
