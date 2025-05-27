defmodule FinancialEquations.RealEstateFormulas do
  @moduledoc """
  A module for real estate and property calculations including loan-to-value ratio, cap rate,
  cash-on-cash return, gross rent multiplier, and debt service coverage ratio.
  All functions assume inputs are numerical and appropriate (e.g., non-zero denominators).
  """

  @doc """
  Calculates Loan-to-Value Ratio (LTV): LTV = (Loan Amount / Property Value) x 100%

  ## Parameters
    - loan_amount: The amount of the loan
    - property_value: The appraised value of the property

  ## Examples
      iex> FinancialEquations.RealEstateFormulas.loan_to_value_ratio(80000, 100000)
      80.0
  """
  @spec loan_to_value_ratio(number(), number()) :: number()
  def loan_to_value_ratio(loan_amount, property_value) do
    (loan_amount / property_value) * 100
  end

  @doc """
  Calculates Cap Rate (Capitalization Rate): Cap Rate = (Net Operating Income / Property Value) x 100%

  ## Parameters
    - net_operating_income: The annual net operating income (NOI)
    - property_value: The current value of the property

  ## Examples
      iex> FinancialEquations.RealEstateFormulas.cap_rate(12000, 150000)
      8.0
  """
  @spec cap_rate(number(), number()) :: number()
  def cap_rate(net_operating_income, property_value) do
    (net_operating_income / property_value) * 100
  end

  @doc """
  Calculates Cash-on-Cash Return: Cash-on-Cash = (Annual Pre-Tax Cash Flow / Total Cash Invested) x 100%

  ## Parameters
    - annual_pre_tax_cash_flow: The annual pre-tax cash flow
    - total_cash_invested: The total cash invested in the property

  ## Examples
      iex> FinancialEquations.RealEstateFormulas.cash_on_cash_return(5000, 50000)
      10.0
  """
  @spec cash_on_cash_return(number(), number()) :: number()
  def cash_on_cash_return(annual_pre_tax_cash_flow, total_cash_invested) do
    (annual_pre_tax_cash_flow / total_cash_invested) * 100
  end

  @doc """
  Calculates Gross Rent Multiplier (GRM): GRM = Property Price / Annual Gross Rental Income

  ## Parameters
    - property_price: The purchase price of the property
    - annual_gross_rental_income: The annual gross rental income

  ## Examples
      iex> FinancialEquations.RealEstateFormulas.gross_rent_multiplier(150000, 18000)
      8.333333333333334
  """
  @spec gross_rent_multiplier(number(), number()) :: number()
  def gross_rent_multiplier(property_price, annual_gross_rental_income) do
    property_price / annual_gross_rental_income
  end

  @doc """
  Calculates Debt Service Coverage Ratio (DSCR): DSCR = Net Operating Income / Annual Debt Service

  ## Parameters
    - net_operating_income: The annual net operating income (NOI)
    - annual_debt_service: The annual debt service (loan payments)

  ## Examples
      iex> FinancialEquations.RealEstateFormulas.debt_service_coverage_ratio(12000, 8000)
      1.5
  """
  @spec debt_service_coverage_ratio(number(), number()) :: number()
  def debt_service_coverage_ratio(net_operating_income, annual_debt_service) do
    net_operating_income / annual_debt_service
  end
end
