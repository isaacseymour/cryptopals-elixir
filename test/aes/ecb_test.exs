defmodule AES.ECBTest do
  use ExUnit.Case, async: true

  test "decrypts the file" do
    key = "YELLOW SUBMARINE" |> :binary.bin_to_list
    ciphertext = File.read!("test/set_one/challenge_seven_data.txt") |> String.replace("\n", "") |> Base.decode64!  |> :binary.bin_to_list

    result = ciphertext |> AES.ECB.decrypt(key) |> to_string

    expected = File.read!("test/set_one/challenge_seven_result.txt")
    assert result == expected
  end
end
