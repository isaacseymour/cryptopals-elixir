defmodule SetOne.ChallengeSix do
  def decode(data) do
    data |> String.replace("\n", "") |> Base.decode64! |> :binary.bin_to_list
  end

  def decrypt(cipherbytes, key) do
    cipherbytes
    |> to_string
    |> SetOne.ChallengeFive.encrypt(key)
    |> Helpers.decode_hex
    |> to_string
  end

  def likely_keys(cipherbytes, comparisons \\ 1, top \\ 5) do
    (2..40)
    # generate a score for the keysizes
    |> Helpers.pmap(&rank_keysize(&1, cipherbytes, comparisons))
    |> Enum.sort_by(&elem(&1, 1)) # sort by lowest distance first
    |> Enum.take(top) # take the top n best
    |> Enum.map(&elem(&1, 0)) # discard the scores
    |> Helpers.pmap(&guess_for_keysize(&1, cipherbytes)) # guess the keys
  end

  def rank_keysize(keysize, cipherbytes, comparisons \\ 1) do
    total_distances = cipherbytes
    |> Enum.chunk(keysize)
    |> Enum.take(comparisons * 2)
    |> Enum.map(&to_string/1)
    |> Enum.chunk(2)
    |> Enum.map(fn [chunk1, chunk2] -> HammingDistance.hamming_distance(chunk1, chunk2) end)
    |> Enum.sum

    {keysize, (total_distances / keysize) / comparisons}
  end

  def guess_for_keysize(keysize, cipherbytes) do
    cipherbytes
    |> Enum.chunk(keysize)
    |> Enum.zip
    |> Enum.map(&Tuple.to_list/1)
    |> Helpers.pmap(&SetOne.ChallengeThree.decode_bytes/1)
    |> Enum.map(fn {_value, _score, key} -> key end)
    |> to_string
  end
end
