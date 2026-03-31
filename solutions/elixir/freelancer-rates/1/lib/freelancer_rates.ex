defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    hourly_rate * 8.0
  end

  def apply_discount(before_discount, discount) do
    before_discount - (before_discount * discount / 100)
  end

  def monthly_rate(hourly_rate, discount) do
    monthly_rate =
    daily_rate(hourly_rate) * 22
    |> apply_discount(discount)
    |> Float.ceil()
    |> Kernel.trunc()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    discounted_day = 
    daily_rate(hourly_rate)
    |> apply_discount(discount)
    days_in_budget = 
    budget / discounted_day
    |> Float.floor(1)

    end
    end