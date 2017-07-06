defmodule SetOne.ChallengeFive do
  use Bitwise

  def encrypt(text, key) do
    keybytes = :binary.bin_to_list(key)
    repeated_key = Stream.resource(
      fn -> nil end,
      fn _ -> {keybytes, nil} end,
      fn _ -> :ok end
    )

    text
    |> :binary.bin_to_list
    |> Enum.zip(repeated_key)
    |> Enum.map(fn {a, b} -> bxor(a, b) end)
    |> Helpers.encode_hex
  end
end
