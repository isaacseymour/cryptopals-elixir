defmodule AES.Operations do
  use Bitwise
  require Integer

  @m 0x1b

  def add(b1, b2), do: bxor(b1, b2)

  def xtime(byte) do
    shifted = byte <<< 1
    if shifted > 255 do
      bxor(Integer.mod(shifted, 256), @m)
    else
      shifted
    end
  end

  def mul(_b1, 0), do: 0
  def mul(b1, 1), do: b1
  def mul(b1, b2) do
    if Integer.is_even(b2) do
      mul(xtime(b1), div(b2, 2))
    else
      add(mul(b1, b2 - 1), b1)
    end
  end
end
