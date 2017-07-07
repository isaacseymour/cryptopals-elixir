defmodule SetOne.ChallengeEightTest do
  use ExUnit.Case, async: true
  import SetOne.ChallengeEight

  test "finds the line" do
    text = File.read!("test/set_one/challenge_eight_data.txt")

    assert find_ecb_line(text) == 132
  end
end
