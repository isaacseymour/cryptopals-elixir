defmodule AES do
  import AES.Utils
  import AES.KeyExpansion
  use Bitwise
  require Integer

  defp encrypt_round(state, [round_key]) do
    state
    |> sub_bytes
    |> shift_rows
    |> add_round_key(round_key)
  end
  defp encrypt_round(state, [round_key | remaining_round_keys]) do
    state
    |> sub_bytes
    |> shift_rows
    |> mix_columns
    |> add_round_key(round_key)
    |> encrypt_round(remaining_round_keys)
  end

  # Must be 16 bytes
  def encrypt(bytes, keybytes) do
    # We want the key expanded as a list of 16-byte keys, not 4-byte words
    [round_key | round_keys] = expand_key(keybytes) |> Enum.chunk(4) |> Enum.map(&List.flatten/1)

    bytes
    |> add_round_key(round_key)
    |> encrypt_round(round_keys)
  end

  defp decrypt_round(state, [round_key]) do
    state |> inverse_shift_rows |> inverse_sub_bytes |> add_round_key(round_key)
  end
  defp decrypt_round(state, [round_key | round_keys]) do
    state
    |> inverse_shift_rows
    |> inverse_sub_bytes
    |> add_round_key(round_key)
    |> inverse_mix_columns
    |> decrypt_round(round_keys)
  end

  def decrypt(bytes, keybytes) do
    [round_key | round_keys] = expand_key(keybytes)
                               |> Enum.chunk(4)
                               |> Enum.map(&List.flatten/1)
                               |> Enum.reverse

    bytes
    |> add_round_key(round_key)
    |> decrypt_round(round_keys)
  end
end
