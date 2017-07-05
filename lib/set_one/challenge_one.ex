defmodule SetOne.ChallengeOne do
  @spec hex_to_base64(binary) :: binary
  def hex_to_base64(hex) do
    hex
    |> String.upcase
    |> Base.decode16!
    |> Base.encode64
  end
end
