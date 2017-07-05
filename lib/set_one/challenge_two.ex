defmodule SetOne.ChallengeTwo do
  use Bitwise
  import Helpers

  @spec xor_hex(binary, binary) :: binary
  def xor_hex(input1, input2) do
    Enum.zip(decode_hex(input1), decode_hex(input2))
    |> Enum.map(fn {a,b} -> bxor(a, b) end)
    |> encode_hex
  end
end
