defmodule FinancialEquations.DerivativesAndHedgingTest do
  use ExUnit.Case
  doctest FinancialEquations.DerivativesAndHedging

  test "Futures Price calculation" do
    assert_in_delta DerivativesAndHedging.futures_price(100.0, 0.05, 0.02, 1.0), 102.9701, 0.0001
  end

  test "Hedge Ratio calculation" do
    assert_in_delta DerivativesAndHedging.hedge_ratio(0.9, 0.2, 0.15), 1.2, 0.0001
  end

  test "Swap Value calculation" do
    assert DerivativesAndHedging.swap_value(1000.0, 980.0) == 20.0
  end

  test "CDS Spread calculation" do
    assert_in_delta DerivativesAndHedging.cds_spread(50000.0, 10000000.0), 50.0, 0.0001
  end
end
