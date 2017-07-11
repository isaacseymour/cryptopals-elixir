defmodule AES.ECB do
  require Integer

  def encrypt(plaintext, key) do
    plaintext
    |> PKCS7.pad
    |> Enum.chunk(16)
    |> Helpers.pmap(&AES.encrypt(&1, key))
    |> List.flatten
  end

  def decrypt(ciphertext, key) do
    ciphertext
    |> Enum.chunk(16)
    |> Helpers.pmap(&AES.decrypt(&1, key))
    |> List.flatten
    |> PKCS7.unpad
  end
end
