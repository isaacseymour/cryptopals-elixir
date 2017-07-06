defmodule SetOne.ChallengeFiveTest do
  use ExUnit.Case, async: true
  import SetOne.ChallengeFive

  test "correctly encrypts the example" do
    text = """
    Burning 'em, if you ain't quick and nimble
    I go crazy when I hear a cymbal
    """
    |> String.strip
    key = "ICE"

    expected = """
    0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272
    a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f
    """
    |> String.replace(~r/[^a-fA-F0-9]/, "")

    assert encrypt(text, key) == expected
  end
end
