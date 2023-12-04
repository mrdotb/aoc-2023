defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Day02

  test "part1" do
    input = AdventOfCode.Input.get!(2, 2023)
    result = part1(input)

    assert result == 2164
  end

  test "part2" do
    input = AdventOfCode.Input.get!(2, 2023)
    result = part2(input)

    assert result == 69929
  end
end
