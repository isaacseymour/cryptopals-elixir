defmodule PKCS7 do
  @eot 0x04 # "end of transmission" character

  def pad(bytes, blocksize \\ 16) do
    mod = bytes |> Enum.count |> Integer.mod(blocksize)

    if mod == 0 do
      bytes
    else
      bytes ++ ((0..(blocksize - mod - 1)) |> Enum.map(fn _ -> @eot end))
    end
  end

  def unpad(bytes) do
    bytes
    |> Enum.reverse
    |> Enum.drop_while(fn byte -> byte == @eot end)
    |> Enum.reverse
  end
end
