defmodule FinancialEquations.CryptocurrencyAndBlockchainFormulas do

  @moduledoc """
  A module to calculate various cryptocurrency and blockchain metrics.

  This module provides functions to compute the Network Value-to-Transaction (NVT) Ratio,
  Stock-to-Flow (S2F) Model, and Realized Cap for cryptocurrency valuation.
  """

  @doc """
  Calculates the Network Value-to-Transaction (NVT) Ratio.

  The NVT Ratio is a metric that compares the market cap of a cryptocurrency to its daily transaction volume.

  ## Parameters
    - market_cap: The market capitalization of the cryptocurrency (float or integer)
    - daily_transaction_volume: The daily transaction volume of the cryptocurrency (float or integer)

  ## Returns
    - {:ok, float} - The NVT Ratio if inputs are valid
    - {:error, String.t()} - Error message if inputs are invalid

  ## Examples
      iex> CryptoMetrics.calculate_nvt(1_000_000, 50_000)
      {:ok, 20.0}

      iex> CryptoMetrics.calculate_nvt(1_000_000, 0)
      {:error, "Daily transaction volume must be greater than 0"}
  """
  @spec calculate_nvt(number(), number()) :: {:ok, float()} | {:error, String.t()}
  def calculate_nvt(market_cap, daily_transaction_volume) do
    cond do
      !is_number(market_cap) || market_cap < 0 ->
        {:error, "Market cap must be a non-negative number"}
      !is_number(daily_transaction_volume) || daily_transaction_volume <= 0 ->
        {:error, "Daily transaction volume must be greater than 0"}
      true ->
        {:ok, market_cap / daily_transaction_volume}
    end
  end

  @doc """
  Calculates the Stock-to-Flow (S2F) Model value.

  The S2F Model is a metric that compares the total supply of a cryptocurrency to its annual production.

  ## Parameters
    - total_supply: The total supply of the cryptocurrency (float or integer)
    - annual_production: The annual production of new coins (float or integer)

  ## Returns
    - {:ok, float} - The S2F value if inputs are valid
    - {:error, String.t()} - Error message if inputs are invalid

  ## Examples
      iex> CryptoMetrics.calculate_s2f(21_000_000, 328_500)
      {:ok, 63.9269406392694}

      iex> CryptoMetrics.calculate_s2f(21_000_000, 0)
      {:error, "Annual production must be greater than 0"}
  """
  @spec calculate_s2f(number(), number()) :: {:ok, float()} | {:error, String.t()}
  def calculate_s2f(total_supply, annual_production) do
    cond do
      !is_number(total_supply) || total_supply < 0 ->
        {:error, "Total supply must be a non-negative number"}
      !is_number(annual_production) || annual_production <= 0 ->
        {:error, "Annual production must be greater than 0"}
      true ->
        {:ok, total_supply / annual_production}
    end
  end

  @doc """
  Calculates the Realized Cap (Cryptocurrency Valuation).

  The Realized Cap is the weighted average price based on the last moved coins.
  This implementation simplifies by taking a list of prices and weights.

  ## Parameters
    - prices: List of prices of last moved coins (list of floats or integers)
    - weights: List of weights corresponding to each price (list of floats or integers)

  ## Returns
    - {:ok, float} - The Realized Cap if inputs are valid
    - {:error, String.t()} - Error message if inputs are invalid

  ## Examples
      iex> CryptoMetrics.calculate_realized_cap([100, 200, 300], [0.3, 0.3, 0.4])
      {:ok, 210.0}

      iex> CryptoMetrics.calculate_realized_cap([100, 200], [0.5])
      {:error, "Prices and weights lists must have the same length"}
  """
  @spec calculate_realized_cap(list(number()), list(number())) :: {:ok, float()} | {:error, String.t()}
  def calculate_realized_cap(prices, weights) do
    cond do
      !is_list(prices) || !is_list(weights) ->
        {:error, "Prices and weights must be lists"}
      length(prices) != length(weights) ->
        {:error, "Prices and weights lists must have the same length"}
      Enum.any?(prices, fn p -> !is_number(p) || p < 0 end) ->
        {:error, "All prices must be non-negative numbers"}
      Enum.any?(weights, fn w -> !is_number(w) || w < 0 end) ->
        {:error, "All weights must be non-negative numbers"}
      Enum.sum(weights) == 0 ->
        {:error, "Sum of weights must be greater than 0"}
      true ->
        weighted_sum = Enum.zip(prices, weights)
                       |> Enum.map(fn {p, w} -> p * w end)
                       |> Enum.sum()
        {:ok, weighted_sum}
    end
  end
end
