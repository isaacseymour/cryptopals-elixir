defmodule SetOne.ChallengeOneTest do
  use ExUnit.Case, async: true
  import SetOne.ChallengeOne
  doctest SetOne.ChallengeOne

  test "can convert hex to base64" do
    input = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
    output = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
    assert hex_to_base64(input) == output
  end
end
