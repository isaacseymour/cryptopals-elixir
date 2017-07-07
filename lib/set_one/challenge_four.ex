defmodule SetOne.ChallengeFour do
  def find_line(path) do
    File.stream!(path)
    |> Enum.map(&String.strip/1)
    |> Enum.map(&SetOne.ChallengeThree.decode/1)
    |> Enum.with_index
    |> Enum.map(fn {{plaintext, score, key}, index} -> {plaintext, score, key, index} end)
    |> Enum.max_by(fn {_plain, score, _key, _index} -> score end)
  end
end
