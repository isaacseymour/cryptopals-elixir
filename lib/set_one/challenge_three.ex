defmodule SetOne.ChallengeThree do
  import Helpers
  use Bitwise

  def decode(ciphertext) do
    cipherbytes = decode_hex(ciphertext)
     key = 0..255 |> Enum.max_by(fn key -> score_key(cipherbytes, key) end)

    decode_for_key(cipherbytes, key)
  end

  defp score_key(cipherbytes, key) do
    decode_for_key(cipherbytes, key) |> Helpers.score
  end

  defp decode_for_key(cipherbytes, key) do
    cipherbytes
    |> Enum.map(fn byte -> bxor(byte, key) end)
    |> to_string
  end
end
