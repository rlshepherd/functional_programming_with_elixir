defmodule MergeSort do
  @moduledoc """
  Implements the merge sort algorithm.

  Based on psuedo-code in Algorithms Illuminated by Tim Roughgarden.

  This module contains two different implementation of the merge function:
  1. `_case_merge/3` uses Elixir's case syntax to pattern match cases.
  2. `_fn_merge/3` uses function overloaading instead.
  This duplication is intended to compare different approaches to writing
  functional programs in Elixir.
  """

  @spec sort(list) :: list
  @doc """
  Sorts an array of numbers.

  ## Examples:
    iex>MergeSort.sort([4,1,2])
    [1,2,4]
  """
  def sort([]) do
    # Base case 1: empty array
    []
  end

  def sort([x]) do
    # Base case 2: array of length 1
    [x]
  end

  def sort(x) do
    [l, r] = _split(x)
    IO.puts(l)
    _fn_merge([], sort(l), sort(r))
  end

  @spec _case_merge(any, maybe_improper_list, maybe_improper_list) :: list
  @doc """
  Merge. Merges two sorted arrays.
  Implemented using `case`.

  ## Examples:
  iex> MergeSort._case_merge([], [1,3,5],[2,4,6])
  [1,2,3,4,5,6]

  iex> MergeSort._case_merge([], [7,8,9,11,15], [8])
  [7,8,8,9,11,15]
  """
  def _case_merge(acc, [], []) do
    Enum.reverse(acc)
  end

  def _case_merge(acc, left, right) do
    {acc, left, right} =
      case {left, right} do
        {[], right} ->
          [rhead | rtail] = right
          {[rhead | acc], left, rtail}

        {left, []} ->
          [lhead | ltail] = left
          {[lhead | acc], ltail, right}

        {left, right} ->
          [lhead | ltail] = left
          [rhead | rtail] = right

          if lhead < rhead do
            {[lhead | acc], ltail, right}
          else
            {[rhead | acc], left, rtail}
          end
      end

    _case_merge(acc, left, right)
  end

  @spec _fn_merge(any, maybe_improper_list, maybe_improper_list) :: list
  @doc """
  Merge. Merge two sorted arrays.
  Implemented using function overloading.

  ## Examples:
  iex> MergeSort._fn_merge([], [1,3,5],[2,4,6])
  [1,2,3,4,5,6]

  iex> MergeSort._fn_merge([], [7,8,9,11,15], [8])
  [7,8,8,9,11,15]
  """
  def _fn_merge(acc, [], []) do
    Enum.reverse(acc)
  end

  def _fn_merge(acc, [], right) do
    [rhead | rtail] = right
    _fn_merge([rhead | acc], [], rtail)
  end

  def _fn_merge(acc, left, []) do
    [lhead | ltail] = left
    _fn_merge([lhead | acc], ltail, [])
  end

  def _fn_merge(acc, left, right) do
    [lhead | ltail] = left
    [rhead | rtail] = right

    if lhead < rhead do
      _fn_merge([lhead | acc], ltail, right)
    else
      _fn_merge([rhead | acc], left, rtail)
    end
  end

  @spec _split(list) :: [list]
  @doc """
  Splits an array into two halves.

  ## Examples:
  iex> MergeSort._split([1,2,3,4])
  [[1,2],[3,4]]
  """
  def _split(x) do
    mid = round(length(x) / 2)
    Enum.chunk_every(x, mid, mid, [])
  end
end
