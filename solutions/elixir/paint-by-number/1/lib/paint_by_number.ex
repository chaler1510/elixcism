defmodule PaintByNumber do
  @spec palette_bit_size(pos_integer()) :: pos_integer()
  def palette_bit_size(color_count) when is_integer(color_count) and color_count >= 0 do
    palette_bit_size(color_count, 1)
  end

  @spec palette_bit_size(pos_integer(), pos_integer()) :: pos_integer()
  defp palette_bit_size(color_count, power) do
    if 2 ** power >= color_count, do: power, else: palette_bit_size(color_count, power + 1)
  end

  @spec empty_picture() :: bitstring()
  def empty_picture(), do: <<>>

  @spec test_picture() :: bitstring()
  def test_picture(), do: <<0::2, 1::2, 2::2, 3::2>>

  @spec prepend_pixel(bitstring(), pos_integer(), pos_integer()) :: bitstring()
  def prepend_pixel(picture, color_count, pixel_color_index) do
    bit_size = palette_bit_size(color_count)
    <<pixel_color_index::size(bit_size), picture::bitstring>>
  end

  @spec get_first_pixel(bitstring(), pos_integer()) :: bitstring()
  def get_first_pixel(<<>>, _color_count), do: nil

  def get_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    <<first::size(bit_size), _rest::bitstring>> = picture
    first
  end

  @spec drop_first_pixel(bitstring(), pos_integer()) :: bitstring()
  def drop_first_pixel(<<>>, _color_count), do: <<>>

  def drop_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    <<_first::size(bit_size), rest::bitstring>> = picture
    rest
  end

  @spec concat_pictures(bitstring(), bitstring()) :: bitstring()
  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
