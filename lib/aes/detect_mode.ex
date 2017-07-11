defmodule AES.DetectMode do
  def detect(bytes) do
    if SetOne.ChallengeEight.is_ecb?(bytes) do
      :ecb
    else
      :cbc
    end
  end
end
