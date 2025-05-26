defmodule FinancialEquations.ForexInternationalFormulasTest do
  use ExUnit.Case
  doctest FinancialEquations.ForexInternationalFormulas

  test "currency exchange direct calculation" do
    assert ForexInternationalFormulas.currency_exchange_direct(1000, 0.013) == 13.0
  end

  test "cross currency rate calculation" do
    assert_in_delta ForexInternationalFormulas.cross_currency_rate(0.85, 1.25),
                    0.68,
                    0.001
  end

  test "purchasing power parity calculation" do
    assert_in_delta ForexInternationalFormulas.purchasing_power_parity(1.0, 0.02, 0.03),
                    0.9902912621359223,
                    0.000001
  end

  test "interest rate parity calculation" do
    assert_in_delta ForexInternationalFormulas.interest_rate_parity(1.0, 0.04, 0.05),
                    0.9904761904761905,
                    0.000001
  end
end
