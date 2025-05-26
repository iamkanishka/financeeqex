defmodule FinancialEquations.RealEstateFormulasTest do
  use ExUnit.Case
  doctest FinancialEquations.RealEstateFormulas

  test "loan to value ratio calculation" do
    assert RealEstateFormulas.loan_to_value_ratio(80000, 100_000) == 80.0
  end

  test "cap rate calculation" do
    assert RealEstateFormulas.cap_rate(12000, 150_000) == 8.0
  end

  test "cash on cash return calculation" do
    assert RealEstateFormulas.cash_on_cash_return(5000, 50000) == 10.0
  end

  test "gross rent multiplier calculation" do
    assert_in_delta RealEstateFormulas.gross_rent_multiplier(150_000, 18000),
                    8.333333333333334,
                    0.000001
  end

  test "debt service coverage ratio calculation" do
    assert RealEstateFormulas.debt_service_coverage_ratio(12000, 8000) == 1.5
  end
end
