defmodule FinancialEquations.DerivativesAndHedging do
  @moduledoc """
  A module for derivatives and hedging calculations.
  """

  @doc """
  Calculates the futures price using the cost of carry model.

  ## Parameters
    - spot_price: Spot price of the underlying asset (float)
    - r: Risk-free rate (float)
    - q: Dividend yield or storage cost (float)
    - t: Time to expiration in years (float)

  ## Examples
      iex> DerivativesHedging.futures_price(100.0, 0.05, 0.02, 1.0)
      102.9701
  """
  @spec futures_price(float(), float(), float(), float()) :: float()
  def futures_price(spot_price, r, q, t) do
    spot_price * :math.exp((r - q) * t)
  end

  @doc """
  Calculates the hedge ratio for a minimum variance hedge.

  ## Parameters
    - p: Correlation coefficient between the spot and futures prices (float)
    - sigma_s: Standard deviation of the spot price (float)
    - sigma_f: Standard deviation of the futures price (float)

  ## Examples
      iex> DerivativesHedging.hedge_ratio(0.9, 0.2, 0.15)
      1.2
  """
  @spec hedge_ratio(float(), float(), float()) :: float()
  def hedge_ratio(p, sigma_s, sigma_f) do
    p * (sigma_s / sigma_f)
  end

  @doc """
  Calculates the value of an interest rate swap.

  ## Parameters
    - b_fixed: Value of the fixed leg (float)
    - b_floating: Value of the floating leg (float)

  ## Examples
      iex> DerivativesHedging.swap_value(1000.0, 980.0)
      20.0
  """
  @spec swap_value(float(), float()) :: float()
  def swap_value(b_fixed, b_floating) do
    b_fixed - b_floating
  end

  @doc """
  Calculates the Credit Default Swap (CDS) spread in basis points.

  ## Parameters
    - premium: Annual premium paid for default protection (float)
    - notional: Notional amount of the CDS (float)

  ## Examples
      iex> DerivativesHedging.cds_spread(50000.0, 10000000.0)
      50.0
  """
  @spec cds_spread(float(), float()) :: float()
  def cds_spread(premium, notional) do
    (premium / notional) * 10000
  end
end
