defmodule FinancialEquations.InvestmentReturnFormulasTest do
  use ExUnit.Case
  doctest FinancialEquations.InvestmentReturnFormulas

  test "return on investment calculation" do
    assert InvestmentReturnFormulas.return_on_investment(2000, 10000) == 20.0
  end

  test "net present value calculation" do
    assert_in_delta InvestmentReturnFormulas.net_present_value(
                      [1000, 1000, 1000],
                      0.1,
                      2500
                    ),
                    248.685,
                    0.001
  end

  test "payback period calculation" do
    assert InvestmentReturnFormulas.payback_period(10000, 2500) == 4.0
  end

  test "discounted payback period calculation" do
    assert InvestmentReturnFormulas.discounted_payback_period(
             [1000, 1000, 1000, 1000],
             0.1,
             3000
           ) == 4
  end

  test "profitability index calculation" do
    assert_in_delta InvestmentReturnFormulas.profitability_index(
                      [1000, 1000, 1000],
                      0.1,
                      2500
                    ),
                    0.999474,
                    0.000001
  end

  test "capital asset pricing model calculation" do
    assert_in_delta InvestmentReturnFormulas.capital_asset_pricing_model(
                      0.03,
                      1.2,
                      0.1
                    ),
                    0.114,
                    0.001
  end

  test "dividend discount model calculation" do
    assert InvestmentReturnFormulas.dividend_discount_model(2, 0.1, 0.05) ==
             40.0
  end

  test "present value of a bond calculation" do
    assert_in_delta InvestmentReturnFormulas.present_value_bond(
                      50,
                      0.05,
                      3,
                      1000
                    ),
                    1000.0,
                    0.001
  end

  test "current yield calculation" do
    assert InvestmentReturnFormulas.current_yield(50, 1000) == 0.05
  end

  test "yield to maturity calculation" do
    assert_in_delta InvestmentReturnFormulas.yield_to_maturity(
                      50,
                      1000,
                      950,
                      3
                    ),
                    0.0625,
                    0.001
  end

  test "modified duration calculation" do
    assert_in_delta InvestmentReturnFormulas.modified_duration(3, 0.05, 1),
                    2.857142857142857,
                    0.000001
  end

  test "convexity calculation" do
    assert_in_delta InvestmentReturnFormulas.convexity(
                      [50, 50, 1050],
                      0.05,
                      1000
                    ),
                    8.843537414965986,
                    0.000001
  end
end
