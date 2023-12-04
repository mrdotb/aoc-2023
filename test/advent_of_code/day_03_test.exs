defmodule AdventOfCode.Day03Test do
  use ExUnit.Case

  import AdventOfCode.Day03

  test "part1" do
    input = AdventOfCode.Input.get!(3, 2023)
    result = part1(input)

    assert result == 530_495
  end

  test "part2" do
    input = AdventOfCode.Input.get!(3, 2023)
    result = part2(input)

    assert result == 80_253_814
  end
end
