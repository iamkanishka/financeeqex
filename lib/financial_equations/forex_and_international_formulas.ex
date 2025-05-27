defmodule FinancialEquations.ForexAndInternationalFormulas do
  @moduledoc """
  A module for forex and international finance calculations including currency exchange,
  cross-currency rates, purchasing power parity, and interest rate parity.
  All functions assume inputs are numerical and appropriate (e.g., non-zero denominators).
  """

  @doc """
  Calculates Currency Exchange (Direct Quote): Foreign Amount = Domestic Amount x Exchange Rate

  ## Parameters
    - domestic_amount: The amount in domestic currency
    - exchange_rate: The exchange rate (domestic per foreign unit)

  ## Examples
      iex> FinancialEquations.ForexInternationalFormulas.currency_exchange_direct(1000, 0.013)
      13.0
  """
  @spec currency_exchange_direct(float(), float()) :: float()
  def currency_exchange_direct(domestic_amount, exchange_rate) do
    domestic_amount * exchange_rate
  end

  @doc """
  Calculates Cross-Currency Rate: Currency A / Currency B = (Currency A / USD) / (Currency B / USD)

  ## Parameters
    - rate_a_usd: Exchange rate of Currency A to USD (Currency A per USD)
    - rate_b_usd: Exchange rate of Currency B to USD (Currency B per USD)

  ## Examples
      iex> FinancialEquations.ForexInternationalFormulas.cross_currency_rate(0.85, 1.25)
      0.68
  """
  @spec cross_currency_rate(float(), float()) :: float()
  def cross_currency_rate(rate_a_usd, rate_b_usd) do
    rate_a_usd / rate_b_usd
  end

  @doc """
  Calculates Purchasing Power Parity (PPP): S1 = S0 x (1 + i_d) / (1 + i_f)

  ## Parameters
    - spot_rate: The current spot exchange rate (S0, domestic per foreign unit)
    - domestic_inflation: Domestic inflation rate (as a decimal, e.g., 2% as 0.02)
    - foreign_inflation: Foreign inflation rate (as a decimal, e.g., 3% as 0.03)

  ## Examples
      iex> FinancialEquations.ForexInternationalFormulas.purchasing_power_parity(1.0, 0.02, 0.03)
      0.9902912621359223
  """
  @spec purchasing_power_parity(float(), float(), float()) :: float()
  def purchasing_power_parity(spot_rate, domestic_inflation, foreign_inflation) do
    spot_rate * (1 + domestic_inflation) / (1 + foreign_inflation)
  end

  @doc """
  Calculates Interest Rate Parity (IRP): F = S x (1 + i_d) / (1 + i_f)

  ## Parameters
    - spot_rate: The current spot exchange rate (S, domestic per foreign unit)
    - domestic_interest_rate: Domestic interest rate (as a decimal, e.g., 4% as 0.04)
    - foreign_interest_rate: Foreign interest rate (as a decimal, e.g., 5% as 0.05)

  ## Examples
      iex> FinancialEquations.ForexInternationalFormulas.interest_rate_parity(1.0, 0.04, 0.05)
      0.9904761904761905
  """
  @spec interest_rate_parity(float(), float(), float()) :: float()
  def interest_rate_parity(spot_rate, domestic_interest_rate, foreign_interest_rate) do
    spot_rate * (1 + domestic_interest_rate) / (1 + foreign_interest_rate)
  end
end
