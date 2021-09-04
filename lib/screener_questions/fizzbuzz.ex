defmodule FizzBuzz do
  @moduledoc """
  FizzBuzz using `cond`.

  From Progamming Elixir 1.6 by Dave Thomas.

  Question: Write a function that accepts a number,
  and prints all the numbers from 1 to that number,
  and replaces all multiples of 3 with the word "Fizz",
  and the multiples of 5 with "Buzz",
  and multiples of both with "FizzBuzz".
  """

  @doc """
  Count upto a given number, with FizzBuzz.

  ## Examples:
    iex> FizzBuzz.upto(15)
    [1,2,"Fizz",4,"Buzz","Fizz",7,8,"Fizz","Buzz",11,"Fizz",13,14,"FizzBuzz"]
  """
  def upto(n) when n > 0 do
    _upto(1, n, [])
  end

  defp _upto(_current, 0, result), do: Enum.reverse(result)

  defp _upto(current, remaining, result) do
    next_result =
      cond do
        rem(current, 3) == 0 and rem(current, 5) == 0 -> "FizzBuzz"
        rem(current, 3) == 0 -> "Fizz"
        rem(current, 5) == 0 -> "Buzz"
        true -> current
      end

    _upto(current + 1, remaining - 1, [next_result | result])
  end
end
