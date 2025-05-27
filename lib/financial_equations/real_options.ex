defmodule FinancialEquations.RealOptions do
  @moduledoc """
  A module to calculate real options valuations.

  This module provides functions to compute option values using the Black-Scholes model
  (adapted for non-financial investments) and the Binomial Option Pricing Model (discrete-time).
  """

  @doc """
  Calculates the option value using the Black-Scholes model, adapted for real options.

  This model is typically used for financial options but adapted here for non-financial investments,
  such as valuing the option to delay or expand a project.

  ## Parameters
    - present_value: Present value of future cash flows (float or integer)
    - investment_cost: Cost to exercise the option (float or integer)
    - time_to_expiry: Time to option expiry in years (float)
    - risk_free_rate: Risk-free interest rate (float, as a decimal e.g., 0.05 for 5%)
    - volatility: Volatility of the underlying asset (float, as a decimal e.g., 0.2 for 20%)

  ## Returns
    - {:ok, float} - The option value if inputs are valid
    - {:error, String.t()} - Error message if inputs are invalid

  ## Examples
      iex> RealOptions.black_scholes(100, 90, 1.0, 0.05, 0.2)
      {:ok, value} = RealOptions.black_scholes(100, 90, 1.0, 0.05, 0.2)
      assert_in_delta value, 14.7208, 0.0001

      iex> RealOptions.black_scholes(100, 90, -1.0, 0.05, 0.2)
      {:error, "Time to expiry must be positive"}
  """
  @spec black_scholes(number(), number(), number(), number(), number()) ::
          {:ok, float()} | {:error, String.t()}
  def black_scholes(present_value, investment_cost, time_to_expiry, risk_free_rate, volatility) do
    cond do
      !is_number(present_value) || present_value <= 0 ->
        {:error, "Present value must be a positive number"}

      !is_number(investment_cost) || investment_cost <= 0 ->
        {:error, "Investment cost must be a positive number"}

      !is_number(time_to_expiry) || time_to_expiry <= 0 ->
        {:error, "Time to expiry must be positive"}

      !is_number(risk_free_rate) ->
        {:error, "Risk-free rate must be a number"}

      !is_number(volatility) || volatility <= 0 ->
        {:error, "Volatility must be a positive number"}

      true ->
        # Calculate d1 and d2 for the Black-Scholes formula
        d1 =
          (Float.log(present_value / investment_cost) +
             (risk_free_rate + volatility * volatility / 2) * time_to_expiry) /
            (volatility * :math.sqrt(time_to_expiry))

        d2 = d1 - volatility * :math.sqrt(time_to_expiry)

        # Standard normal cumulative distribution function approximation for N(x)
        # Using the error function (erf) approximation
        norm_cdf = fn x ->
          0.5 * (1.0 + erf(x / :math.sqrt(2.0)))
        end

        # Black-Scholes formula for a call option
        option_value =
          present_value * norm_cdf.(d1) -
            investment_cost * :math.exp(-risk_free_rate * time_to_expiry) * norm_cdf.(d2)

        {:ok, option_value}
    end
  end

  # Helper function for error function (erf) approximation
  defp erf(x) do
    # Abramowitz and Stegun approximation for erf
    a1 = 0.254829592
    a2 = -0.284496736
    a3 = 1.421413741
    a4 = -1.453152027
    a5 = 1.061405429
    p = 0.3275911

    sign = if x >= 0, do: 1, else: -1
    x = abs(x)
    t = 1.0 / (1.0 + p * x)
    y = 1.0 - ((((a5 * t + a4) * t + a3) * t + a2) * t + a1) * t * :math.exp(-x * x)
    sign * y
  end

  @doc """
  Calculates the option value using the Binomial Option Pricing Model (discrete-time).

  This model uses a binomial lattice to approximate the option value over discrete time steps.

  ## Parameters
    - present_value: Present value of future cash flows (float or integer)
    - investment_cost: Cost to exercise the option (float or integer)
    - time_to_expiry: Time to option expiry in years (float)
    - risk_free_rate: Risk-free interest rate (float, as a decimal e.g., 0.05 for 5%)
    - volatility: Volatility of the underlying asset (float, as a decimal e.g., 0.2 for 20%)
    - steps: Number of time steps in the binomial lattice (integer)

  ## Returns
    - {:ok, float} - The option value if inputs are valid
    - {:error, String.t()} - Error message if inputs are invalid

  ## Examples
      iex> RealOptions.binomial_model(100, 90, 1.0, 0.05, 0.2, 2)
      {:ok, value} = RealOptions.binomial_model(100, 90, 1.0, 0.05, 0.2, 2)
      assert_in_delta value, 14.5248, 0.0001

      iex> RealOptions.binomial_model(100, 90, 1.0, 0.05, 0.2, 0)
      {:error, "Number of steps must be a positive integer"}
  """
  @spec binomial_model(number(), number(), number(), number(), number(), integer()) ::
          {:ok, float()} | {:error, String.t()}
  def binomial_model(
        present_value,
        investment_cost,
        time_to_expiry,
        risk_free_rate,
        volatility,
        steps
      ) do
    cond do
      !is_number(present_value) || present_value <= 0 ->
        {:error, "Present value must be a positive number"}

      !is_number(investment_cost) || investment_cost <= 0 ->
        {:error, "Investment cost must be a positive number"}

      !is_number(time_to_expiry) || time_to_expiry <= 0 ->
        {:error, "Time to expiry must be positive"}

      !is_number(risk_free_rate) ->
        {:error, "Risk-free rate must be a number"}

      !is_number(volatility) || volatility <= 0 ->
        {:error, "Volatility must be a positive number"}

      !is_integer(steps) || steps <= 0 ->
        {:error, "Number of steps must be a positive integer"}

      true ->
        # Binomial model parameters
        delta_t = time_to_expiry / steps
        # Up factor
        u = :math.exp(volatility * :math.sqrt(delta_t))
        # Down factor
        d = 1 / u
        # Risk-neutral probability
        p = (:math.exp(risk_free_rate * delta_t) - d) / (u - d)

        # Initialize the binomial tree at maturity (step N)
        tree =
          Enum.map(0..steps, fn i ->
            value = present_value * :math.pow(u, steps - i) * :math.pow(d, i)
            # Option payoff at maturity (call option)
            max(value - investment_cost, 0)
          end)

        # Backward induction through the tree
        final_value =
          Enum.reduce((steps - 1)..0, tree, fn step, values ->
            Enum.map(0..step, fn i ->
              discounted_value =
                :math.exp(-risk_free_rate * delta_t) *
                  (p * Enum.at(values, i) + (1 - p) * Enum.at(values, i + 1))

              current_value = present_value * :math.pow(u, step - i) * :math.pow(d, i)
              # American-style option
              max(discounted_value, max(current_value - investment_cost, 0))
            end)
          end)

        {:ok, Enum.at(final_value, 0)}
    end
  end
end
