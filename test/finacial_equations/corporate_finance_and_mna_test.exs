defmodule FinancialEquations.CorporateFinanceAndMnaTest do
  use ExUnit.Case
  doctest FinancialEquations.CorporateFinanceAndMna

  test "LBO IRR calculation" do
    assert_in_delta CorporateFinanceMNA.lbo_irr(2000.0, 1000.0, 2.0), 0.4142, 0.0001
  end

  test "Synergy Value calculation" do
    assert CorporateFinanceMNA.synergy_value(1500.0, 800.0, 600.0) == 100.0
  end

  test "Goodwill calculation" do
    assert CorporateFinanceMNA.goodwill(1200.0, 1000.0) == 200.0
  end

  test "EOQ calculation" do
    assert_in_delta CorporateFinanceMNA.eoq(1000.0, 50.0, 2.0), 500.0, 0.0001
  end

  test "Altman Z-Score calculation" do
    assert_in_delta CorporateFinanceMNA.altman_z_score(0.2, 0.3, 0.1, 1.5, 1.0), 3.55, 0.0001
  end
end
