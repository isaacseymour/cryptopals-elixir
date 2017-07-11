defmodule AES.DetectModeTest do
  use ExUnit.Case, async: true

  def encryption_oracle(input) do
    key = random_bytes(16)

    bytes = random_bytes(padding_length()) ++ :binary.bin_to_list(input) ++ random_bytes(padding_length())

    {alg_name, alg} = choose_alg()
    {alg_name, alg.(bytes, key)}
  end

  def random_bytes(count) do
    Stream.repeatedly(fn -> :rand.uniform(255) end)
    |> Enum.take(count)
  end

  def padding_length, do: Enum.random(5..10)

  def choose_alg, do: Enum.random([{:cbc, &cbc/2}, {:ecb, &ecb/2}])

  def cbc(input, key), do: AES.CBC.encrypt(input, key, random_bytes(16))
  def ecb(input, key), do: AES.ECB.encrypt(input, key)

  test "produces output" do
    assert encryption_oracle("hello world") != nil
  end

  test "detects the mode" do
    input = Stream.repeatedly(fn -> "A" end) |> Enum.take(200) |> Enum.join

    {correct_name, output} = encryption_oracle(input)
    assert AES.DetectMode.detect(output) == correct_name

    {correct_name, output} = encryption_oracle(input)
    assert AES.DetectMode.detect(output) == correct_name

    {correct_name, output} = encryption_oracle(input)
    assert AES.DetectMode.detect(output) == correct_name
  end
end
