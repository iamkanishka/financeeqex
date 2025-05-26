defmodule FinancialEquations.FixedIncomeAndBondAnalytics do
  @moduledoc """
  A module for fixed income and bond analysis calculations.
  """

  @doc """
  Calculates the Yield to Call (YTC). Assumes the bond is called early.

  ## Parameters
    - price: Current bond price (float)
    - call_price: Call price of the bond (float)
    - coupon: Annual coupon payment (float)
    - years_to_call: Years until the call date (float)

  ## Examples
      iex> BondAnalysis.ytc(950.0, 1000.0, 50.0, 5.0)
      0.0641
  """
  def ytc(price, call_price, coupon, years_to_call) do
    # YTC is approximated using the formula: (Coupon + (Call Price - Price) / Years) / ((Call Price + Price) / 2)
    annual_gain = (call_price - price) / years_to_call
    average_price = (call_price + price) / 2
    (coupon + annual_gain) / average_price
  end

  @doc """
  Calculates the Yield to Worst (YTW). Assumes the lowest yield considering call/put options.

  ## Parameters
    - ytm: Yield to Maturity (float)
    - ytc: Yield to Call (float)
    - ytp: Yield to Put (float)

  ## Examples
      iex> BondAnalysis.ytw(0.06, 0.05, 0.07)
      0.05
  """
  def ytw(ytm, ytc, ytp) do
    Enum.min([ytm, ytc, ytp])
  end

  @doc """
  Calculates the Bond Equivalent Yield (BEY).

  ## Parameters
    - semi_annual_yield: Semi-annual yield (float)

  ## Examples
      iex> BondAnalysis.bey(0.03)
      0.0618
  """
  def bey(semi_annual_yield) do
    2 * (:math.pow(1 + semi_annual_yield, 2) - 1)
  end

  @doc """
  Calculates the Taxable Equivalent Yield (TEY).

  ## Parameters
    - tax_free_yield: Tax-free yield (float)
    - marginal_tax_rate: Marginal tax rate (float)

  ## Examples
      iex> BondAnalysis.tey(0.04, 0.3)
      0.0571
  """
  def tey(tax_free_yield, marginal_tax_rate) do
    tax_free_yield / (1 - marginal_tax_rate)
  end

  @doc """
  Calculates the price of a zero-coupon bond.

  ## Parameters
    - face_value: Face value of the bond (float)
    - yield: Yield to maturity (float)
    - years: Years to maturity (float)

  ## Examples
      iex> BondAnalysis.zero_coupon_bond_price(1000.0, 0.05, 2.0)
      905.9507
  """
  def zero_coupon_bond_price(face_value, yield, years) do
    face_value / :math.pow(1 + yield, years)
  end

  @doc """
  Calculates the spot rate (zero-coupon yield) for a given maturity.

  ## Parameters
    - price: Price of the zero-coupon bond (float)
    - face_value: Face value of the bond (float)
    - years: Years to maturity (float)

  ## Examples
      iex> BondAnalysis.spot_rate(905.9507, 1000.0, 2.0)
      0.05
  """
  def spot_rate(price, face_value, years) do
    (:math.pow(face_value / price, 1 / years) - 1)
  end

  @doc """
  Calculates the forward rate from spot rates.

  ## Parameters
    - spot_rate_n: Spot rate for the longer period (float)
    - spot_rate_t: Spot rate for the shorter period (float)
    - n: Longer period in years (float)
    - t: Shorter period in years (float)

  ## Examples
      iex> BondAnalysis.forward_rate(0.05, 0.04, 2.0, 1.0)
      0.0601
  """
  def forward_rate(spot_rate_n, spot_rate_t, n, t) do
    term1 = (1 + spot_rate_n) |> :math.pow(n)
    term2 = (1 + spot_rate_t) |> :math.pow(t)
    (:math.pow(term1 / term2, 1 / (n - t)) - 1)
  end
end
