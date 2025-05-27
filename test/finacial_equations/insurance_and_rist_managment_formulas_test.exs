defmodule FinancialEquations.InsuranceAndRistManagmentFormulasTest do
  use ExUnit.Case
  doctest FinancialEquations.InsuranceAndRistManagmentFormulas

  describe "calculate_apv/3" do
    test "calculates APV correctly with valid inputs" do
      assert {:ok, 3515.0} =
               InsuranceAndRistManagmentFormulas.calculate_apv([1000, 2000], [0.95, 0.90], [0.98, 0.95])
    end

    test "returns error for mismatched list lengths" do
      assert {:error, "All lists must have the same length"} =
               InsuranceAndRistManagmentFormulas.calculate_apv([1000], [0.95], [0.98, 0.95])
    end

    test "returns error for negative benefits" do
      assert {:error, "All benefits must be non-negative numbers"} =
               InsuranceAndRistManagmentFormulas.calculate_apv([1000, -2000], [0.95, 0.90], [0.98, 0.95])
    end

    test "returns error for survival probabilities outside [0,1]" do
      assert {:error, "All survival probabilities must be between 0 and 1"} =
               InsuranceAndRistManagmentFormulas.calculate_apv([1000, 2000], [0.95, 0.90], [0.98, 1.5])
    end
  end

  describe "calculate_loss_ratio/2" do
    test "calculates Loss Ratio correctly with valid inputs" do
      assert {:ok, 0.8} = InsuranceAndRistManagmentFormulas.calculate_loss_ratio(800_000, 1_000_000)
    end

    test "returns error for zero earned premiums" do
      assert {:error, "Earned premiums must be greater than 0"} =
               InsuranceAndRistManagmentFormulas.calculate_loss_ratio(800_000, 0)
    end

    test "returns error for negative claims paid" do
      assert {:error, "Claims paid must be a non-negative number"} =
               InsuranceAndRistManagmentFormulas.calculate_loss_ratio(-800_000, 1_000_000)
    end
  end

  describe "calculate_combined_ratio/2" do
    test "calculates Combined Ratio correctly with valid inputs" do
      assert {:ok, 1.1} = InsuranceAndRistManagmentFormulas.calculate_combined_ratio(0.8, 0.3)
    end

    test "returns error for negative loss ratio" do
      assert {:error, "Loss ratio must be a non-negative number"} =
               InsuranceAndRistManagmentFormulas.calculate_combined_ratio(-0.8, 0.3)
    end

    test "returns error for negative expense ratio" do
      assert {:error, "Expense ratio must be a non-negative number"} =
               InsuranceAndRistManagmentFormulas.calculate_combined_ratio(0.8, -0.3)
    end
  end
end
