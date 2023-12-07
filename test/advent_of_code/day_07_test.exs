defmodule AdventOfCode.Day07Test do
  use ExUnit.Case

  import AdventOfCode.Day07

  @input_example """
  32T3K 765
  T55J5 684
  KK677 28
  KTJJT 220
  QQQJA 483
  """

  test "part1 test input" do
    result = part1(@input_example)

    assert result == 6440
  end

  test "part1 test" do
    input = AdventOfCode.Input.get!(7, 2023)
    result = part1(input)

    assert result == 248_559_379
  end

  test "part2 test input" do
    result = part2(@input_example)

    assert result == 5905
  end

  test "part2 test" do
    input = AdventOfCode.Input.get!(7, 2023)
    result = part2(input)

    assert result == 249_631_254
  end
end
