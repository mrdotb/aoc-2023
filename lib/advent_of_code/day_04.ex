defmodule AdventOfCode.Day04 do
  defp parse_card(line) do
    ["Card" <> id, rest] = String.split(line, ":")
    id = id |> String.trim() |> String.to_integer()

    [winnings, numbers] =
      rest
      |> String.split("|")
      |> Enum.map(fn part ->
        part
        |> String.split(" ", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    {id, winnings, numbers}
  end

  defp win_1(card) do
    {_id, winnings, numbers} = card

    Enum.reduce(winnings, 0, fn winning, acc ->
      numbers
      |> Enum.filter(&(&1 == winning))
      |> Enum.reduce(acc, fn _, acc -> if(acc == 0, do: 1, else: acc * 2) end)
    end)
  end

  defp win_2(card) do
    {_id, winnings, numbers} = card

    Enum.reduce(winnings, 0, fn winning, acc ->
      count =
        numbers
        |> Enum.filter(&(&1 == winning))
        |> Enum.count()

      acc + count
    end)
  end

  def part1(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&parse_card/1)
    |> Enum.map(&win_1/1)
    |> Enum.sum()
  end

  defp count_cards_and_copies(cards, cards_map, max_id) do
    Enum.reduce(cards, 0, fn
      {_id, 0}, acc ->
        acc + 1

      {^max_id, _}, acc ->
        acc + 1

      {id, win}, acc ->
        until = if(id + win > max_id, do: max_id, else: id + win)

        count =
          (id + 1)..until
          |> Enum.map(&Map.get(cards_map, &1))
          |> count_cards_and_copies(cards_map, max_id)

        count + acc + 1
    end)
  end

  def part2(input) do
    cards =
      String.split(input, "\n", trim: true)
      |> Enum.map(&parse_card/1)
      |> Enum.map(fn {id, _, _} = card ->
        {id, win_2(card)}
      end)

    cards_map = cards |> Enum.map(fn {id, win} -> {id, {id, win}} end) |> Map.new()
    {max_id, _} = List.last(cards)

    count_cards_and_copies(cards, cards_map, max_id)
  end
end
