defmodule FinancialEquations.TimeValueMoneyFormulasTest do
  use ExUnit.Case
  doctest FinancialEquations.TimeValueMoneyFormulas

  test "annuity payment ordinary calculation" do
    assert_in_delta FinancialEquations.TimeValueMoneyFormulas.annuity_payment_ordinary(1000, 0.05, 3),
                    367.208,
                    0.001
  end

  test "annuity payment due calculation" do
    assert_in_delta FinancialEquations.TimeValueMoneyFormulas.annuity_payment_due(1000, 0.05, 3),
                    349.722,
                    0.001
  end

  test "growing annuity present value calculation" do
    assert_in_delta FinancialEquations.TimeValueMoneyFormulas.growing_annuity_pv(100, 0.05, 0.02, 3),
                    286.698,
                    0.001
  end

  test "future value of growing annuity calculation" do
    assert_in_delta FinancialEquations.TimeValueMoneyFormulas.future_value_growing_annuity(100, 0.05, 0.02, 3),
                    315.901,
                    0.001
  end

  test "sinking fund calculation" do
    assert_in_delta FinancialEquations.TimeValueMoneyFormulas.sinking_fund(1000, 0.05, 3),
                    317.208,
                    0.001
  end
end
