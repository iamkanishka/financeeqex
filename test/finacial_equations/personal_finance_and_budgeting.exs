defmodule FinancialEquations.PersonalFinanceFormulasTest do
  use ExUnit.Case
  doctest FinancialEquations.PersonalFinanceFormulas

  test "rule of 72 calculation" do
    assert PersonalFinanceFormulas.rule_of_72(0.08) == 9.0
  end

  test "rule of 114 calculation" do
    assert PersonalFinanceFormulas.rule_of_114(0.06) == 19.0
  end

  test "rule of 144 calculation" do
    assert PersonalFinanceFormulas.rule_of_144(0.04) == 36.0
  end

  test "future value of savings calculation" do
    assert_in_delta PersonalFinanceFormulas.future_value_savings(1000, 0.05, 1, 2),
                    1102.5,
                    0.001
  end

  test "retirement corpus needed calculation" do
    assert PersonalFinanceFormulas.retirement_corpus_needed(40000) == 1000000.0
  end

  test "emergency fund calculation" do
    assert PersonalFinanceFormulas.emergency_fund(5000) == {15000, 30000}
  end

  test "budget 50/30/20 rule calculation" do
    assert PersonalFinanceFormulas.budget_50_30_20_rule(5000) == {2500.0, 1500.0, 1000.0}
  end

  test "credit card interest calculation" do
    assert_in_delta PersonalFinanceFormulas.credit_card_interest(1000, 0.15, 30),
                    12.328767123287671,
                    0.000001
  end

  test "debt snowball calculation" do
    debts = [{"Debt A", 500, 0.05}, {"Debt B", 200, 0.1}, {"Debt C", 1000, 0.03}]
    assert PersonalFinanceFormulas.debt_snowball(debts) == ["Debt B", "Debt A", "Debt C"]
  end

  test "debt avalanche calculation" do
    debts = [{"Debt A", 500, 0.05}, {"Debt B", 200, 0.1}, {"Debt C", 1000, 0.03}]
    assert PersonalFinanceFormulas.debt_avalanche(debts) == ["Debt B", "Debt A", "Debt C"]
  end

  test "net worth calculation" do
    assert PersonalFinanceFormulas.net_worth(50000, 20000) == 30000
  end
end
