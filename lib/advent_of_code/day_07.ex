defmodule AdventOfCode.Day07 do
  @signs ~w(2 3 4 5 6 7 8 9 T J Q K A)
  @signs_map @signs
             |> Enum.with_index(1)
             |> Map.new()

  @signs2 ~w(J 2 3 4 5 6 7 8 9 T Q K A)
  @signs2_map @signs2
              |> Enum.with_index(1)
              |> Map.new()

  @hands %{
    five: 7,
    four: 6,
    house: 5,
    three: 4,
    two: 3,
    one: 2,
    high: 1
  }

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [cards, bid] = String.split(line, " ")
      {String.split(cards, "", trim: true), String.to_integer(bid)}
    end)
  end

  defp hand(cards) do
    cards
    |> Enum.frequencies()
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.sort()
    |> get_hand()
  end

  defp get_hand([5]), do: :five
  defp get_hand([1, 4]), do: :four
  defp get_hand([2, 3]), do: :house
  defp get_hand([1, 1, 3]), do: :three
  defp get_hand([1, 2, 2]), do: :two
  defp get_hand([1, 1, 1, 2]), do: :one
  defp get_hand([1, 1, 1, 1, 1]), do: :high

  defp kicker(signs_map, cards) do
    Enum.map(cards, fn card ->
      Map.get(signs_map, card)
    end)
  end

  def part1(input) do
    parse_input(input)
    |> Enum.map(fn {cards, bid} ->
      {hand(cards), kicker(@signs_map, cards), bid}
    end)
    |> Enum.sort_by(fn {_, kicker, _} -> kicker end, :asc)
    |> Enum.sort_by(fn {hand, _, _} -> Map.get(@hands, hand) end, :asc)
    |> Enum.with_index(1)
    |> Enum.map(fn {{_card, _kicker, bid}, rank} ->
      bid * rank
    end)
    |> Enum.sum()
  end

  defp hand_with_j(cards) do
    {j, rest} =
      cards
      |> Enum.frequencies()
      |> Map.pop("J", 0)

    rest
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.sort(:desc)
    |> case do
      # 5 J
      [] ->
        [5]

      [top | rest] ->
        # Add Js to the biggest
        Enum.reverse([top + j | rest])
    end
    |> get_hand()
  end

  def part2(input) do
    parse_input(input)
    |> Enum.map(fn {cards, bid} ->
      {hand_with_j(cards), kicker(@signs2_map, cards), bid}
    end)
    |> Enum.sort_by(fn {_, kicker, _} -> kicker end, :asc)
    |> Enum.sort_by(fn {hand, _, _} -> Map.get(@hands, hand) end, :asc)
    |> Enum.with_index(1)
    |> Enum.map(fn {{_card, _kicker, bid}, rank} ->
      bid * rank
    end)
    |> Enum.sum()
  end
end
