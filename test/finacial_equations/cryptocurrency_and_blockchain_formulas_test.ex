defmodule FinancialEquations.CryptocurrencyAndBlockchainFormulasTest do
  use ExUnit.Case
  doctest FinancialEquations.CryptocurrencyAndBlockchainFormulas

  describe "calculate_nvt/2" do
    test "calculates NVT ratio correctly with valid inputs" do
      assert {:ok, 20.0} = CryptocurrencyAndBlockchainFormulas.calculate_nvt(1_000_000, 50_000)
    end

    test "returns error for zero daily transaction volume" do
      assert {:error, "Daily transaction volume must be greater than 0"} =
               CryptocurrencyAndBlockchainFormulas.calculate_nvt(1_000_000, 0)
    end

    test "returns error for negative market cap" do
      assert {:error, "Market cap must be a non-negative number"} =
               CryptocurrencyAndBlockchainFormulas.calculate_nvt(-1_000_000, 50_000)
    end
  end

  describe "calculate_s2f/2" do
    test "calculates S2F value correctly with valid inputs" do
      assert {:ok, ratio} = CryptocurrencyAndBlockchainFormulas.calculate_s2f(21_000_000, 328_500)
      assert_in_delta ratio, 63.9269, 0.0001
    end

    test "returns error for zero annual production" do
      assert {:error, "Annual production must be greater than 0"} =
               CryptocurrencyAndBlockchainFormulas.calculate_s2f(21_000_000, 0)
    end

    test "returns error for negative total supply" do
      assert {:error, "Total supply must be a non-negative number"} =
               CryptocurrencyAndBlockchainFormulas.calculate_s2f(-21_000_000, 328_500)
    end
  end

  describe "calculate_realized_cap/2" do
    test "calculates Realized Cap correctly with valid inputs" do
      assert {:ok, 210.0} =
               CryptocurrencyAndBlockchainFormulas.calculate_realized_cap([100, 200, 300], [
                 0.3,
                 0.3,
                 0.4
               ])
    end

    test "returns error for mismatched list lengths" do
      assert {:error, "Prices and weights lists must have the same length"} =
               CryptocurrencyAndBlockchainFormulas.calculate_realized_cap([100, 200], [0.5])
    end

    test "returns error for negative prices" do
      assert {:error, "All prices must be non-negative numbers"} =
               CryptocurrencyAndBlockchainFormulas.calculate_realized_cap([100, -200, 300], [
                 0.3,
                 0.3,
                 0.4
               ])
    end

    test "returns error for zero sum of weights" do
      assert {:error, "Sum of weights must be greater than 0"} =
               CryptocurrencyAndBlockchainFormulas.calculate_realized_cap([100, 200, 300], [
                 0.0,
                 0.0,
                 0.0
               ])
    end
  end
end
