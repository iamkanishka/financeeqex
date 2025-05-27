defmodule FinancialEquations.TimeValueMoneyFormulas do
  @moduledoc """
  A module for time value of money (TVM) calculations including annuities and sinking funds.
  All functions assume that rates are provided as decimals (e.g., 5% as 0.05) and time is in periods (e.g., years) unless specified.
  """

  @doc """
  Calculates the ordinary annuity payment: P = (r x PV) / (1 - (1 + r)^(-t))

  ## Parameters
    - present_value: The present value of the annuity (PV)
    - rate: The interest rate per period as a decimal (r)
    - periods: The number of periods (t)

  ## Examples
      iex> FinancialEquations.TimeValueMoneyFormulas.annuity_payment_ordinary(1000, 0.05, 3)
      367.208
  """
  @spec annuity_payment_ordinary(float(), float(), integer()) :: float()
  def annuity_payment_ordinary(present_value, rate, periods) do
    rate * present_value / (1 - :math.pow(1 + rate, -periods))
  end

  @doc """
  Calculates the annuity payment due: P = (r x PV) / ((1 + r) * (1 - (1 + r)^(-t)))

  ## Parameters
    - present_value: The present value of the annuity (PV)
    - rate: The interest rate per period as a decimal (r)
    - periods: The number of periods (t)

  ## Examples
      iex> FinancialEquations.TimeValueMoneyFormulas.annuity_payment_due(1000, 0.05, 3)
      349.722
  """
  @spec annuity_payment_due(float(), float(), integer()) :: float()
  def annuity_payment_due(present_value, rate, periods) do
    rate * present_value / ((1 + rate) * (1 - :math.pow(1 + rate, -periods)))
  end

  @doc """
  Calculates the present value of a growing annuity: PV = P x (1 - ((1 + g)/(1 + r))^t) / (r - g)

  ## Parameters
    - payment: The initial payment (P)
    - rate: The interest rate per period as a decimal (r)
    - growth_rate: The growth rate of the payment as a decimal (g)
    - periods: The number of periods (t)

  ## Examples
      iex> FinancialEquations.TimeValueMoneyFormulas.growing_annuity_pv(100, 0.05, 0.02, 3)
      286.698
  """
  @spec growing_annuity_pv(float(), float(), float(), integer()) :: float()
  def growing_annuity_pv(payment, rate, growth_rate, periods) do
    payment * (1 - :math.pow((1 + growth_rate) / (1 + rate), periods)) / (rate - growth_rate)
  end

  @doc """
  Calculates the future value of a growing annuity: FV = P x ((1 + r)^t - (1 + g)^t) / (r - g)

  ## Parameters
    - payment: The initial payment (P)
    - rate: The interest rate per period as a decimal (r)
    - growth_rate: The growth rate of the payment as a decimal (g)
    - periods: The number of periods (t)

  ## Examples
      iex> FinancialEquations.TimeValueMoneyFormulas.future_value_growing_annuity(100, 0.05, 0.02, 3)
      315.901
  """
  @spec future_value_growing_annuity(float(), float(), float(), integer()) :: float()
  def future_value_growing_annuity(payment, rate, growth_rate, periods) do
    payment * (:math.pow(1 + rate, periods) - :math.pow(1 + growth_rate, periods)) /
      (rate - growth_rate)
  end

  @doc """
  Calculates the sinking fund payment (savings for future obligation): P = (FV x r) / ((1 + r)^t - 1)

  ## Parameters
    - future_value: The future value to be saved (FV)
    - rate: The interest rate per period as a decimal (r)
    - periods: The number of periods (t)

  ## Examples
      iex> FinancialEquations.TimeValueMoneyFormulas.sinking_fund(1000, 0.05, 3)
      317.208
  """
  @spec sinking_fund(float(), float(), integer()) :: float()
  def sinking_fund(future_value, rate, periods) do
    future_value * rate / (:math.pow(1 + rate, periods) - 1)
  end
end
