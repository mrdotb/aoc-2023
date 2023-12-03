defmodule AdventOfCode.Day03 do
  defp pos_slice(string, start, length)
  defp pos_slice(string, -1, length), do: String.slice(string, 0, length)
  defp pos_slice(string, start, length), do: String.slice(string, start, length)

  defp adjacent_sign?(lines_tuple, lines_tuple_size, index, start, len) do
    prev_line =
      if index > 0 do
        elem(lines_tuple, index - 1)
      end

    line = elem(lines_tuple, index)

    next_line =
      if index + 1 < lines_tuple_size do
        elem(lines_tuple, index + 1)
      end

    [prev_line, line, next_line]
    |> Enum.reject(&is_nil/1)
    |> Enum.map(&pos_slice(&1, start - 1, len + 2))
    |> Enum.any?(fn slice ->
      String.match?(slice, ~r/[^\d\.]/)
    end)
  end

  def part1(_args) do
    input = AdventOfCode.Input.get!(3, 2023)

    lines = String.split(input, "\n", trim: true)

    lines_tuple = List.to_tuple(lines)
    lines_tuple_size = tuple_size(lines_tuple)

    lines
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, index} ->
      scan = Regex.scan(~r/\d+/, line, return: :index)

      scan
      |> Enum.filter(fn [{start, len}] ->
        adjacent_sign?(lines_tuple, lines_tuple_size, index, start, len)
      end)
      |> Enum.map(fn [{start, len}] ->
        String.slice(line, start, len)
        |> String.to_integer()
      end)
    end)
    |> Enum.sum()
  end

  defp two_gears(lines_tuple, lines_tuple_size, index, start) do
    prev =
      if index > 0 do
        elem(lines_tuple, index - 1)
      end

    curr = elem(lines_tuple, index)

    next =
      if index + 1 < lines_tuple_size do
        elem(lines_tuple, index + 1)
      end

    results =
      [prev, curr, next]
      |> Enum.reject(fn {line, _} -> is_nil(line) end)
      |> Enum.flat_map(fn {line, scan} ->
        scan
        |> Enum.filter(fn [{s, l}] ->
          c = Enum.map(0..(l - 1), &(&1 + s))

          [start - 1, start, start + 1]
          |> Enum.any?(&(&1 in c))
        end)
        |> Enum.map(fn [{start, len}] ->
          String.slice(line, start, len)
          |> String.to_integer()
        end)
      end)

    if length(results) == 2 do
      Enum.product(results)
    else
      0
    end
  end

  def part2(_args) do
    input = AdventOfCode.Input.get!(3, 2023)

    lines = String.split(input, "\n", trim: true)

    lines_tuple =
      lines
      |> Enum.map(&{&1, Regex.scan(~r/\d+/, &1, return: :index)})
      |> List.to_tuple()

    lines_tuple_size = tuple_size(lines_tuple)

    lines
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, index} ->
      scan = Regex.scan(~r/\*/, line, return: :index)

      Enum.map(scan, fn [{start, _len}] ->
        two_gears(lines_tuple, lines_tuple_size, index, start)
      end)
    end)
    |> Enum.sum()
  end
end
