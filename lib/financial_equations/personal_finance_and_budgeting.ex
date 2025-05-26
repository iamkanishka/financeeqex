defmodule FinancialEquations.PersonalFinanceFormulas do
  @moduledoc """
  A module for personal finance and budgeting calculations including rules for investment growth,
  savings, emergency funds, budgeting, and debt repayment strategies.
  All functions assume inputs are numerical and appropriate for the calculations (e.g., non-zero denominators).
  """

  @doc """
  Calculates the Rule of 72 (Time to Double Investment): Years = 72 / Interest Rate

  ## Parameters
    - interest_rate: The annual interest rate as a decimal (e.g., 5% as 0.05)

  ## Examples
      iex> FinancialEquations.PersonalFinanceFormulas.rule_of_72(0.08)
      9.0
  """
  def rule_of_72(interest_rate) do
    72 / (interest_rate * 100)
  end

  @doc """
  Calculates the Rule of 114 (Time to Triple Investment): Years = 114 / Interest Rate

  ## Parameters
    - interest_rate: The annual interest rate as a decimal (e.g., 5% as 0.05)

  ## Examples
      iex> FinancialEquations.PersonalFinanceFormulas.rule_of_114(0.06)
      19.0
  """
  def rule_of_114(interest_rate) do
    114 / (interest_rate * 100)
  end

  @doc """
  Calculates the Rule of 144 (Time to Quadruple Investment): Years = 144 / Interest Rate

  ## Parameters
    - interest_rate: The annual interest rate as a decimal (e.g., 5% as 0.05)

  ## Examples
      iex> FinancialEquations.PersonalFinanceFormulas.rule_of_144(0.04)
      36.0
  """
  def rule_of_144(interest_rate) do
    144 / (interest_rate * 100)
  end

  @doc """
  Calculates Retirement Corpus Needed (4% Rule): Retirement Corpus = Annual Expenses / 0.04

  ## Parameters
    - annual_expenses: Annual expenses during retirement

  ## Examples
      iex> FinancialEquations.PersonalFinanceFormulas.retirement_corpus_needed(40000)
      1000000.0
  """
  def retirement_corpus_needed(annual_expenses) do
    annual_expenses / 0.04
  end

  @doc """
  Calculates Emergency Fund: Emergency Fund = 3-6 x Monthly Expenses

  Returns a tuple with the minimum (3 months) and maximum (6 months) recommended emergency fund.

  ## Parameters
    - monthly_expenses: Monthly expenses

  ## Examples
      iex> FinancialEquations.PersonalFinanceFormulas.emergency_fund(5000)
      {15000, 30000}
  """
  def emergency_fund(monthly_expenses) do
    {3 * monthly_expenses, 6 * monthly_expenses}
  end

  @doc """
  Calculates Future Value of Savings: FV = P x (1 + (r/n))^(n x t)

  ## Parameters
    - principal: The initial savings amount (P)
    - rate: The annual interest rate as a decimal (r)
    - periods_per_year: Number of compounding periods per year (n)
    - years: The time period in years (t)

  ## Examples
      iex> FinancialEquations.PersonalFinanceFormulas.future_value_savings(1000, 0.05, 1, 2)
      1102.5
  """
  def future_value_savings(principal, rate, periods_per_year, years) do
    principal * :math.pow(1 + rate / periods_per_year, periods_per_year * years)
  end

  @doc """
  Calculates Budgeting according to the 50/30/20 Rule: 50% Needs, 30% Wants, 20% Savings/Debt

  Returns a tuple with the allocation for needs, wants, and savings/debt based on monthly income.

  ## Parameters
    - monthly_income: Monthly income

  ## Examples
      iex> FinancialEquations.PersonalFinanceFormulas.budget_50_30_20_rule(5000)
      {2500.0, 1500.0, 1000.0}
  """
  def budget_50_30_20_rule(monthly_income) do
    needs = monthly_income * 0.5
    wants = monthly_income * 0.3
    savings_debt = monthly_income * 0.2
    {needs, wants, savings_debt}
  end

  @doc """
  Calculates Credit Card Interest (Average Daily Balance Method): Interest = ADB x (APR / 365) x Days in Billing Cycle

  ## Parameters
    - average_daily_balance: Average daily balance on the credit card (ADB)
    - apr: Annual Percentage Rate as a decimal (e.g., 15% as 0.15)
    - days_in_billing_cycle: Number of days in the billing cycle (typically 30)

  ## Examples
      iex> FinancialEquations.PersonalFinanceFormulas.credit_card_interest(1000, 0.15, 30)
      12.328767123287671
  """
  def credit_card_interest(average_daily_balance, apr, days_in_billing_cycle) do
    average_daily_balance * (apr / 365) * days_in_billing_cycle
  end

  @doc """
  Describes the Debt Snowball method: Pay smallest debts first.

  ## Parameters
    - debts: A list of tuples representing debts as {name, amount, interest_rate}

  ## Examples
      iex> FinancialEquations.PersonalFinanceFormulas.debt_snowball([{"Debt A", 500, 0.05}, {"Debt B", 200, 0.1}, {"Debt C", 1000, 0.03}])
      ["Debt B", "Debt A", "Debt C"]
  """
  def debt_snowball(debts) do
    debts
    |> Enum.sort_by(fn {_, amount, _} -> amount end)
    |> Enum.map(fn {name, _, _} -> name end)
  end

  @doc """
  Describes the Debt Avalanche method: Pay highest-interest debts first.

  ## Parameters
    - debts: A list of tuples representing debts as {name, amount, interest_rate}

  ## Examples
      iex> FinancialEquations.PersonalFinanceFormulas.debt_avalanche([{"Debt A", 500, 0.05}, {"Debt B", 200, 0.1}, {"Debt C", 1000, 0.03}])
      ["Debt B", "Debt A", "Debt C"]
  """
  def debt_avalanche(debts) do
    debts
    |> Enum.sort_by(fn {_, _, interest_rate} -> -interest_rate end)
    |> Enum.map(fn {name, _, _} -> name end)
  end

  @doc """
  Calculates Net Worth: Net Worth = Total Assets - Total Liabilities

  ## Parameters
    - total_assets: Total value of assets
    - total_liabilities: Total value of liabilities

  ## Examples
      iex> FinancialEquations.PersonalFinanceFormulas.net_worth(50000, 20000)
      30000
  """
  def net_worth(total_assets, total_liabilities) do
    total_assets - total_liabilities
  end
end
