defmodule SetOne.ChallengeEight do
  def find_ecb_line(text) do
    text
    |> String.split("\n")
    |> Enum.map(&Helpers.decode_hex/1)
    |> Enum.map(fn bytes -> Enum.chunk(bytes, 16) end)
    |> Enum.find_index(&non_unique_chunks?/1)
  end

  defp non_unique_chunks?(chunks) do
    num_chunks = chunks |> Enum.count
    num_uniq_chunks = chunks |> Enum.uniq |> Enum.count
    num_uniq_chunks < num_chunks
  end
end
