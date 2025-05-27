defmodule FinancialEquations.BehavioralEconomicsAndDecesionMaking do
  @moduledoc """
  A module for behavioral economics and decision-making calculations.

  This module provides functions to compute Expected Utility (EU) based on Expected Utility Theory
  and a Value Function based on Prospect Theory, which accounts for non-linear utility on gains and losses.
  """

  @doc """
  Calculates the Expected Utility (EU) based on Expected Utility Theory.

  EU is the sum of probabilities multiplied by the utility of each outcome.

  ## Parameters
    - probabilities: List of probabilities for each outcome (list of floats)
    - utilities: List of utility values for each outcome (list of floats or integers)

  ## Returns
    - {:ok, float} - The Expected Utility if inputs are valid
    - {:error, String.t()} - Error message if inputs are invalid

  ## Examples
      iex> BehavioralEconomics.calculate_expected_utility([0.5, 0.5], [100, 50])
      {:ok, 75.0}

      iex> BehavioralEconomics.calculate_expected_utility([0.5, 0.5], [100])
      {:error, "Probabilities and utilities lists must have the same length"}
  """
  @spec calculate_expected_utility(list(number()), list(number())) :: {:ok, float()} | {:error, String.t()}
  def calculate_expected_utility(probabilities, utilities) do
    cond do
      !is_list(probabilities) || !is_list(utilities) ->
        {:error, "Probabilities and utilities must be lists"}
      length(probabilities) != length(utilities) ->
        {:error, "Probabilities and utilities lists must have the same length"}
      Enum.any?(probabilities, fn p -> !is_number(p) || p < 0 || p > 1 end) ->
        {:error, "All probabilities must be between 0 and 1"}
      Enum.sum(probabilities) < 0.99 || Enum.sum(probabilities) > 1.01 ->
        {:error, "Sum of probabilities must be approximately 1"}
      Enum.any?(utilities, fn u -> !is_number(u) end) ->
        {:error, "All utilities must be numbers"}
      true ->
        eu = Enum.zip(probabilities, utilities)
             |> Enum.map(fn {p, u} -> p * u end)
             |> Enum.sum()
        {:ok, eu}
    end
  end

  @doc """
  Calculates the value of outcomes using Prospect Theory's Value Function.

  This implementation uses a simplified value function with non-linear utility for gains and losses,
  based on Kahneman and Tversky's Prospect Theory. It applies different weights for gains and losses,
  with a higher sensitivity to losses (loss aversion).

  ## Parameters
    - outcomes: List of outcome values (list of floats or integers, can be positive or negative)
    - alpha: Parameter for the power function (float, typically between 0 and 1, e.g., 0.88)
    - lambda: Loss aversion coefficient (float, typically > 1, e.g., 2.25)

  ## Returns
    - {:ok, list(float)} - List of transformed values for each outcome if inputs are valid
    - {:error, String.t()} - Error message if inputs are invalid

  ## Examples
      iex> BehavioralEconomics.prospect_value_function([100, -50], 0.88, 2.25)
      {:ok, [value1, value2]} = BehavioralEconomics.prospect_value_function([100, -50], 0.88, 2.25)
      assert_in_delta value1, 81.966, 0.001
      assert_in_delta value2, -95.546, 0.001

      iex> BehavioralEconomics.prospect_value_function([100, -50], 0.0, 2.25)
      {:error, "Alpha must be between 0 and 1"}
  """
  @spec prospect_value_function(list(number()), number(), number()) :: {:ok, list(float())} | {:error, String.t()}
  def prospect_value_function(outcomes, alpha, lambda) do
    cond do
      !is_list(outcomes) ->
        {:error, "Outcomes must be a list"}
      Enum.any?(outcomes, fn x -> !is_number(x) end) ->
        {:error, "All outcomes must be numbers"}
      !is_number(alpha) || alpha <= 0 || alpha > 1 ->
        {:error, "Alpha must be between 0 and 1"}
      !is_number(lambda) || lambda <= 0 ->
        {:error, "Lambda must be a positive number"}
      true ->
        # Simplified value function: v(x) = x^alpha for gains, -lambda * |x|^alpha for losses
        values = Enum.map(outcomes, fn x ->
          if x >= 0 do
            :math.pow(x, alpha)
          else
            -lambda * :math.pow(abs(x), alpha)
          end
        end)
        {:ok, values}
    end
  end
end
