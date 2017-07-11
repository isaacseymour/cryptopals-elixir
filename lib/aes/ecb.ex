defmodule AES.ECB do
  require Integer

  @eot 0x04 # "end of transmission" character

  def encrypt(plaintext, key) do
    plaintext
    |> pad
    |> Enum.chunk(16)
    |> Helpers.pmap(&AES.encrypt(&1, key))
    |> List.flatten
  end

  def decrypt(ciphertext, key) do
    ciphertext
    |> Enum.chunk(16)
    |> Helpers.pmap(&AES.decrypt(&1, key))
    |> List.flatten
    |> unpad
  end

  defp pad(bytes) do
    padding_length = 16 - (bytes |> Enum.count |> Integer.mod(16))

    if padding_length == 0 do
      bytes
    else
      bytes ++ (0..(padding_length - 1)) |> Enum.map(fn _ -> @eot end)
    end
  end

  defp unpad(bytes) do
    bytes
    |> Enum.reverse
    |> Enum.drop_while(fn byte -> byte == @eot end)
    |> Enum.reverse
  end
end
