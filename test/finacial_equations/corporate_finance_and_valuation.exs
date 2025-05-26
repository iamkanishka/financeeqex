defmodule FinancialEquations.CorporateFinanceAndValuationTest do
  use ExUnit.Case
  doctest FinancialEquations.CorporateFinanceAndValuation

  test "WACC calculation" do
    assert_in_delta CorporateFinanceAndValuation.wacc(100.0, 50.0, 150.0, 0.1, 0.05, 0.3), 0.083333, 0.001
  end

  test "FCF calculation" do
    assert CorporateFinanceAndValuation.fcf(100.0, 30.0) == 70.0
  end

  test "EV calculation" do
    assert CorporateFinanceAndValuation.ev(200.0, 50.0, 20.0) == 230.0
  end

  test "Equity Value calculation" do
    assert CorporateFinanceAndValuation.equity_value(230.0, 50.0, 20.0) == 200.0
  end

  test "DCF Valuation calculation" do
    assert_in_delta CorporateFinanceAndValuation.dcf_valuation([100.0, 110.0], 0.1, 1000.0), 918.182, 0.001
  end

  test "Levered Beta calculation" do
    assert_in_delta CorporateFinanceAndValuation.levered_beta(1.0, 0.3, 50.0, 100.0), 1.35, 0.001
  end

  test "Unlevered Beta calculation" do
    assert_in_delta CorporateFinanceAndValuation.unlevered_beta(1.35, 0.3, 50.0, 100.0), 1.0, 0.001
  end

  test "EVA calculation" do
    assert CorporateFinanceAndValuation.eva(100.0, 0.1, 800.0) == 20.0
  end

  test "Dividend Payout Ratio calculation" do
    assert CorporateFinanceAndValuation.dividend_payout_ratio(40.0, 100.0) == 0.4
  end

  test "Retention Ratio calculation" do
    assert CorporateFinanceAndValuation.retention_ratio(0.4) == 0.6
  end
end
