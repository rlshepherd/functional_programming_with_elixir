defmodule Inversions do
  @moduledoc """
  Count inversion in a list of integers.
  Inversions are defined as pairs of elements (i, j) where:
  1. i < j
  2. A[i] > A[j]

  This list has 3 inversion: [1,3,5,2,4,6]
  1. 3,2
  2. 5,2
  3. 5,4
  """

  @spec count(list) :: {list, number}
  @doc """
  Count inversions in a list

  ## Examples:
    iex> Inversions.count [1,3,5,2,4,6]
    {[1,2,3,4,5,6], 3}

    iex> Inversions.count [6,5,4,3,2,1]
    {[1,2,3,4,5,6], 15}
  """
  def count([]) do
    {[], 0}
  end

  def count([x]) do
    {[x], 0}
  end

  def count(a) do
    [l, r] = Inversions._split(a)
    {l, l_inv} = count(l)
    {r, r_inv} = count(r)
    {b, inv} = Inversions._merge_and_count([], l, r, 0)
    {b, l_inv + r_inv + inv}
  end

  @doc """
  Merge two sorted lists and count the number of split inversions.

  Given two sorted arrays A and B, when merging the two arrays
  if B[i] > A[j], then the number of inversions with B in the pair
  is equal to the remaining elements in A.

  ## Examples:
    iex> Inversions._merge_and_count([],[4,5,6],[1,2,3],0)
    {[1,2,3,4,5,6], 9}
  """
  def _merge_and_count(acc, [], [], inv) do
    {Enum.reverse(acc), inv}
  end

  def _merge_and_count(acc, [], right, inv) do
    [rhead | rtail] = right
    _merge_and_count([rhead | acc], [], rtail, inv)
  end

  def _merge_and_count(acc, left, [], inv) do
    [lhead | ltail] = left
    _merge_and_count([lhead | acc], ltail, [], inv)
  end

  def _merge_and_count(acc, left, right, inv) do
    [lhead | ltail] = left
    [rhead | rtail] = right

    if lhead < rhead do
      _merge_and_count([lhead | acc], ltail, right, inv)
    else
      new_inv = inv + length(left)
      _merge_and_count([rhead | acc], left, rtail, new_inv)
    end
  end

  @spec _split(list) :: [list]
  @doc """
  Splits an array into two halves.

  ## Examples:
  iex> Inversions._split([1,2,3,4])
  [[1,2],[3,4]]
  """
  def _split(x) do
    mid = round(length(x) / 2)
    Enum.chunk_every(x, mid, mid, [])
  end
end
