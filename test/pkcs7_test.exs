defmodule PKCS7Test do
  use ExUnit.Case, async: true
  import PKCS7

  test "padding" do
    input = 'YELLOW SUBMARINE'
    expected = 'YELLOW SUBMARINE' ++ [0x04, 0x04, 0x04, 0x04]

    assert pad(input, 16) == input
    assert pad(input, 20) == expected
  end
end
