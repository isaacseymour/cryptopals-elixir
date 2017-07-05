defmodule SetOne.ChallengeTwoTest do
  use ExUnit.Case, async: true

  import SetOne.ChallengeTwo
  doctest SetOne.ChallengeTwo

  test "can XOR two buffers" do
    input1 = "1c0111001f010100061a024b53535009181c"
    input2 = "686974207468652062756c6c277320657965"
    output = "746865206b696420646f6e277420706c6179"
    assert xor_hex(input1, input2) == output
  end
end
