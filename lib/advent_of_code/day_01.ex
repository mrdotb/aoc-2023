defmodule AdventOfCode.Day01 do
  def part1(_args) do
    input = AdventOfCode.Input.get!(1, 2023)

    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc ->
      numbers = String.replace(line, ~r/[a-z]/U, "")
      value = String.at(numbers, 0) <> String.at(numbers, -1)
      acc + String.to_integer(value)
    end)
  end

  @replacements_map %{
      "one" => "o1e",
      "two" => "t2o",
      "three" => "t3e",
      "four" => "f4r",
      "five" => "f5e",
      "six" => "s6x",
      "seven" => "s7n",
      "eight" => "e8t",
      "nine" => "n9e"
    }

  def part2(_args) do
    input = AdventOfCode.Input.get!(1, 2023)

    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc ->
      line =
        for {match, replacement} <- @replacements_map, reduce: line do
          line ->
            String.replace(line, match, replacement)
        end
      numbers = String.replace(line, ~r/[a-z]/U, "")
      value = String.at(numbers, 0) <> String.at(numbers, -1)
      acc + String.to_integer(value)
    end)
  end
end
