defmodule HammingDistance do
  use Bitwise

  def hamming_distance(s1, s2) do
    Enum.zip(
      s1 |> :binary.bin_to_list,
      s2 |> :binary.bin_to_list
    )
    |> Enum.map(fn {a, b} -> bxor(a, b) |> count_bits end)
    |> Enum.sum
  end

  defp count_bits(bytes, count \\ 0)
  defp count_bits(0, count), do: count
  defp count_bits(byte, count) do
    if Integer.mod(byte, 2) == 1 do
      count_bits(byte >>> 1, count + 1)
    else
      count_bits(byte >>> 1, count)
    end
  end
end
