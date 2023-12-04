defmodule AdventOfCode.Day02 do
  defp parse_set(line_set) do
    acc = %{red: 0, green: 0, blue: 0}

    String.split(line_set, ",")
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.reduce(acc, fn [count, color], acc ->
      color = String.to_atom(color)
      count = String.to_integer(count)
      Map.update(acc, color, count, &(&1 + count))
    end)
  end

  defp game_info(line) do
    ["Game " <> id, rest] = String.split(line, ":")
    acc = %{id: String.to_integer(id), red: 0, green: 0, blue: 0}

    rest
    |> String.split(";")
    |> Enum.reduce(acc, fn line_set, acc ->
      set = parse_set(line_set)

      Enum.reduce([:red, :green, :blue], acc, fn color, acc ->
        Map.update(acc, color, set[color], fn current_value ->
          if current_value < set[color] do
            set[color]
          else
            current_value
          end
        end)
      end)
    end)
  end

  def part1(input) do
    elf_input = %{red: 12, green: 13, blue: 14}

    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc ->
      game_info = game_info(line)

      if Enum.all?([:red, :green, :blue], &(game_info[&1] <= elf_input[&1])) do
        game_info.id + acc
      else
        acc
      end
    end)
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc ->
      game_info = game_info(line)
      power = game_info.red * game_info.green * game_info.blue
      acc + power
    end)
  end
end
