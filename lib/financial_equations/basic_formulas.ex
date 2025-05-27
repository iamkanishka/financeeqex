defmodule FinancialEquations.BasicFormulas do
  @moduledoc """
  A module for basic financial calculations including interest, future/present value, annuities, and perpetuities.
  All functions assume that inputs like rates are provided as decimals (e.g., 5% as 0.05) and time is in years unless specified.
  """

  @doc """
  Calculates simple interest: I = P x r x t

  ## Parameters
    - principal: The initial amount of money (P)
    - rate: The interest rate per period as a decimal (r)
    - time: The time period in years (t)

  ## Examples
      iex> FinancialEquations.BasicFormulas.simple_interest(1000, 0.05, 2)
      100.0
  """
  @spec simple_interest(number(), number(), number()) :: number()
  def simple_interest(principal, rate, time) do
    principal * rate * time
  end

  @doc """
  Calculates compound interest: A = P x (1 + r/n)^(n x t)

  ## Parameters
    - principal: The initial amount of money (P)
    - rate: The annual interest rate as a decimal (r)
    - periods: Number of times interest is compounded per year (n)
    - time: The time period in years (t)

  ## Examples
      iex> FinancialEquations.BasicFormulas.compound_interest(1000, 0.05, 1, 2)
      1102.5
  """
  @spec compound_interest(number(), number(), number(), number()) :: number()
  def compound_interest(principal, rate, periods, time) do
    principal * :math.pow(1 + rate / periods, periods * time)
  end

  @doc """
  Calculates the future value of a single sum: FV = PV x (1 + r)^t

  ## Parameters
    - present_value: The present value (PV)
    - rate: The interest rate per period as a decimal (r)
    - time: The time period in years (t)

  ## Examples
      iex> FinancialEquations.BasicFormulas.future_value_single_sum(1000, 0.05, 2)
      1102.5
  """
  @spec future_value_single_sum(number(), number(), number()) :: number()
  def future_value_single_sum(present_value, rate, time) do
    present_value * :math.pow(1 + rate, time)
  end

  @doc """
  Calculates the present value of a single sum: PV = FV / (1 + r)^t

  ## Parameters
    - future_value: The future value (FV)
    - rate: The interest rate per period as a decimal (r)
    - time: The time period in years (t)

  ## Examples
      iex> FinancialEquations.BasicFormulas.present_value_single_sum(1102.5, 0.05, 2)
      1000.0
  """
  @spec present_value_single_sum(number(), number(), number()) :: number()
  def present_value_single_sum(future_value, rate, time) do
    future_value / :math.pow(1 + rate, time)
  end

  @doc """
  Calculates the future value of an ordinary annuity: FV = P x ((1 + r)^t - 1) / r

  ## Parameters
    - payment: The periodic payment (P)
    - rate: The interest rate per period as a decimal (r)
    - time: The number of periods (t)

  ## Examples
      iex> FinancialEquations.BasicFormulas.future_value_annuity_ordinary(100, 0.05, 3)
      315.25
  """
  @spec future_value_annuity_ordinary(number(), number(), number()) :: number()
  def future_value_annuity_ordinary(payment, rate, time) do
    payment * (:math.pow(1 + rate, time) - 1) / rate
  end

  @doc """
  Calculates the present value of an ordinary annuity: PV = P x (1 - (1 + r)^(-t)) / r

  ## Parameters
    - payment: The periodic payment (P)
    - rate: The interest rate per period as a decimal (r)
    - time: The number of periods (t)

  ## Examples
      iex> FinancialEquations.BasicFormulas.present_value_annuity_ordinary(100, 0.05, 3)
      272.325
  """
  @spec present_value_annuity_ordinary(number(), number(), number()) :: number()
  def present_value_annuity_ordinary(payment, rate, time) do
    payment * (1 - :math.pow(1 + rate, -time)) / rate
  end

  @doc """
  Calculates the future value of an annuity due: FV_due = P x ((1 + r)^t - 1) / r x (1 + r)

  ## Parameters
    - payment: The periodic payment (P)
    - rate: The interest rate per period as a decimal (r)
    - time: The number of periods (t)

  ## Examples
      iex> FinancialEquations.BasicFormulas.future_value_annuity_due(100, 0.05, 3)
      331.0125
  """
  @spec future_value_annuity_due(number(), number(), number()) :: number()
  def future_value_annuity_due(payment, rate, time) do
    payment * (:math.pow(1 + rate, time) - 1) / rate * (1 + rate)
  end

  @doc """
  Calculates the present value of an annuity due: PV_due = P x (1 - (1 + r)^(-t)) / r x (1 + r)

  ## Parameters
    - payment: The periodic payment (P)
    - rate: The interest rate per period as a decimal (r)
    - time: The number of periods (t)

  ## Examples
      iex> FinancialEquations.BasicFormulas.present_value_annuity_due(100, 0.05, 3)
      285.94125
  """
  @spec present_value_annuity_due(number(), number(), number()) :: number()
  def present_value_annuity_due(payment, rate, time) do
    payment * (1 - :math.pow(1 + rate, -time)) / rate * (1 + rate)
  end

  @doc """
  Calculates the present value of a perpetuity: PV = P / r

  ## Parameters
    - payment: The periodic payment (P)
    - rate: The interest rate per period as a decimal (r)

  ## Examples
      iex> FinancialEquations.BasicFormulas.present_value_perpetuity(100, 0.05)
      2000.0
  """
  @spec present_value_perpetuity(number(), number()) :: number()
  def present_value_perpetuity(payment, rate) do
    payment / rate
  end

  @doc """
  Calculates the present value of a growing perpetuity: PV = P / (r - g)

  ## Parameters
    - payment: The initial periodic payment (P)
    - rate: The interest rate per period as a decimal (r)
    - growth_rate: The growth rate of the payment as a decimal (g)

  ## Examples
      iex> FinancialEquations.BasicFormulas.present_value_growing_perpetuity(100, 0.05, 0.02)
      3333.3333333333335
  """
  @spec present_value_growing_perpetuity(number(), number(), number()) :: number()
  def present_value_growing_perpetuity(payment, rate, growth_rate) do
    payment / (rate - growth_rate)
  end
end
