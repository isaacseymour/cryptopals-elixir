defmodule AES.CBC do
  @blocksize 16

  def encrypt(plaintext, key, iv) do
    blocks = plaintext |> PKCS7.pad |> Enum.chunk(@blocksize)
    encrypt_round(blocks, key, iv)
  end

  defp encrypt_round([], _, _), do: []
  defp encrypt_round([plainblock | plainblocks], key, prev_cipherblock) do
    cipherblock = AES.Utils.xor(plainblock, prev_cipherblock) |> AES.encrypt(key)
    [cipherblock] ++ encrypt_round(plainblocks, key, cipherblock)
  end

  def decrypt(ciphertext, key, iv) do
    cipherblocks = ciphertext |> Enum.chunk(@blocksize)
    prev_cipherblocks = [iv] ++ cipherblocks
    Enum.zip(cipherblocks, prev_cipherblocks)
    |> Helpers.pmap(fn {cipherblock, prev_cipherblock} -> AES.decrypt(cipherblock, key) |> AES.Utils.xor(prev_cipherblock) end)
    |> List.flatten
    |> PKCS7.unpad
  end
end
