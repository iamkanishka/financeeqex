defmodule FinancialEquations.CorporateFinanceAndValuation do
  @moduledoc """
  A module for corporate finance and valuation calculations.
  """

  @doc """
  Calculates the Weighted Average Cost of Capital (WACC).

  ## Parameters
    - e: Equity (float)
    - d: Debt (float)
    - v: Total value (E + D) (float)
    - re: Cost of equity (float)
    - rd: Cost of debt (float)
    - t: Tax rate (float)

  ## Examples
      iex> FinanceValuation.wacc(100.0, 50.0, 150.0, 0.1, 0.05, 0.3)
      0.08333333333333333
  """
  def wacc(e, d, v, re, rd, t) do
    (e / v) * re + (d / v) * rd * (1 - t)
  end

  @doc """
  Calculates the Free Cash Flow (FCF).

  ## Parameters
    - operating_cash_flow: Operating cash flow (float)
    - capital_expenditures: Capital expenditures (float)

  ## Examples
      iex> FinanceValuation.fcf(100.0, 30.0)
      70.0
  """
  def fcf(operating_cash_flow, capital_expenditures) do
    operating_cash_flow - capital_expenditures
  end

  @doc """
  Calculates the Enterprise Value (EV).

  ## Parameters
    - market_cap: Market capitalization (float)
    - debt: Debt (float)
    - cash: Cash (float)

  ## Examples
      iex> FinanceValuation.ev(200.0, 50.0, 20.0)
      230.0
  """
  def ev(market_cap, debt, cash) do
    market_cap + debt - cash
  end

  @doc """
  Calculates the Equity Value.

  ## Parameters
    - ev: Enterprise value (float)
    - debt: Debt (float)
    - cash: Cash (float)

  ## Examples
      iex> FinanceValuation.equity_value(230.0, 50.0, 20.0)
      200.0
  """
  def equity_value(ev, debt, cash) do
    ev - debt + cash
  end

  @doc """
  Calculates the Discounted Cash Flow (DCF) Valuation.

  ## Parameters
    - fcfs: List of free cash flows (list of floats)
    - wacc: Weighted average cost of capital (float)
    - tv: Terminal value (float)

  ## Examples
      iex> FinanceValuation.dcf_valuation([100.0, 110.0], 0.1, 1000.0)
      918.1818181818182
  """
  def dcf_valuation(fcfs, wacc, tv) do
    discounted_fcfs =
      fcfs
      |> Enum.with_index(1)
      |> Enum.reduce(0.0, fn {fcf, t}, acc ->
        acc + (fcf / :math.pow(1 + wacc, t))
      end)

    discounted_tv = tv / :math.pow(1 + wacc, length(fcfs))
    discounted_fcfs + discounted_tv
  end

  @doc """
  Calculates Levered Beta.

  ## Parameters
    - bu: Unlevered beta (float)
    - t: Tax rate (float)
    - d: Debt (float)
    - e: Equity (float)

  ## Examples
      iex> FinanceValuation.levered_beta(1.0, 0.3, 50.0, 100.0)
      1.35
  """
  def levered_beta(bu, t, d, e) do
    bu * (1 + (1 - t) * (d / e))
  end

  @doc """
  Calculates Unlevered Beta.

  ## Parameters
    - bl: Levered beta (float)
    - t: Tax rate (float)
    - d: Debt (float)
    - e: Equity (float)

  ## Examples
      iex> FinanceValuation.unlevered_beta(1.35, 0.3, 50.0, 100.0)
      1.0
  """
  def unlevered_beta(bl, t, d, e) do
    bl / (1 + (1 - t) * (d / e))
  end

  @doc """
  Calculates Economic Value Added (EVA).

  ## Parameters
    - nopat: Net operating profit after tax (float)
    - wacc: Weighted average cost of capital (float)
    - invested_capital: Invested capital (float)

  ## Examples
      iex> FinanceValuation.eva(100.0, 0.1, 800.0)
      20.0
  """
  def eva(nopat, wacc, invested_capital) do
    nopat - (wacc * invested_capital)
  end

  @doc """
  Calculates the Dividend Payout Ratio.

  ## Parameters
    - dividends: Dividends (float)
    - net_income: Net income (float)

  ## Examples
      iex> FinanceValuation.dividend_payout_ratio(40.0, 100.0)
      0.4
  """
  def dividend_payout_ratio(dividends, net_income) do
    dividends / net_income
  end

  @doc """
  Calculates the Retention Ratio.

  ## Parameters
    - payout_ratio: Dividend payout ratio (float)

  ## Examples
      iex> FinanceValuation.retention_ratio(0.4)
      0.6
  """
  def retention_ratio(payout_ratio) do
    1 - payout_ratio
  end
end
