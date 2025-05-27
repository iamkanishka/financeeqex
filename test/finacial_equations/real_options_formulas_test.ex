defmodule FinancialEquations.RealOptionsFormulasTest do
  use ExUnit.Case
  doctest FinancialEquations.RealEstateFormulas

  describe "black_scholes/5" do
    test "calculates Black-Scholes value correctly with valid inputs" do
      assert {:ok, value} = RealOptions.black_scholes(100, 90, 1.0, 0.05, 0.2)
      assert_in_delta value, 14.7208, 0.0001
    end

    test "returns error for negative present value" do
      assert {:error, "Present value must be a positive number"} =
               RealOptions.black_scholes(-100, 90, 1.0, 0.05, 0.2)
    end

    test "returns error for negative time to expiry" do
      assert {:error, "Time to expiry must be positive"} =
               RealOptions.black_scholes(100, 90, -1.0, 0.05, 0.2)
    end

    test "returns error for negative volatility" do
      assert {:error, "Volatility must be a positive number"} =
               RealOptions.black_scholes(100, 90, 1.0, 0.05, -0.2)
    end
  end

  describe "binomial_model/6" do
    test "calculates Binomial Model value correctly with valid inputs" do
      assert {:ok, value} = RealOptions.binomial_model(100, 90, 1.0, 0.05, 0.2, 2)
      assert_in_delta value, 14.5248, 0.0001
    end

    test "returns error for negative investment cost" do
      assert {:error, "Investment cost must be a positive number"} =
               RealOptions.binomial_model(100, -90, 1.0, 0.05, 0.2, 2)
    end

    test "returns error for zero steps" do
      assert {:error, "Number of steps must be a positive integer"} =
               RealOptions.binomial_model(100, 90, 1.0, 0.05, 0.2, 0)
    end

    test "returns error for negative volatility" do
      assert {:error, "Volatility must be a positive number"} =
               RealOptions.binomial_model(100, 90, 1.0, 0.05, -0.2, 2)
    end
  end
end
