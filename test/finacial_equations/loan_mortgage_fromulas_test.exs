defmodule FinancialEquations.LoanMortgageFormulasTest do
  use ExUnit.Case
  doctest FinancialEquations.LoanMortgageFormulas

  test "monthly mortgage payment calculation" do
    assert_in_delta LoanMortgageFormulas.monthly_payment(100000, 0.06, 360),
                    599.55,
                    0.01
  end

  test "loan balance calculation" do
    assert_in_delta LoanMortgageFormulas.loan_balance(100000, 0.06, 360, 12),
                    99602.11,
                    0.01
  end

  test "annual percentage rate calculation" do
    assert_in_delta LoanMortgageFormulas.annual_percentage_rate(0.06, 12),
                    0.061677811,
                    0.00001
  end

  test "effective annual rate calculation" do
    assert_in_delta LoanMortgageFormulas.effective_annual_rate(0.06, 12),
                    0.061677811,
                    0.00001
  end

  test "balloon loan payment calculation" do
    assert_in_delta LoanMortgageFormulas.balloon_loan_payment(100000, 0.06, 60, 599.55),
                    83247.40,
                    0.01
  end

  test "debt-to-income ratio calculation" do
    assert FinancialEquations.LoanMortgageFormulas.debt_to_income_ratio(1500, 5000) == 30.0
  end
end
