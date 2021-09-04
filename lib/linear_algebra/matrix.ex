defmodule Matrix do
  @moduledoc """
  A library for basic linear algebra in pure Elixir.
  """

  @typedoc """
  A numeric matrix, i.e.: [[1,2],[3,4]]
  """
  @type matrix :: [[number, ...], ...]

  @doc """
  Add two matrices A and B of the same dimensions.

  ## Examples:
    iex> a = [[1,1],[1,1]]
    iex> b = [[2,2],[2,2]]
    iex> Matrix.add(a, b)
    [[3,3],[3,3]]

  """
  @spec add(matrix, matrix) :: matrix
  def add(a, b) do
    Enum.map(Enum.zip(a, b), fn {a, b} -> Vector.add(a, b) end)
  end

  @doc """
  Subtract two matrices A and B of the same dimensions.

  ## Examples:
    iex> a = [[2,2],[2,2]]
    iex> b = [[1,1],[1,1]]
    iex> Matrix.subtract(a, b)
    [[1,1],[1,1]]

  """
  @spec subtract(matrix, matrix) :: matrix
  def subtract(a, b) do
    Enum.map(Enum.zip(a, b), fn {a, b} -> Vector.subtract(a, b) end)
  end

  @doc """
  Transpose a matrix.

  ## Example:
    iex> Matrix.transpose([[1,2,3], [4,5,6]])
    [[1,4],
     [2,5],
     [3,6]]

  """
  @spec transpose(matrix) :: matrix
  def transpose(a) do
    List.zip(a) |> Enum.map(&Tuple.to_list(&1))
  end

  @doc """
  Performs Strassen's method for multiplying two matrices.

  https://en.wikipedia.org/wiki/Strassen_algorithm

  ## Examples:
    iex> a = [[1,2,3,4],
    ...>      [1,2,3,4],
    ...>      [1,2,3,4],
    ...>      [1,2,3,4]]
    iex> Matrix.fast_multiply(a, a)
    [[10, 20, 30, 40], [10, 20, 30, 40], [10, 20, 30, 40], [10, 20, 30, 40]]

  """
  @spec fast_multiply(matrix, matrix) :: matrix
  def fast_multiply([[x]], [[y]]) do
    [[x * y]]
  end

  def fast_multiply(x, y) do
    {a, b, c, d} = split(x)
    {e, f, g, h} = split(y)

    p1 = fast_multiply(a, subtract(f, h))
    p2 = fast_multiply(add(a, b), h)
    p3 = fast_multiply(add(c, d), e)
    p4 = fast_multiply(d, subtract(g, e))
    p5 = fast_multiply(add(a, d), add(e, h))
    p6 = fast_multiply(subtract(b, d), add(g, h))
    p7 = fast_multiply(subtract(a, c), add(e, f))

    c1 = subtract(add(p5, p4), add(p2, p6))
    c2 = add(p1, p2)
    c3 = add(p3, p4)
    c4 = subtract(add(p1, p5), subtract(p3, p7))

    top =
      Enum.zip([c1, c2])
      |> Enum.map(&Tuple.to_list(&1))
      |> Enum.map(&List.flatten(&1))

    bottom =
      Enum.zip([c3, c4])
      |> Enum.map(&Tuple.to_list(&1))
      |> Enum.map(&List.flatten(&1))

    top ++ bottom
  end

  @doc """
  Splits a n*n matrix into 4 n/2 * n/2 submatrices,
  where n is a power of 2.

  Given the following:
  [  1  2  3  4 ]
  [  5  6  7  8 ]
  [  9 10 11 12 ]
  [ 13 14 15 16 ]

  Return four matrices:
  [ 1 2 ]  [ 3 4 ]  [  9 10 ]  [ 11 12 ]
  [ 5 6 ]  [ 7 8 ]  [ 13 14 ]  [ 13 14 ]

  ## Examples:
    iex> Matrix.split(
    ...>  [[100,101,102,103],
    ...>   [104,105,106,107],
    ...>   [108,109,110,111],
    ...>   [112,113,114,115]
    ...>  ]
    ...>)
    {[[100, 101], [104, 105]], [[102, 103], [106, 107]], [[108, 109], [112, 113]], [[110, 111], [114, 115]]}

    iex> {m1,_,_,_} = Matrix.split (
    ...> [[1,2,3,4],
    ...>  [5,6,7,8],
    ...>  [9,10,11,12],
    ...>  [13,14,15,16]])
    iex> m1
    [[1,2],[5,6]]

  """
  @spec split(matrix) :: {matrix, matrix, matrix, matrix}
  def split(a) do
    n = round(length(a) / 2)

    [[m1, m2], [m3, m4]] =
      Enum.map(a, &Enum.chunk_every(&1, n, n))
      |> transpose()
      |> Enum.map(&Enum.chunk_every(&1, n, n))
      |> transpose()

    {m1, m2, m3, m4}
  end
end
