defmodule Chessboard do
  @spec rank_range() :: Range.t()
  def rank_range do
    1..8
  end
  
  @spec file_range() :: Range.t()
  def file_range do
    ?A..?H
  end

  @spec ranks() :: [pos_integer]
  def ranks do
    Enum.map(rank_range(), &(&1))
  end

  @spec files() :: [String.t()]
  def files do
    Enum.map(file_range(), &(<<&1>>))
  end
end
