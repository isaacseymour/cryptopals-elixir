defmodule SetOne.ChallengeThreeTest do
  use ExUnit.Case, async: true
  import SetOne.ChallengeThree
  use Bitwise

  test "can decode hello world" do
    ciphertext = "hello world"
                  |> :binary.bin_to_list
                  |> Enum.map(fn char -> bxor(char, 37) end)
                  |> Helpers.encode_hex

    {result, _, _} = decode(ciphertext)
    assert result == "hello world"
  end

  test "can decode the mystery" do
    {result, _, _} = decode("1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736")
    assert result == "Cooking MC's like a pound of bacon"
  end
end
