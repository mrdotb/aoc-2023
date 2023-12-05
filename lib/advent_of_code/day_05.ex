defmodule AdventOfCode.Day05 do
  defp parse(input) do
    ["seeds: " <> seeds | rest] = String.split(input, "\n\n", trim: true)

    seeds =
      seeds
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)

    maps =
      rest
      |> Enum.map(fn map ->
        [kind, rest] = String.split(map, " map:")

        ranges =
          rest
          |> String.split("\n", trim: true)
          |> Enum.map(fn ranges ->
            [dest, src, len] =
              ranges
              |> String.split(" ")
              |> Enum.map(&String.to_integer/1)

            %{dest: dest, src: src, len: len}
          end)

        %{kind: kind, ranges: ranges}
      end)

    {seeds, maps}
  end

  defp solve(seed, ranges) do
    Enum.reduce_while(ranges, nil, fn %{dest: dest, src: src, len: len}, _ ->
      if seed >= src and seed <= src + len do
        {:halt, seed - src + dest}
      else
        {:cont, seed}
      end
    end)
  end

  defp seed_ranges(seeds) do
    seeds
    |> Enum.chunk_every(2)
    |> Enum.map(fn [start, len] ->
      start..(start + len)
    end)
  end

  def part1(input) do
    {seeds, maps} = parse(input)

    seeds
    |> Enum.map(fn seed ->
      Enum.reduce(maps, seed, fn map, acc ->
        solve(acc, map.ranges)
      end)
    end)
    |> Enum.min()
  end

  def part2(input) do
    {seeds, maps} = parse(input)

    seeds
    |> seed_ranges()
    |> Stream.flat_map(fn range_seed ->
      range_seed
      |> Stream.map(fn seed ->
        Enum.reduce(maps, seed, fn map, acc ->
          solve(acc, map.ranges)
        end)
      end)
    end)
    |> Enum.min()
  end
end
