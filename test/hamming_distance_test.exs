defmodule HammingDistanceTest do
  use ExUnit.Case, async: true
  import HammingDistance

  test "hamming distance" do
    s1 = "this is a test"
    s2 = "wokka wokka!!!"
    assert hamming_distance(s1, s2) == 37
  end
end
