defmodule AES.OperationsTest do
  use ExUnit.Case, async: true
  import AES.Operations

  test "adding" do
    assert add(0x57, 0x83) == 0xd4
  end

  test "xtime" do
    assert xtime(0x57) == 0xae
    assert xtime(0xae) == 0x47
    assert xtime(0x47) == 0x8e
    assert xtime(0x8e) == 0x07
  end

  test "multiplying" do
    assert mul(0x57, 0x83) == 0xc1
    assert mul(0x57, 0x04) == 0x47
    assert mul(0x57, 0x08) == 0x8e
    assert mul(0x57, 0x10) == 0x07
    assert mul(0x57, 0x13) == 0xfe
  end
end