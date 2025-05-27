defmodule FinancialEquations.InvestmentReturnFormulas do
  @moduledoc """
  A module for investment and return calculations including ROI, NPV, payback period, profitability index,
  CAPM, DDM, and bond-related metrics.
  All functions assume that rates are provided as decimals (e.g., 5% as 0.05) unless specified.
  """

  @doc """
  Calculates Return on Investment (ROI): ROI = (Net Profit / Initial Investment) x 100%

  ## Parameters
    - net_profit: The net profit from the investment
    - initial_investment: The initial amount invested

  ## Examples
      iex> FinancialEquations.InvestmentReturnFormulas.return_on_investment(2000, 10000)
      20.0
  """
  @spec return_on_investment(number(), number()) :: number()
  def return_on_investment(net_profit, initial_investment) do
    (net_profit / initial_investment) * 100
  end

  @doc """
  Calculates Net Present Value (NPV): NPV = Σ (Cash Flow / (1 + r)^t) - Initial Investment

  ## Parameters
    - cash_flows: A list of cash flows over time
    - rate: The discount rate as a decimal (r)
    - initial_investment: The initial amount invested

  ## Examples
      iex> FinancialEquations.InvestmentReturnFormulas.net_present_value([1000, 1000, 1000], 0.1, 2500)
      248.685
  """
  @spec net_present_value(list(number()), number(), number()) :: number()
  def net_present_value(cash_flows, rate, initial_investment) do
    discounted_cash_flows =
      cash_flows
      |> Enum.with_index(1)
      |> Enum.map(fn {cash_flow, t} -> cash_flow / :math.pow(1 + rate, t) end)
      |> Enum.sum()

    discounted_cash_flows - initial_investment
  end

  @doc """
  Calculates Payback Period: Payback Period = Initial Investment / Annual Cash Flow

  ## Parameters
    - initial_investment: The initial amount invested
    - annual_cash_flow: The annual cash inflow

  ## Examples
      iex> FinancialEquations.InvestmentReturnFormulas.payback_period(10000, 2500)
      4.0
  """
  @spec payback_period(number(), number()) :: number()
  def payback_period(initial_investment, annual_cash_flow) do
    initial_investment / annual_cash_flow
  end

  @doc """
  Calculates Discounted Payback Period by determining the time to recover the initial investment with discounted cash flows.

  ## Parameters
    - cash_flows: A list of cash flows over time
    - rate: The discount rate as a decimal (r)
    - initial_investment: The initial amount invested

  ## Examples
      iex> FinancialEquations.InvestmentReturnFormulas.discounted_payback_period([1000, 1000, 1000, 1000], 0.1, 3000)
      4
  """
  @spec discounted_payback_period(list(number()), number(), number()) :: integer()
  def discounted_payback_period(cash_flows, rate, initial_investment) do
    {period, _} =
      cash_flows
      |> Enum.with_index(1)
      |> Enum.reduce_while({0, -initial_investment}, fn {cash_flow, t}, {_, cumulative} ->
        discounted_cash_flow = cash_flow / :math.pow(1 + rate, t)
        new_cumulative = cumulative + discounted_cash_flow

        if new_cumulative >= 0 do
          {:halt, {t, new_cumulative}}
        else
          {:cont, {t, new_cumulative}}
        end
      end)

    period
  end

  @doc """
  Calculates Profitability Index (PI): PI = (Σ Cash Flow / (1 + r)^t) / Initial Investment

  ## Parameters
    - cash_flows: A list of cash flows over time
    - rate: The discount rate as a decimal (r)
    - initial_investment: The initial amount invested

  ## Examples
      iex> FinancialEquations.InvestmentReturnFormulas.profitability_index([1000, 1000, 1000], 0.1, 2500)
      0.999474
  """
  @spec profitability_index(list(number()), number(), number()) :: number()
  def profitability_index(cash_flows, rate, initial_investment) do
    discounted_cash_flows =
      cash_flows
      |> Enum.with_index(1)
      |> Enum.map(fn {cash_flow, t} -> cash_flow / :math.pow(1 + rate, t) end)
      |> Enum.sum()

    discounted_cash_flows / initial_investment
  end

  @doc """
  Calculates the expected return using the Capital Asset Pricing Model (CAPM): E(R) = Rf + β (Rm - Rf)

  ## Parameters
    - risk_free_rate: The risk-free rate as a decimal (Rf)
    - beta: The stock's beta (β)
    - market_return: The expected market return as a decimal (Rm)

  ## Examples
      iex> FinancialEquations.InvestmentReturnFormulas.capital_asset_pricing_model(0.03, 1.2, 0.1)
      0.114
  """
  @spec capital_asset_pricing_model(number(), number(), number()) :: number()
  def capital_asset_pricing_model(risk_free_rate, beta, market_return) do
    risk_free_rate + beta * (market_return - risk_free_rate)
  end

  @doc """
  Calculates the stock price using the Dividend Discount Model (DDM): P = D / (r - g)

  ## Parameters
    - dividend: The expected dividend per share (D)
    - rate: The required rate of return as a decimal (r)
    - growth_rate: The dividend growth rate as a decimal (g)

  ## Examples
      iex> FinancialEquations.InvestmentReturnFormulas.dividend_discount_model(2, 0.1, 0.05)
      40.0
  """
  @spec dividend_discount_model(number(), number(), number()) :: number()
  def dividend_discount_model(dividend, rate, growth_rate) do
    dividend / (rate - growth_rate)
  end

  @doc """
  Calculates the present value of a bond: PV = Σ (C / (1 + r)^t) + (F / (1 + r)^n)

  ## Parameters
    - coupon: The annual coupon payment (C)
    - rate: The yield to maturity as a decimal (r)
    - periods: The number of periods until maturity (n)
    - face_value: The bond's face value (F)

  ## Examples
      iex> FinancialEquations.InvestmentReturnFormulas.present_value_bond(50, 0.05, 3, 1000)
      1000.0
  """
  @spec present_value_bond(number(), number(), number(), number()) :: number()
  def present_value_bond(coupon, rate, periods, face_value) do
    coupon_payments =
      1..periods
      |> Enum.map(fn t -> coupon / :math.pow(1 + rate, t) end)
      |> Enum.sum()

    face_value_discounted = face_value / :math.pow(1 + rate, periods)
    coupon_payments + face_value_discounted
  end

  @doc """
  Calculates the current yield of a bond: Current Yield = (C / P)

  ## Parameters
    - coupon: The annual coupon payment (C)
    - price: The current market price of the bond (P)

  ## Examples
      iex> FinancialEquations.InvestmentReturnFormulas.current_yield(50, 1000)
      0.05
  """
  @spec current_yield(number(), number()) :: number()
  def current_yield(coupon, price) do
    coupon / price
  end

  @doc """
  Calculates the Yield to Maturity (YTM) of a bond using an approximation: YTM = (C + (F - P)/n) / ((F + P)/2)

  ## Parameters
    - coupon: The annual coupon payment (C)
    - face_value: The bond's face value (F)
    - price: The current market price of the bond (P)
    - periods: The number of periods until maturity (n)

  ## Examples
      iex> FinancialEquations.InvestmentReturnFormulas.yield_to_maturity(50, 1000, 950, 3)
      0.0625
  """
  @spec yield_to_maturity(number(), number(), number(), number()) :: number()
  def yield_to_maturity(coupon, face_value, price, periods) do
    (coupon + (face_value - price) / periods) / ((face_value + price) / 2)
  end

  @doc """
  Calculates the Modified Duration (D*): D* = D / (1 + r/m)

  ## Parameters
    - duration: The Macaulay duration (D)
    - rate: The yield to maturity as a decimal (r)
    - periods_per_year: The number of compounding periods per year (m)

  ## Examples
      iex> FinancialEquations.InvestmentReturnFormulas.modified_duration(3, 0.05, 1)
      2.857142857142857
  """
  @spec modified_duration(number(), number(), number()) :: number()
  def modified_duration(duration, rate, periods_per_year) do
    duration / (1 + rate / periods_per_year)
  end

  @doc """
  Calculates Convexity: Convexity = (Σ (t(t+1) * CF_t / (1 + r)^t)) / (P * (1 + r)^2)

  This is a simplified version assuming annual cash flows.

  ## Parameters
    - cash_flows: A list of cash flows over time (CF_t)
    - rate: The yield to maturity as a decimal (r)
    - price: The current market price of the bond (P)

  ## Examples
      iex> FinancialEquations.InvestmentReturnFormulas.convexity([50, 50, 1050], 0.05, 1000)
      8.843537414965986
  """
  @spec convexity(list(), number(), number()) :: number()
  def convexity(cash_flows, rate, price) do
    sum =
      cash_flows
      |> Enum.with_index(1)
      |> Enum.map(fn {cash_flow, t} -> t * (t + 1) * cash_flow / :math.pow(1 + rate, t) end)
      |> Enum.sum()

    sum / (price * :math.pow(1 + rate, 2))
  end
end
