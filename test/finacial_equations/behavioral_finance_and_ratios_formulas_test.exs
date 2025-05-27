defmodule FinancialEquations.BehavioralFinanceAndRatiosFormulasTest do
  use ExUnit.Case
  doctest FinancialEquations.BehavioralFinanceAndRatiosFormulas

  test "calculate_hhi with valid market shares" do
    assert BehavioralFinanceAndRatiosFormulas.calculate_hhi([40, 30, 20, 10]) == 3000.0
    assert BehavioralFinanceAndRatiosFormulas.calculate_hhi([50, 50]) == 5000.0
  end

  test "calculate_gini with perfect equality" do
    assert BehavioralFinanceAndRatiosFormulas.calculate_gini([1, 1, 1, 1]) == 0.0
  end

  test "calculate_gini with maximum inequality" do
    assert BehavioralFinanceAndRatiosFormulas.calculate_gini([1, 0, 0, 0]) == 0.75
  end

  test "calculate_peg with valid inputs" do
    assert BehavioralFinanceAndRatiosFormulas.calculate_peg(20.0, 15.0) == 1.3333333333333333
  end

  test "calculate_peg with zero growth rate" do
    assert BehavioralFinanceAndRatiosFormulas.calculate_peg(20.0, 0.0) == :error
  end

  test "calculate_ev_ebitda with valid inputs" do
    assert BehavioralFinanceAndRatiosFormulas.calculate_ev_ebitda(1000.0, 200.0) == 5.0
  end

  test "calculate_ev_ebitda with zero ebitda" do
    assert BehavioralFinanceAndRatiosFormulas.calculate_ev_ebitda(1000.0, 0.0) == :error
  end

  test "calculate_sharpe_ratio with valid inputs" do
    assert BehavioralFinanceAndRatiosFormulas.calculate_sharpe_ratio(10.0, 2.0, 15.0) ==
             0.5333333333333333
  end

  test "calculate_sharpe_ratio with zero standard deviation" do
    assert BehavioralFinanceAndRatiosFormulas.calculate_sharpe_ratio(10.0, 2.0, 0.0) == :error
  end
end
