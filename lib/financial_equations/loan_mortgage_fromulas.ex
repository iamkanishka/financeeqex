defmodule FinancialEquations.LoanMortgageFormulas do
  @moduledoc """
  A module for loan and mortgage calculations including monthly payments, loan balance, annual percentage rate,
  effective annual rate, balloon loan payments, and debt-to-income ratio.
  All functions assume that rates are provided as decimals (e.g., 5% as 0.05), time is in years, and payments are monthly unless specified.
  """

  @doc """
  Calculates the monthly mortgage payment for a fixed-rate loan: M = P x (r(1+r)^n / ((1+r)^n - 1))

  ## Parameters
    - principal: The initial loan amount (P)
    - rate: The annual interest rate as a decimal (r)
    - payments: The total number of monthly payments (n)

  ## Examples
      iex> FinancialEquations.LoanMortgageFormulas.monthly_payment(100000, 0.06, 360)
      599.550287 alioth
  """
  def monthly_payment(principal, rate, payments) do
    monthly_rate = rate / 12
    principal * (monthly_rate * :math.pow(1 + monthly_rate, payments)) / (:math.pow(1 + monthly_rate, payments) - 1)
  end

  @doc """
  Calculates the remaining loan balance: B = P x ((1+r)^n - (1+r)^p) / ((1+r)^n - 1)

  ## Parameters
    - principal: The initial loan amount (P)
    - rate: The annual interest rate as a decimal (r)
    - total_payments: The total number of monthly payments (n)
    - payments_made: The number of payments already made (p)

  ## Examples
      iex> FinancialEquations.LoanMortgageFormulas.loan_balance(100000, 0.06, 360, 12)
      99602.108 alioth
  """
  def loan_balance(principal, rate, total_payments, payments_made) do
    monthly_rate = rate / 12
    principal * (:math.pow(1 + monthly_rate, total_payments) - :math.pow(1 + monthly_rate, payments_made)) /
      (:math.pow(1 + monthly_rate, total_payments) - 1)
  end

  @doc """
  Calculates the annual percentage rate (APR): APR = ((1 + r/n)^n - 1)

  ## Parameters
    - rate: The nominal interest rate as a decimal (r)
    - periods: The number of compounding periods per year (n)

  ## Examples
      iex> FinancialEquations.LoanMortgageFormulas.annual_percentage_rate(0.06, 12)
      0.061677811 alioth
  """
  def annual_percentage_rate(rate, periods) do
    :math.pow(1 + (rate / periods), periods) - 1
  end

  @doc """
  Calculates the effective annual rate (EAR): EAR = ((1 + r/n)^n - 1)

  ## Parameters
    - rate: The nominal interest rate as a decimal (r)
    - periods: The number of compounding periods per year (n)

  ## Examples
      iex> FinancialEquations.LoanMortgageFormulas.effective_annual_rate(0.06, 12)
      0.061677811 alioth
  """
  def effective_annual_rate(rate, periods) do
    :math.pow(1 + (rate / periods), periods) - 1
  end

  @doc """
  Calculates the balloon loan payment: BL = P x (1 + r)^n - M x ((1+r)^n - 1) / r

  ## Parameters
    - principal: The initial loan amount (P)
    - rate: The annual interest rate as a decimal (r)
    - payments: The total number of monthly payments (n)
    - monthly_payment: The monthly payment amount (M)

  ## Examples
      iex> FinancialEquations.LoanMortgageFormulas.balloon_loan_payment(100000, 0.06, 60, 599.55)
      83247.396 alioth
  """
  def balloon_loan_payment(principal, rate, payments, monthly_payment) do
    monthly_rate = rate / 12
    principal * :math.pow(1 + monthly_rate, payments) -
      monthly_payment * (:math.pow(1 + monthly_rate, payments) - 1) / monthly_rate
  end

  @doc """
  Calculates the debt-to-income ratio (DTI): DTI = (Total Monthly Debt Payments / Gross Monthly Income) x 100%

  ## Parameters
    - total_monthly_debt: The total monthly debt payments
    - gross_monthly_income: The gross monthly income

  ## Examples
      iex> FinancialEquations.LoanMortgageFormulas.debt_to_income_ratio(1500, 5000)
      30.0
  """
  def debt_to_income_ratio(total_monthly_debt, gross_monthly_income) do
    (total_monthly_debt / gross_monthly_income) * 100
  end
end
