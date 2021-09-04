defmodule Vector do
  @moduledoc """
  A library of basic vector operations.
  """

  @doc """
  Add two vectors.

  ## Examples:
    iex> Vector.add([1,2,3], [3,4,5])
    [4,6,8]
  """
  @spec add([:number], [:number]) :: [:number]
  def add(u, v) do
    Enum.zip(u, v) |> Enum.map(fn {a, b} -> a + b end)
  end

  def subtract(u, v) do
    Enum.zip(u, v) |> Enum.map(fn {a, b} -> a - b end)
  end

  @doc """
  Dot product of two vectors.

  ## Examples:
    iex> Vector.dot([1,2,3], [4,5,6])
    32
  """
  @spec dot([:number], [:number]) :: number
  def dot(u, v) do
    List.zip([u, v])
    |> Enum.map(fn {a, b} -> a * b end)
    |> Enum.sum()
  end
end
