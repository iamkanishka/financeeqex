defmodule FinancialEquations.InsuranceAndRistManagmentFormulas do
  @moduledoc """
  A module to calculate insurance and risk management metrics.

  This module provides functions to compute Actuarial Present Value (APV),
  Loss Ratio, and Combined Ratio for insurance risk assessment.
  """

  @doc """
  Calculates the Actuarial Present Value (APV).

  APV is the sum of benefits multiplied by their discount factors and survival probabilities.

  ## Parameters
    - benefits: List of benefit amounts (list of floats or integers)
    - discount_factors: List of discount factors (list of floats)
    - survival_probabilities: List of survival probabilities (list of floats)

  ## Returns
    - {:ok, float} - The APV if inputs are valid
    - {:error, String.t()} - Error message if inputs are invalid

  ## Examples
      iex> InsuranceMetrics.calculate_apv([1000, 2000], [0.95, 0.90], [0.98, 0.95])
      {:ok, 3515.0}

      iex> InsuranceMetrics.calculate_apv([1000], [0.95], [0.98, 0.95])
      {:error, "All lists must have the same length"}
  """
  @spec calculate_apv(list(number()), list(number()), list(number())) ::
          {:ok, float()} | {:error, String.t()}
  def calculate_apv(benefits, discount_factors, survival_probabilities) do
    cond do
      !is_list(benefits) || !is_list(discount_factors) || !is_list(survival_probabilities) ->
        {:error, "All inputs must be lists"}

      length(benefits) != length(discount_factors) ||
          length(benefits) != length(survival_probabilities) ->
        {:error, "All lists must have the same length"}

      Enum.any?(benefits, fn b -> !is_number(b) || b < 0 end) ->
        {:error, "All benefits must be non-negative numbers"}

      Enum.any?(discount_factors, fn d -> !is_number(d) || d < 0 end) ->
        {:error, "All discount factors must be non-negative numbers"}

      Enum.any?(survival_probabilities, fn s -> !is_number(s) || s < 0 || s > 1 end) ->
        {:error, "All survival probabilities must be between 0 and 1"}

      true ->
        apv =
          Enum.zip([benefits, discount_factors, survival_probabilities])
          |> Enum.map(fn {b, d, s} -> b * d * s end)
          |> Enum.sum()

        {:ok, apv}
    end
  end

  @doc """
  Calculates the Loss Ratio.

  The Loss Ratio is the ratio of claims paid to earned premiums.

  ## Parameters
    - claims_paid: Total claims paid (float or integer)
    - earned_premiums: Total earned premiums (float or integer)

  ## Returns
    - {:ok, float} - The Loss Ratio if inputs are valid
    - {:error, String.t()} - Error message if inputs are invalid

  ## Examples
      iex> InsuranceMetrics.calculate_loss_ratio(800_000, 1_000_000)
      {:ok, 0.8}

      iex> InsuranceMetrics.calculate_loss_ratio(800_000, 0)
      {:error, "Earned premiums must be greater than 0"}
  """
  @spec calculate_loss_ratio(number(), number()) :: {:ok, float()} | {:error, String.t()}
  def calculate_loss_ratio(claims_paid, earned_premiums) do
    cond do
      !is_number(claims_paid) || claims_paid < 0 ->
        {:error, "Claims paid must be a non-negative number"}

      !is_number(earned_premiums) || earned_premiums <= 0 ->
        {:error, "Earned premiums must be greater than 0"}

      true ->
        {:ok, claims_paid / earned_premiums}
    end
  end

  @doc """
  Calculates the Combined Ratio.

  The Combined Ratio is the sum of the Loss Ratio and Expense Ratio.

  ## Parameters
    - loss_ratio: The loss ratio (float)
    - expense_ratio: The expense ratio (float)

  ## Returns
    - {:ok, float} - The Combined Ratio if inputs are valid
    - {:error, String.t()} - Error message if inputs are invalid

  ## Examples
      iex> InsuranceMetrics.calculate_combined_ratio(0.8, 0.3)
      {:ok, 1.1}

      iex> InsuranceMetrics.calculate_combined_ratio(-0.8, 0.3)
      {:error, "Loss ratio must be a non-negative number"}
  """
  @spec calculate_combined_ratio(number(), number()) :: {:ok, float()} | {:error, String.t()}
  def calculate_combined_ratio(loss_ratio, expense_ratio) do
    cond do
      !is_number(loss_ratio) || loss_ratio < 0 ->
        {:error, "Loss ratio must be a non-negative number"}

      !is_number(expense_ratio) || expense_ratio < 0 ->
        {:error, "Expense ratio must be a non-negative number"}

      true ->
        {:ok, loss_ratio + expense_ratio}
    end
  end
end
