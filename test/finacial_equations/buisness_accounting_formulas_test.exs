defmodule FinancialEquations.BusinessAccountingFormulasTest do
  use ExUnit.Case
  doctest FinancialEquations.BusinessAccountingFormulas

  test "gross profit calculation" do
    assert FinancialEquations.BusinessAccountingFormulas.gross_profit(10000, 6000) == 4000
  end

  test "net profit margin calculation" do
    assert FinancialEquations.BusinessAccountingFormulas.net_profit_margin(2000, 10000) == 20.0
  end

  test "gross margin calculation" do
    assert FinancialEquations.BusinessAccountingFormulas.gross_margin(4000, 10000) == 40.0
  end

  test "operating margin calculation" do
    assert FinancialEquations.BusinessAccountingFormulas.operating_margin(3000, 10000) == 30.0
  end

  test "ebitda calculation" do
    assert FinancialEquations.BusinessAccountingFormulas.ebitda(10000, 5000) == 5000
  end

  test "earnings per share calculation" do
    assert FinancialEquations.BusinessAccountingFormulas.earnings_per_share(2000, 200, 900) == 2.0
  end

  test "price to earnings ratio calculation" do
    assert FinancialEquations.BusinessAccountingFormulas.price_to_earnings_ratio(20, 2) == 10.0
  end

  test "price to book ratio calculation" do
    assert FinancialEquations.BusinessAccountingFormulas.price_to_book_ratio(20, 10) == 2.0
  end

  test "return on equity calculation" do
    assert FinancialEquations.BusinessAccountingFormulas.return_on_equity(2000, 10000) == 20.0
  end

  test "return on assets calculation" do
    assert FinancialEquations.BusinessAccountingFormulas.return_on_assets(2000, 20000) == 10.0
  end

  test "debt to equity ratio calculation" do
    assert FinancialEquations.BusinessAccountingFormulas.debt_to_equity_ratio(5000, 10000) == 0.5
  end

  test "current ratio calculation" do
    assert FinancialEquations.BusinessAccountingFormulas.current_ratio(15000, 5000) == 3.0
  end

  test "quick ratio calculation" do
    assert FinancialEquations.BusinessAccountingFormulas.quick_ratio(15000, 3000, 5000) == 2.4
  end

  test "working capital calculation" do
    assert FinancialEquations.BusinessAccountingFormulas.working_capital(15000, 5000) == 10000
  end

  test "inventory turnover calculation" do
    assert FinancialEquations.BusinessAccountingFormulas.inventory_turnover(6000, 2000) == 3.0
  end

  test "receivables turnover calculation" do
    assert FinancialEquations.BusinessAccountingFormulas.receivables_turnover(10000, 2500) == 4.0
  end

  test "days sales outstanding calculation" do
    assert FinancialEquations.BusinessAccountingFormulas.days_sales_outstanding(2500, 10000) == 91.25
  end

  test "days payable outstanding calculation" do
    assert FinancialEquations.BusinessAccountingFormulas.days_payable_outstanding(1500, 6000) == 91.25
  end
end
