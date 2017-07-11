defmodule SetTwo.ChallengeTwelveTest do
  use ExUnit.Case, async: true
  @key Stream.repeatedly(fn -> :rand.uniform(255) end) |> Enum.take(16)
  @unknown_bytes "Um9sbGluJyBpbiBteSA1LjAKV2l0aCBteSByYWctdG9wIGRvd24gc28gbXkgaGFpciBjYW4gYmxvdwpUaGUgZ2lybGllcyBvbiBzdGFuZGJ5IHdhdmluZyBqdXN0IHRvIHNheSBoaQpEaWQgeW91IHN0b3A/IE5vLCBJIGp1c3QgZHJvdmUgYnkK" |> Base.decode64! |> :binary.bin_to_list


  def encrypt(plainbytes) do
    AES.ECB.encrypt(plainbytes ++ @unknown_bytes, @key)
  end

  test "find block size" do
    as = Stream.repeatedly(fn -> 0x41 end)
    integers = Stream.iterate(0, &(&1+1))

    double_blocksize = integers
    |> Stream.map(fn count -> Enum.take(as, count) end)
    |> Stream.map(&encrypt/1)
    |> Enum.find_index(&SetOne.ChallengeEight.is_ecb?/1)


    assert div(double_blocksize, 2) == 16
  end

  test "decrypt first byte" do
    as = Stream.repeatedly(fn -> 0x41 end)
    all_bytes = Stream.iterate(0, &(&1+1)) |> Enum.take(256)
    blocksize = 16

    first_byte_ciphertext = encrypt(Enum.take(as, blocksize - 1)) |> Enum.take(blocksize)
    all_bytes_ciphertexts =
      all_bytes
      |> Helpers.pmap(fn byte -> {byte, encrypt(Enum.take(as, blocksize - 1) ++ [byte]) |> Enum.take(blocksize)} end)

    {first_byte, _} = Enum.find(all_bytes_ciphertexts, fn {_, ciphertext} -> ciphertext == first_byte_ciphertext end)
    assert first_byte == List.first(@unknown_bytes)
  end
end
