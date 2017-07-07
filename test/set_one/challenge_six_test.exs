defmodule SetOne.ChallengeSixTest do
  use ExUnit.Case, async: true
  import SetOne.ChallengeSix

  test "it decrypts the file" do
    cipherbytes = File.read!("test/set_one/challenge_six_data.txt") |> decode
    key = likely_keys(cipherbytes, 6, 1) |> List.first
    plaintext = decrypt(cipherbytes, key)

    assert plaintext == File.read!("test/set_one/challenge_six_result.txt")
  end
end
