defmodule FinancialEquations.FixedIncomeAndBondAnalyticsTest do
  use ExUnit.Case
  doctest FinancialEquations.FixedIncomeAndBondAnalytics

  test "Yield to Call (YTC) calculation" do
    assert_in_delta FixedIncomeAndBondAnalytics.ytc(950.0, 1000.0, 50.0, 5.0), 0.0641, 0.0001
  end

  test "Yield to Worst (YTW) calculation" do
    assert FixedIncomeAndBondAnalytics.ytw(0.06, 0.05, 0.07) == 0.05
  end

  test "Bond Equivalent Yield (BEY) calculation" do
    assert_in_delta FixedIncomeAndBondAnalytics.bey(0.03), 0.0618, 0.0001
  end

  test "Taxable Equivalent Yield (TEY) calculation" do
    assert_in_delta FixedIncomeAndBondAnalytics.tey(0.04, 0.3), 0.0571, 0.0001
  end

  test "Zero-Coupon Bond Price calculation" do
    assert_in_delta FixedIncomeAndBondAnalytics.zero_coupon_bond_price(1000.0, 0.05, 2.0), 905.9507, 0.0001
  end

  test "Spot Rate calculation" do
    assert_in_delta FixedIncomeAndBondAnalytics.spot_rate(905.9507, 1000.0, 2.0), 0.05, 0.0001
  end

  test "Forward Rate calculation" do
    assert_in_delta FixedIncomeAndBondAnalytics.forward_rate(0.05, 0.04, 2.0, 1.0), 0.0601, 0.0001
  end
end
