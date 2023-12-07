defmodule AdventOfCode.Day07 do
  @signs ~w(2 3 4 5 6 7 8 9 T J Q K A)
  @signs_map @signs |> Enum.with_index(1) |> Map.new()

  @signs2 ~w(J 2 3 4 5 6 7 8 9 T Q K A)
  @signs2_map @signs2 |> Enum.with_index(1) |> Map.new()

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
    |> Enum.sort(:desc)
  end

  defp kicker(signs_map, cards), do: Enum.map(cards, &Map.get(signs_map, &1))

  defp hand_with_j(cards) do
    cards
    |> Enum.frequencies()
    |> Map.pop("J", 0)
    |> then(fn {j, rest} ->
      rest
      |> Map.values()
      |> Enum.sort(:desc)
      |> case do
        [] -> [5]
        [top | rest] -> [top + j | rest]
      end
    end)
  end

  defp sort_hands(hands) do
    hands
    |> Enum.sort_by(fn {_, kicker, _} -> kicker end, :asc)
    |> Enum.sort_by(fn {hand, _, _} -> hand end, :asc)
  end

  defp sum_bids(hands) do
    hands
    |> Enum.with_index(1)
    |> Enum.map(fn {{_card, _kicker, bid}, rank} ->
      bid * rank
    end)
    |> Enum.sum()
  end

  def part1(input) do
    parse_input(input)
    |> Enum.map(fn {cards, bid} ->
      {hand(cards), kicker(@signs_map, cards), bid}
    end)
    |> sort_hands()
    |> sum_bids()
  end

  def part2(input) do
    parse_input(input)
    |> Enum.map(fn {cards, bid} ->
      {hand_with_j(cards), kicker(@signs2_map, cards), bid}
    end)
    |> sort_hands()
    |> sum_bids()
  end
end
