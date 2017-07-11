defmodule AES.CBCTest do
  use ExUnit.Case, async: true

  test "decrypts the file" do
    key = "YELLOW SUBMARINE" |> :binary.bin_to_list
    ciphertext = File.read!("test/set_two/cbc_data.txt") |> String.replace("\n", "") |> Base.decode64!  |> :binary.bin_to_list
    iv = 0..15 |> Enum.map(fn _ -> 0 end)

    result = ciphertext |> AES.CBC.decrypt(key, iv) |> to_string

    expected = File.read!("test/set_one/challenge_seven_result.txt")
    assert result == expected
  end
end
