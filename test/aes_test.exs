defmodule AESTest do
  use ExUnit.Case, async: true
  import AES

  test "encrypt" do
    input = Helpers.decode_hex("3243f6a8885a308d313198a2e0370734")
    key = Helpers.decode_hex("2b7e151628aed2a6abf7158809cf4f3c")
    expected = Helpers.decode_hex("3925841d02dc09fbdc118597196a0b32")

    assert encrypt(input, key) == expected
  end

  test "decrypt" do
    input = Helpers.decode_hex("3925841d02dc09fbdc118597196a0b32")
    key = Helpers.decode_hex("2b7e151628aed2a6abf7158809cf4f3c")
    expected = Helpers.decode_hex("3243f6a8885a308d313198a2e0370734")

    assert decrypt(input, key) == expected
  end
end
