defmodule FinancialEquations.BusinessAccountingFormulas do
  @moduledoc """
  A module for business and accounting calculations including profitability, efficiency, and liquidity ratios.
  All functions assume inputs are numerical and appropriate for the calculations (e.g., non-zero denominators).
  """

  @doc """
  Calculates Gross Profit: Gross Profit = Revenue - COGS

  ## Parameters
    - revenue: Total revenue
    - cogs: Cost of Goods Sold (COGS)

  ## Examples
      iex> FinancialEquations.BusinessAccountingFormulas.gross_profit(10000, 6000)
      4000
  """
  @spec gross_profit(number(), number()) :: number()
  def gross_profit(revenue, cogs) do
    revenue - cogs
  end

  @doc """
  Calculates Net Profit Margin: Net Profit Margin = (Net Profit / Revenue) x 100%

  ## Parameters
    - net_profit: Net profit after all expenses
    - revenue: Total revenue

  ## Examples
      iex> FinancialEquations.BusinessAccountingFormulas.net_profit_margin(2000, 10000)
      20.0
  """
  @spec net_profit_margin(number(), number()) :: number()
  def net_profit_margin(net_profit, revenue) do
    (net_profit / revenue) * 100
  end

  @doc """
  Calculates Gross Margin: Gross Margin = (Gross Profit / Revenue) x 100%

  ## Parameters
    - gross_profit: Gross profit
    - revenue: Total revenue

  ## Examples
      iex> FinancialEquations.BusinessAccountingFormulas.gross_margin(4000, 10000)
      40.0
  """
  @spec gross_margin(number(), number()) :: number()
  def gross_margin(gross_profit, revenue) do
    (gross_profit / revenue) * 100
  end

  @doc """
  Calculates Operating Margin: Operating Margin = (Operating Income / Revenue) x 100%

  ## Parameters
    - operating_income: Operating income (revenue minus operating expenses)
    - revenue: Total revenue

  ## Examples
      iex> FinancialEquations.BusinessAccountingFormulas.operating_margin(3000, 10000)
      30.0
  """
  @spec operating_margin(number(), number()) :: number()
  def operating_margin(operating_income, revenue) do
    (operating_income / revenue) * 100
  end

  @doc """
  Calculates EBITDA: EBITDA = Revenue - Expenses (excluding tax, interest, depreciation, amortization)

  ## Parameters
    - revenue: Total revenue
    - expenses: Operating expenses excluding tax, interest, depreciation, and amortization

  ## Examples
      iex> FinancialEquations.BusinessAccountingFormulas.ebitda(10000, 5000)
      5000
  """
  @spec ebitda(number(), number()) :: number()
  def ebitda(revenue, expenses) do
    revenue - expenses
  end

  @doc """
  Calculates Earnings Per Share (EPS): EPS = (Net Income - Preferred Dividends) / Average Outstanding Shares

  ## Parameters
    - net_income: Net income
    - preferred_dividends: Dividends paid to preferred shareholders
    - average_outstanding_shares: Average number of outstanding shares

  ## Examples
      iex> FinancialEquations.BusinessAccountingFormulas.earnings_per_share(2000, 200, 900)
      2.0
  """
  @spec earnings_per_share(number(), number(), number()) :: number()
  def earnings_per_share(net_income, preferred_dividends, average_outstanding_shares) do
    (net_income - preferred_dividends) / average_outstanding_shares
  end

  @doc """
  Calculates Price-to-Earnings Ratio (P/E): P/E = Market Price per Share / EPS

  ## Parameters
    - market_price_per_share: Current market price per share
    - eps: Earnings per share

  ## Examples
      iex> FinancialEquations.BusinessAccountingFormulas.price_to_earnings_ratio(20, 2)
      10.0
  """
  @spec price_to_earnings_ratio(number(), number()) :: number()
  def price_to_earnings_ratio(market_price_per_share, eps) do
    market_price_per_share / eps
  end

  @doc """
  Calculates Price-to-Book Ratio (P/B): P/B = Market Price per Share / Book Value per Share

  ## Parameters
    - market_price_per_share: Current market price per share
    - book_value_per_share: Book value per share

  ## Examples
      iex> FinancialEquations.BusinessAccountingFormulas.price_to_book_ratio(20, 10)
      2.0
  """
  @spec price_to_book_ratio(number(), number()) :: number()
  def price_to_book_ratio(market_price_per_share, book_value_per_share) do
    market_price_per_share / book_value_per_share
  end

  @doc """
  Calculates Return on Equity (ROE): ROE = (Net Income / Shareholders' Equity) x 100%

  ## Parameters
    - net_income: Net income
    - shareholders_equity: Shareholders' equity

  ## Examples
      iex> FinancialEquations.BusinessAccountingFormulas.return_on_equity(2000, 10000)
      20.0
  """
  @spec return_on_equity(number(), number()) :: number()
  def return_on_equity(net_income, shareholders_equity) do
    (net_income / shareholders_equity) * 100
  end

  @doc """
  Calculates Return on Assets (ROA): ROA = (Net Income / Total Assets) x 100%

  ## Parameters
    - net_income: Net income
    - total_assets: Total assets

  ## Examples
      iex> FinancialEquations.BusinessAccountingFormulas.return_on_assets(2000, 20000)
      10.0
  """
  @spec return_on_assets(number(), number()) :: number()
  def return_on_assets(net_income, total_assets) do
    (net_income / total_assets) * 100
  end

  @doc """
  Calculates Debt-to-Equity Ratio (D/E): D/E = Total Liabilities / Shareholders' Equity

  ## Parameters
    - total_liabilities: Total liabilities
    - shareholders_equity: Shareholders' equity

  ## Examples
      iex> FinancialEquations.BusinessAccountingFormulas.debt_to_equity_ratio(5000, 10000)
      0.5
  """
  @spec debt_to_equity_ratio(number(), number()) :: number()
  def debt_to_equity_ratio(total_liabilities, shareholders_equity) do
    total_liabilities / shareholders_equity
  end

  @doc """
  Calculates Current Ratio: Current Ratio = Current Assets / Current Liabilities

  ## Parameters
    - current_assets: Total current assets
    - current_liabilities: Total current liabilities

  ## Examples
      iex> FinancialEquations.BusinessAccountingFormulas.current_ratio(15000, 5000)
      3.0
  """
  @spec current_ratio(number(), number()) :: number()
  def current_ratio(current_assets, current_liabilities) do
    current_assets / current_liabilities
  end

  @doc """
  Calculates Quick Ratio (Acid Test Ratio): Quick Ratio = (Current Assets - Inventory) / Current Liabilities

  ## Parameters
    - current_assets: Total current assets
    - inventory: Inventory value
    - current_liabilities: Total current liabilities

  ## Examples
      iex> FinancialEquations.BusinessAccountingFormulas.quick_ratio(15000, 3000, 5000)
      2.4
  """
  @spec quick_ratio(number(), number(), number()) :: number()
  def quick_ratio(current_assets, inventory, current_liabilities) do
    (current_assets - inventory) / current_liabilities
  end

  @doc """
  Calculates Working Capital: Working Capital = Current Assets - Current Liabilities

  ## Parameters
    - current_assets: Total current assets
    - current_liabilities: Total current liabilities

  ## Examples
      iex> FinancialEquations.BusinessAccountingFormulas.working_capital(15000, 5000)
      10000
  """
  @spec working_capital(number(), number()) :: number()
  def working_capital(current_assets, current_liabilities) do
    current_assets - current_liabilities
  end

  @doc """
  Calculates Inventory Turnover: Inventory Turnover = COGS / Average Inventory

  ## Parameters
    - cogs: Cost of Goods Sold (COGS)
    - average_inventory: Average inventory value

  ## Examples
      iex> FinancialEquations.BusinessAccountingFormulas.inventory_turnover(6000, 2000)
      3.0
  """
  @spec inventory_turnover(number(), number()) :: number()
  def inventory_turnover(cogs, average_inventory) do
    cogs / average_inventory
  end

  @doc """
  Calculates Receivables Turnover: Receivables Turnover = Net Credit Sales / Average Accounts Receivable

  ## Parameters
    - net_credit_sales: Net credit sales
    - average_accounts_receivable: Average accounts receivable

  ## Examples
      iex> FinancialEquations.BusinessAccountingFormulas.receivables_turnover(10000, 2500)
      4.0
  """
  @spec receivables_turnover(number(), number()) :: number()
  def receivables_turnover(net_credit_sales, average_accounts_receivable) do
    net_credit_sales / average_accounts_receivable
  end

  @doc """
  Calculates Days Sales Outstanding (DSO): DSO = (Accounts Receivable / Annual Sales) x 365

  ## Parameters
    - accounts_receivable: Accounts receivable
    - annual_sales: Annual sales

  ## Examples
      iex> FinancialEquations.BusinessAccountingFormulas.days_sales_outstanding(2500, 10000)
      91.25
  """
  @spec days_sales_outstanding(number(), number()) :: number()
  def days_sales_outstanding(accounts_receivable, annual_sales) do
    (accounts_receivable / annual_sales) * 365
  end

  @doc """
  Calculates Days Payable Outstanding (DPO): DPO = (Accounts Payable / COGS) x 365

  ## Parameters
    - accounts_payable: Accounts payable
    - cogs: Cost of Goods Sold (COGS)

  ## Examples
      iex> FinancialEquations.BusinessAccountingFormulas.days_payable_outstanding(1500, 6000)
      91.25
  """
  @spec days_payable_outstanding(number(), number()) :: number()
  def days_payable_outstanding(accounts_payable, cogs) do
    (accounts_payable / cogs) * 365
  end
end
