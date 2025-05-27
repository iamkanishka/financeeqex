defmodule FinancialEquations.BehavioralEconomicsAndDecesionMakingTest do

  use ExUnit.Case
  doctest FinancialEquations.BehavioralEconomicsAndDecesionMaking

  describe "calculate_expected_utility/2" do
    test "calculates Expected Utility correctly with valid inputs" do
      assert {:ok, 75.0} = BehavioralEconomicsAndDecesionMaking.calculate_expected_utility([0.5, 0.5], [100, 50])
    end

    test "returns error for mismatched list lengths" do
      assert {:error, "Probabilities and utilities lists must have the same length"} =
               BehavioralEconomicsAndDecesionMaking.calculate_expected_utility([0.5, 0.5], [100])
    end

    test "returns error for invalid probabilities" do
      assert {:error, "All probabilities must be between 0 and 1"} =
               BehavioralEconomicsAndDecesionMaking.calculate_expected_utility([1.5, 0.5], [100, 50])
    end

    test "returns error for probabilities not summing to 1" do
      assert {:error, "Sum of probabilities must be approximately 1"} =
               BehavioralEconomicsAndDecesionMaking.calculate_expected_utility([0.3, 0.3], [100, 50])
    end
  end

  describe "prospect_value_function/3" do
    test "calculates Prospect Theory Value Function correctly with valid inputs" do
      assert {:ok, [value1, value2]} = BehavioralEconomicsAndDecesionMaking.prospect_value_function([100, -50], 0.88, 2.25)
      assert_in_delta value1, 81.966, 0.001 # 100^0.88
      assert_in_delta value2, -95.546, 0.001 # -2.25 * 50^0.88
    end

    test "returns error for invalid outcomes" do
      assert {:error, "All outcomes must be numbers"} =
               BehavioralEconomicsAndDecesionMaking.prospect_value_function([100, "50"], 0.88, 2.25)
    end

    test "returns error for invalid alpha" do
      assert {:error, "Alpha must be between 0 and 1"} =
               BehavioralEconomicsAndDecesionMaking.prospect_value_function([100, -50], 1.5, 2.25)
    end

    test "returns error for negative lambda" do
      assert {:error, "Lambda must be a positive number"} =
               BehavioralEconomicsAndDecesionMaking.prospect_value_function([100, -50], 0.88, -2.25)
    end
  end
end
