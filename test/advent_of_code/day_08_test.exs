defmodule AdventOfCode.Day08Test do
  use ExUnit.Case

  import AdventOfCode.Day08

  @input_test """
  RL

  AAA = (BBB, CCC)
  BBB = (DDD, EEE)
  CCC = (ZZZ, GGG)
  DDD = (DDD, DDD)
  EEE = (EEE, EEE)
  GGG = (GGG, GGG)
  ZZZ = (ZZZ, ZZZ)
  """

  @input_test_2 """
  LR

  11A = (11B, XXX)
  11B = (XXX, 11Z)
  11Z = (11B, XXX)
  22A = (22B, XXX)
  22B = (22C, 22C)
  22C = (22Z, 22Z)
  22Z = (22B, 22B)
  XXX = (XXX, XXX)
  """

  test "part1 test input" do
    result = part1(@input_test)

    assert result == 2
  end

  test "part1 test" do
    input = AdventOfCode.Input.get!(8, 2023)
    result = part1(input)

    assert result == 15517
  end

  test "part2 test input" do
    assert part2(@input_test_2) == 6
  end

  test "part2 test" do
    input = AdventOfCode.Input.get!(8, 2023)
    assert part2(input) == 14_935_034_899_483
  end
end
