defmodule AES.KeyExpansionTest do
  use ExUnit.Case, async: true
  import AES.KeyExpansion

  test "is the right length" do
    key = 1..16
    # need 44 words. four for each round of add_round_key, and there are ten rounds, plus an initial
    # application
    assert Enum.count(expand_key(key)) == 44
  end

  test "completes the example correctly" do
    key = Helpers.decode_hex("2b7e151628aed2a6abf7158809cf4f3c")
    expanded = expand_key(key)
    expected = [
      "2b7e1516",
      "28aed2a6",
      "abf71588",
      "09cf4f3c",
      "a0fafe17",
      "88542cb1",
      "23a33939",
      "2a6c7605",
      "f2c295f2",
      "7a96b943",
      "5935807a",
      "7359f67f",
      "3d80477d",
      "4716fe3e",
      "1e237e44",
      "6d7a883b",
      "ef44a541",
      "a8525b7f",
      "b671253b",
      "db0bad00",
      "d4d1c6f8",
      "7c839d87",
      "caf2b8bc",
      "11f915bc",
      "6d88a37a",
      "110b3efd",
      "dbf98641",
      "ca0093fd",
      "4e54f70e",
      "5f5fc9f3",
      "84a64fb2",
      "4ea6dc4f",
      "ead27321",
      "b58dbad2",
      "312bf560",
      "7f8d292f",
      "ac7766f3",
      "19fadc21",
      "28d12941",
      "575c006e",
      "d014f9a8",
      "c9ee2589",
      "e13f0cc8",
      "b6630ca6"
    ] |> Enum.map(&Helpers.decode_hex/1)

    assert expanded == expected
  end
end
