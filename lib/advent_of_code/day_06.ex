defmodule AdventOfCode.Day06 do
  defp parse_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(fn
      "Time:" <> times ->
        times

      "Distance:" <> distances ->
        distances
    end)
    |> Enum.map(fn str_num ->
      str_num
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
    |> List.to_tuple()
  end

  defp get_results(time) do
    Enum.map(0..time, fn pressed ->
      rest = time - pressed
      distance = rest * pressed
      {pressed, distance}
    end)
  end

  def part1(input) do
    {times, records} = parse_input(input)

    Enum.zip(times, records)
    |> Enum.map(fn {time, record} ->
      get_results(time)
      |> Enum.filter(fn {_pressed, distance} ->
        distance > record
      end)
      |> Enum.count()
    end)
    |> Enum.product()
  end

  defp parse_input_2(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(fn
      "Time:" <> times ->
        times

      "Distance:" <> distances ->
        distances
    end)
    |> Enum.map(fn str_num ->
      str_num
      |> String.replace(" ", "")
      |> String.to_integer()
    end)
    |> List.to_tuple()
  end

  def part2(input) do
    {time, record} = parse_input_2(input)

    [smallest, biggest] =
      [0..time, time..0]
      |> Enum.map(fn range ->
        Enum.reduce_while(range, nil, fn pressed, _ ->
          rest = time - pressed
          distance = rest * pressed
          if(distance > record, do: {:halt, pressed}, else: {:cont, nil})
        end)
      end)

    biggest - smallest + 1
  end
end
