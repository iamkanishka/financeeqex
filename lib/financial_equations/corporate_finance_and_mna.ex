defmodule FinancialEquations.CorporateFinanceAndMna do
  @moduledoc """
  A module for corporate finance and mergers & acquisitions calculations.
  """

  @doc """
  Calculates the Internal Rate of Return (IRR) for a Leveraged Buyout (LBO).

  ## Parameters
    - exit_equity_value: Exit equity value (float)
    - initial_equity_investment: Initial equity investment (float)
    - t: Time period in years (float)

  ## Examples
      iex> CorporateFinanceMNA.lbo_irr(2000.0, 1000.0, 2.0)
      0.4142
  """
  def lbo_irr(exit_equity_value, initial_equity_investment, t) do
    (:math.pow(exit_equity_value / initial_equity_investment, 1 / t) - 1)
  end

  @doc """
  Calculates the value of synergy in an M&A transaction.

  ## Parameters
    - pv_combined: Present value of the combined firm (float)
    - pv_acquirer: Present value of the acquirer (float)
    - pv_target: Present value of the target (float)

  ## Examples
      iex> CorporateFinanceMNA.synergy_value(1500.0, 800.0, 600.0)
      100.0
  """
  def synergy_value(pv_combined, pv_acquirer, pv_target) do
    pv_combined - pv_acquirer - pv_target
  end

  @doc """
  Calculates the goodwill in an M&A transaction.

  ## Parameters
    - purchase_price: Purchase price of the target (float)
    - fair_market_value_net_assets: Fair market value of the target's net assets (float)

  ## Examples
      iex> CorporateFinanceMNA.goodwill(1200.0, 1000.0)
      200.0
  """
  def goodwill(purchase_price, fair_market_value_net_assets) do
    purchase_price - fair_market_value_net_assets
  end

  @doc """
  Calculates the Economic Order Quantity (EOQ).

  ## Parameters
    - d: Annual demand (float)
    - s: Order cost per order (float)
    - h: Holding cost per unit per year (float)

  ## Examples
      iex> CorporateFinanceMNA.eoq(1000.0, 50.0, 2.0)
      500.0
  """
  def eoq(d, s, h) do
    :math.sqrt((2 * d * s) / h)
  end

  @doc """
  Calculates the Altman Z-Score for bankruptcy prediction.

  ## Parameters
    - a: Working Capital / Assets (float)
    - b: Retained Earnings / Assets (float)
    - c: EBIT / Assets (float)
    - d: Market Value of Equity / Total Liabilities (float)
    - e: Sales / Assets (float)

  ## Examples
      iex> CorporateFinanceMNA.altman_z_score(0.2, 0.3, 0.1, 1.5, 1.0)
      3.55
  """
  def altman_z_score(a, b, c, d, e) do
    1.2 * a + 1.4 * b + 3.3 * c + 0.6 * d + 1.0 * e
  end
end
