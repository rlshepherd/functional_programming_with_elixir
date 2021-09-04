defmodule WordReverser do
  @moduledoc """
  Reverse a sentence word-wise, maintaining punction.

  Question: Write a function that accepts a sentence,
  and returns that sentence with the letters of each word reversed,
  but the words themselves in the same order,
  and punction in place.

  Examples:
  1. "I love to code!" -> "I evol ot edoc!"
  2. "Do you love to code, too?" -> "oD you evol ot edoc, oot?"
  """

  @doc """
  Reverse a sentence word wise, maintaining punctutiation in place.

  ## Examples:
    iex> WordReverser.sentence("I love to code!")
    "I evol ot edoc!"

    iex> WordReverser.sentence("Do you love to code, too?")
    "oD uoy evol ot edoc, oot?"


  """
  @spec sentence(binary) :: binary
  def sentence(s) do
    String.split(s, ~r{[^a-zA-Z\d:]}, include_captures: true)
    |> Enum.map(&String.reverse/1)
    |> Enum.join()
  end
end
