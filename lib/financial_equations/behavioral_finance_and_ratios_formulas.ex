defmodule FinancialEquations.BehavioralFinanceAndRatiosFormulas do
  @moduledoc """
  A module for calculating various financial metrics used in behavioral finance and portfolio analysis.
  """

  @doc """
  Calculates the Herfindahl-Hirschman Index (HHI), a measure of market concentration.

  The HHI is calculated as the sum of the squares of market shares (expressed as percentages).

  ## Parameters
    - market_shares: A list of market shares (as percentages, e.g., [40, 30, 20, 10])

  ## Returns
    - A float representing the HHI value

  ## Examples
      iex> FinancialMetrics.calculate_hhi([40, 30, 20, 10])
      3000.0
  """
  @spec calculate_hhi([number()]) :: float()
  def calculate_hhi(market_shares) do
    market_shares
    |> Enum.map(fn share -> share * share end)
    |> Enum.sum()
    |> Kernel./(1.0)
  end

  @doc """
  Calculates the Gini Coefficient, a measure of wealth inequality.

  The Gini Coefficient ranges from 0 (perfect equality) to 1 (maximum inequality).

  ## Parameters
    - values: A list of wealth values for individuals or entities

  ## Returns
    - A float between 0 and 1 representing the Gini Coefficient

  ## Examples
      iex> FinancialMetrics.calculate_gini([1, 1, 1, 1])
      0.0
      iex> FinancialMetrics.calculate_gini([1, 0, 0, 0])
      0.75
  """
  @spec calculate_gini([number()]) :: float()
  def calculate_gini(values) do
    n = length(values)
    if n == 0, do: 0.0

    sorted = Enum.sort(values)
    indexed_sum =
      sorted
      |> Enum.with_index(1)
      |> Enum.reduce(0, fn {val, idx}, acc -> acc + idx * val end)

    total = Enum.sum(values)
    if total == 0, do: 0.0

    (2 * indexed_sum) / (n * total) - (n + 1) / n
  end

  @doc """
  Calculates the PEG Ratio (Price/Earnings to Growth).

  The PEG Ratio is calculated as (Price/Earnings) / Earnings Growth Rate.

  ## Parameters
    - pe_ratio: The Price-to-Earnings ratio (float)
    - growth_rate: The earnings growth rate (as a percentage, e.g., 15 for 15%)

  ## Returns
    - A float representing the PEG ratio

  ## Examples
      iex> FinancialMetrics.calculate_peg(20.0, 15.0)
      1.3333333333333333
  """
  @spec calculate_peg(float(), float()) :: float()
  def calculate_peg(pe_ratio, growth_rate) do
    if growth_rate == 0, do: :error
    pe_ratio / growth_rate
  end

  @doc """
  Calculates the EV/EBITDA ratio (Enterprise Value to EBITDA).

  The EV/EBITDA ratio is calculated as Enterprise Value / EBITDA.

  ## Parameters
    - enterprise_value: The enterprise value (float)
    - ebitda: The EBITDA value (Earnings Before Interest, Taxes, Depreciation, and Amortization) (float)

  ## Returns
    - A float representing the EV/EBITDA ratio

  ## Examples
      iex> FinancialMetrics.calculate_ev_ebitda(1000.0, 200.0)
      5.0
  """
  @spec calculate_ev_ebitda(float(), float()) :: float()
  def calculate_ev_ebitda(enterprise_value, ebitda) do
    if ebitda == 0, do: :error
    enterprise_value / ebitda
  end

  @doc """
  Calculates the Sharpe's Reward-to-Variability Ratio (Sharpe Ratio) for portfolios.

  The Sharpe Ratio is calculated as (Portfolio Return - Risk-Free Rate) / Portfolio Standard Deviation.

  ## Parameters
    - portfolio_return: The portfolio's return (as a percentage, e.g., 10 for 10%)
    - risk_free_rate: The risk-free rate (as a percentage, e.g., 2 for 2%)
    - standard_deviation: The portfolio's standard deviation (as a percentage)

  ## Returns
    - A float representing the Sharpe Ratio

  ## Examples
      iex> FinancialMetrics.calculate_sharpe_ratio(10.0, 2.0, 15.0)
      0.5333333333333333
  """
  @spec calculate_sharpe_ratio(float(), float(), float()) :: float()
  def calculate_sharpe_ratio(portfolio_return, risk_free_rate, standard_deviation) do
    if standard_deviation == 0, do: :error
    (portfolio_return - risk_free_rate) / standard_deviation
  end
end
