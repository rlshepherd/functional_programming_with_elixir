defmodule Parity do
  @moduledoc """
  Find parity outliers.
  """

  @doc """
  Find the parity outlier in a string of integers.

  ## Examples:
    iex>Parity.find_outlier("2 7 4 6 8")
    2

    iex>Parity.find_outlier("1 3 5 7 2 9 11")
    5
  """
  def find_outlier(s) do
    p =
      String.split(s)
      |> Enum.map(&String.to_integer/1)
      |> Enum.map(&rem(&1, 2))

    p_sum = Enum.sum(p)

    Enum.find_index(p, fn x -> rem(x, 2) == if p_sum > 1, do: 0, else: 1 end) + 1
  end
end
