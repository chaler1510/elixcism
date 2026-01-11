defmodule BirdCount do
  def today([]), do: nil
  def today(list), do: hd(list)
   
  def increment_day_count([]), do: [1]
  def increment_day_count([h | t]), do: [h + 1 | t]
    
  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _]), do: true
  def has_day_without_birds?([_ | t]) do
    has_day_without_birds?(t)
  end

  def total([]), do: 0
  def total([h | t]), do: h + total(t)

  def busy_days(list), do: busy_days(list, 0)

  defp busy_days([], acc), do: acc
  defp busy_days([h | t], acc) when h >= 5 do
    acc = acc + 1
    busy_days(t, acc)
  end
  defp busy_days([_ | t], acc), do: busy_days(t, acc)
end
