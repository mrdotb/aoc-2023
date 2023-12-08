defmodule AdventOfCode.Day08 do
  defp parse_input(input) do
    [instructions, steps] = String.split(input, "\n\n")

    instructions = String.split(instructions, "", trim: true)

    map_steps =
      steps
      |> String.split("\n", trim: true)
      |> Enum.map(fn
        <<path::binary-size(3), " = (", left::binary-size(3), ", ", right::binary-size(3), ")">> ->
          {path, {left, right}}
      end)
      |> Map.new()

    {instructions, map_steps}
  end

  def part1(input) do
    {instructions, map_steps} = parse_input(input)

    instructions
    |> Stream.cycle()
    |> Enum.reduce_while({"AAA", 0}, fn
      _instruction, {"ZZZ", step_count} ->
        {:halt, step_count}

      instruction, {current_path, step_count} ->
        side = if(instruction == "L", do: 0, else: 1)
        next_path = map_steps |> Map.get(current_path) |> elem(side)
        {:cont, {next_path, step_count + 1}}
    end)
  end

  defp lcm(nums) do
    Enum.reduce(nums, 1, fn n, r -> div(n * r, Integer.gcd(n, r)) end)
  end

  def part2(input) do
    {instructions, map_steps} = parse_input(input)

    ghost_entrances =
      Enum.filter(map_steps, fn
        {<<_::binary-size(2), "A">>, _} -> true
        _ -> false
      end)
      |> Enum.map(fn {key, _} -> key end)

    instructions
    |> Stream.cycle()
    |> Enum.reduce_while({ghost_entrances, [], 0}, fn instruction,
                                                      {current_steps, steps_count, step_count} ->
      step_count = step_count + 1

      {finish, current_steps} =
        Enum.map(current_steps, fn
          current_step ->
            side = if(instruction == "L", do: 0, else: 1)
            map_steps |> Map.get(current_step) |> elem(side)
        end)
        |> Enum.split_with(fn
          <<_::binary-size(2), "Z">> -> true
          _ -> false
        end)

      steps_count =
        case finish do
          [] -> steps_count
          [_] -> [step_count | steps_count]
        end

      if current_steps == [] do
        {:halt, steps_count}
      else
        {:cont, {current_steps, steps_count, step_count}}
      end
    end)
    |> lcm()
  end
end
