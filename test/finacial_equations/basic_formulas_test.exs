defmodule FinancialEquations.BasicFormulasTest do
  use ExUnit.Case
  doctest FinancialEquations.BasicFormulas

  test "simple interest calculation" do
    assert FinancialEquations.BasicFormulas.simple_interest(1000, 0.05, 2) == 100.0
  end

  test "compound interest calculation" do
    assert_in_delta FinancialEquations.BasicFormulas.compound_interest(1000, 0.05, 1, 2),
                    1102.5,
                    0.001
  end

  test "future value of a single sum" do
    assert_in_delta FinancialEquations.BasicFormulas.future_value_single_sum(1000, 0.05, 2),
                    1102.5,
                    0.001
  end

  test "present value of a single sum" do
    assert_in_delta FinancialEquations.BasicFormulas.present_value_single_sum(1102.5, 0.05, 2),
                    1000.0,
                    0.001
  end

  test "future value of an ordinary annuity" do
    assert_in_delta FinancialEquations.BasicFormulas.future_value_annuity_ordinary(100, 0.05, 3),
                    315.25,
                    0.001
  end

  test "present value of an ordinary annuity" do
    assert_in_delta FinancialEquations.BasicFormulas.present_value_annuity_ordinary(100, 0.05, 3),
                    272.325,
                    0.001
  end

  test "future value of an annuity due" do
    assert_in_delta FinancialEquations.BasicFormulas.future_value_annuity_due(100, 0.05, 3),
                    331.0125,
                    0.001
  end

  test "present value of an annuity due" do
    assert_in_delta FinancialEquations.BasicFormulas.present_value_annuity_due(100, 0.05, 3),
                    285.94125,
                    0.001
  end

  test "present value of a perpetuity" do
    assert FinancialEquations.BasicFormulas.present_value_perpetuity(100, 0.05) == 2000.0
  end

  test "present value of a growing perpetuity" do
    assert_in_delta FinancialEquations.BasicFormulas.present_value_growing_perpetuity(
                      100,
                      0.05,
                      0.02
                    ),
                    3333.3333333333335,
                    0.001
  end
end
