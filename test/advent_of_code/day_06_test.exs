defmodule AdventOfCode.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Day06

  @test_input """
  Time:      7  15   30
  Distance:  9  40  200
  """

  test "part1 test input" do
    result = part1(@test_input)

    assert result == 288
  end

  test "part1" do
    input = AdventOfCode.Input.get!(6, 2023)
    result = part1(input)

    assert result == 1_731_600
  end

  test "part2 test input" do
    result = part2(@test_input)

    assert result == 71503
  end

  test "part2" do
    input = AdventOfCode.Input.get!(6, 2023)
    result = part2(input)

    assert result == 40_087_680
  end
end
