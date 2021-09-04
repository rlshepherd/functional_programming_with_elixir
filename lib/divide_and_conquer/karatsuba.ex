defmodule Karatsuba do
  @moduledoc """
  Implements the Katasuba multiplication algo.

  From Algorithms Illuminated by Tim Roughgarden.
  """

  @spec multiply(number, number) :: number
  def multiply(m, n) when m < 10 or n < 10 do
    m * n
  end

  @doc """
  Multiply 2 numbers of length n where n is a power of 2.

  Returns an integer.

  ## Examples:

    iex> Karatsuba.multiply(10,10)
    100

    iex> Karatsuba.multiply(1234, 1234)
    1522756

    iex> Karatsuba.multiply(1234, 5678)
    7006652

    iex> Karatsuba.multiply(19872465, 89126743)
    1771168080831495

  """
  def multiply(m, n) do
    digits = length(Integer.digits(m))

    [a, b] = split_digits(m)
    [c, d] = split_digits(n)

    p = a + b
    q = c + d

    ac = Karatsuba.multiply(a, c)
    bd = Karatsuba.multiply(b, d)
    pq = Karatsuba.multiply(p, q)

    abcd = pq - ac - bd

    round(:math.pow(10, digits)) * ac + round(:math.pow(10, digits / 2)) * abcd + bd
  end

  @doc """
  Splits a number into two halfs by digits.

  Returns a list of numbers of length 2.

  ##Examples:
    iex>Karatsuba.split_digits(11)
    [1,1]

    iex>Karatsuba.split_digits(5678)
    [56,78]

    iex>Karatsuba.split_digits(123)
    [12,3]

  """
  @spec split_digits(integer) :: [...]
  def split_digits(x) do
    x_arr = Integer.digits(x)
    x_mid = round(length(x_arr) / 2)

    [{l, _}, {r, _}] =
      Enum.chunk_every(x_arr, x_mid, x_mid, [])
      |> Enum.map(&Enum.join/1)
      |> Enum.map(&Integer.parse/1)

    [l, r]
  end
end
