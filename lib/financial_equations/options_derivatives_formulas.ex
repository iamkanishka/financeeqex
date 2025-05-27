defmodule FinancialEquations.OptionsDerivativesFormulas do
  @moduledoc """
  A module for options and derivatives calculations including Black-Scholes option pricing,
  put-call parity, Greeks (Delta, Gamma, Theta, Vega), and implied volatility.
  All functions assume inputs are numerical and appropriate (e.g., non-zero denominators, positive volatility).
  """

  @doc """
  Calculates the Black-Scholes Call Option Price: C = S_0 * N(d1) - X * e^(-r * t) * N(d2)

  ## Parameters
    - spot_price: Current price of the underlying asset (S_0)
    - strike_price: Strike price of the option (X)
    - time_to_maturity: Time to expiration in years (t)
    - risk_free_rate: Risk-free interest rate (as a decimal, e.g., 5% as 0.05)
    - volatility: Volatility of the underlying asset (as a decimal, e.g., 20% as 0.2)

  ## Examples
      iex> FinancialEquations.OptionsDerivativesFormulas.black_scholes_call(100, 100, 1, 0.05, 0.2)
      10.450583
  """
  @spec black_scholes_call(float(), float(), float(), float(), float()) :: float()
  def black_scholes_call(spot_price, strike_price, time_to_maturity, risk_free_rate, volatility) do
    {d1, d2} = calculate_d1_d2(spot_price, strike_price, time_to_maturity, risk_free_rate, volatility)
    spot_price * normal_cdf(d1) - strike_price * :math.exp(-risk_free_rate * time_to_maturity) * normal_cdf(d2)
  end

  @doc """
  Calculates the Black-Scholes Put Option Price: P = X * e^(-r * t) * N(-d2) - S_0 * N(-d1)

  ## Parameters
    - spot_price: Current price of the underlying asset (S_0)
    - strike_price: Strike price of the option (X)
    - time_to_maturity: Time to expiration in years (t)
    - risk_free_rate: Risk-free interest rate (as a decimal, e.g., 5% as 0.05)
    - volatility: Volatility of the underlying asset (as a decimal, e.g., 20% as 0.2)

  ## Examples
      iex> FinancialEquations.OptionsDerivativesFormulas.black_scholes_put(100, 100, 1, 0.05, 0.2)
      5.573526
  """
  @spec black_scholes_put(float(), float(), float(), float(), float()) :: float()
  def black_scholes_put(spot_price, strike_price, time_to_maturity, risk_free_rate, volatility) do
    {d1, d2} = calculate_d1_d2(spot_price, strike_price, time_to_maturity, risk_free_rate, volatility)
    strike_price * :math.exp(-risk_free_rate * time_to_maturity) * normal_cdf(-d2) - spot_price * normal_cdf(-d1)
  end

  @doc """
  Calculates Put-Call Parity: C + X * e^(-r * t) = P + S_0

  Returns the call price given the put price, or vice versa, depending on the inputs.

  ## Parameters
    - call_price: The price of the call option (C, pass nil if calculating call)
    - put_price: The price of the put option (P, pass nil if calculating put)
    - spot_price: Current price of the underlying asset (S_0)
    - strike_price: Strike price of the option (X)
    - time_to_maturity: Time to expiration in years (t)
    - risk_free_rate: Risk-free interest rate (as a decimal, e.g., 5% as 0.05)

  ## Examples
      iex> FinancialEquations.OptionsDerivativesFormulas.put_call_parity(nil, 5.573526, 100, 100, 1, 0.05)
      10.450583
  """
  @spec put_call_parity(float() | nil, float() | nil, float(), float(), float(), float()) :: float()
  def put_call_parity(call_price, put_price, spot_price, strike_price, time_to_maturity, risk_free_rate) do
    present_value_strike = strike_price * :math.exp(-risk_free_rate * time_to_maturity)
    case {call_price, put_price} do
      {nil, p} -> p + spot_price - present_value_strike
      {c, nil} -> c - spot_price + present_value_strike
      _ -> raise ArgumentError, "Exactly one of call_price or put_price must be nil"
    end
  end

  @doc """
  Calculates Delta (Option Sensitivity to Underlying Price): Δ = ∂C/∂S (approximated as N(d1) for calls)

  ## Parameters
    - spot_price: Current price of the underlying asset (S_0)
    - strike_price: Strike price of the option (X)
    - time_to_maturity: Time to expiration in years (t)
    - risk_free_rate: Risk-free interest rate (as a decimal, e.g., 5% as 0.05)
    - volatility: Volatility of the underlying asset (as a decimal, e.g., 20% as 0.2)
    - option_type: :call or :put

  ## Examples
      iex> FinancialEquations.OptionsDerivativesFormulas.delta(100, 100, 1, 0.05, 0.2, :call)
      0.636831
  """
  @spec delta(float(), float(), float(), float(), float(), :call | :put) :: float()
  def delta(spot_price, strike_price, time_to_maturity, risk_free_rate, volatility, option_type) do
    {d1, _d2} = calculate_d1_d2(spot_price, strike_price, time_to_maturity, risk_free_rate, volatility)
    case option_type do
      :call -> normal_cdf(d1)
      :put -> normal_cdf(d1) - 1
      _ -> raise ArgumentError, "option_type must be :call or :put"
    end
  end

  @doc """
  Calculates Gamma (Rate of Change of Delta): Γ = ∂^2C/∂S^2 = N'(d1) / (S * σ * √t)

  ## Parameters
    - spot_price: Current price of the underlying asset (S_0)
    - strike_price: Strike price of the option (X)
    - time_to_maturity: Time to expiration in years (t)
    - risk_free_rate: Risk-free interest rate (as a decimal, e.g., 5% as 0.05)
    - volatility: Volatility of the underlying asset (as a decimal, e.g., 20% as 0.2)

  ## Examples
      iex> FinancialEquations.OptionsDerivativesFormulas.gamma(100, 100, 1, 0.05, 0.2)
      0.019676
  """
  @spec gamma(float(), float(), float(), float(), float()) :: float()
  def gamma(spot_price, strike_price, time_to_maturity, risk_free_rate, volatility) do
    {d1, _d2} = calculate_d1_d2(spot_price, strike_price, time_to_maturity, risk_free_rate, volatility)
    normal_pdf(d1) / (spot_price * volatility * :math.sqrt(time_to_maturity))
  end

  @doc """
  Calculates Theta (Time Decay of Option): Θ = ∂C/∂t (simplified for calls)

  Theta for a call option is approximated as:
  Θ = -(S * σ * N'(d1)) / (2 * √t) - r * X * e^(-r * t) * N(d2)

  ## Parameters
    - spot_price: Current price of the underlying asset (S_0)
    - strike_price: Strike price of the option (X)
    - time_to_maturity: Time to expiration in years (t)
    - risk_free_rate: Risk-free interest rate (as a decimal, e.g., 5% as 0.05)
    - volatility: Volatility of the underlying asset (as a decimal, e.g., 20% as 0.2)

  ## Examples
      iex> FinancialEquations.OptionsDerivativesFormulas.theta(100, 100, 1, 0.05, 0.2)
      -4.506986
  """
  @spec theta(float(), float(), float(), float(), float()) :: float()
  def theta(spot_price, strike_price, time_to_maturity, risk_free_rate, volatility) do
    {d1, d2} = calculate_d1_d2(spot_price, strike_price, time_to_maturity, risk_free_rate, volatility)
    term1 = -(spot_price * volatility * normal_pdf(d1)) / (2 * :math.sqrt(time_to_maturity))
    term2 = -risk_free_rate * strike_price * :math.exp(-risk_free_rate * time_to_maturity) * normal_cdf(d2)
    term1 + term2
  end

  @doc """
  Calculates Vega (Sensitivity to Volatility): ν = ∂C/∂σ = S * √t * N'(d1)

  ## Parameters
    - spot_price: Current price of the underlying asset (S_0)
    - strike_price: Strike price of the option (X)
    - time_to_maturity: Time to expiration in years (t)
    - risk_free_rate: Risk-free interest rate (as a decimal, e.g., 5% as 0.05)
    - volatility: Volatility of the underlying asset (as a decimal, e.g., 20% as 0.2)

  ## Examples
      iex> FinancialEquations.OptionsDerivativesFormulas.vega(100, 100, 1, 0.05, 0.2)
      39.351847
  """
  @spec vega(float(), float(), float(), float(), float()) :: float()
  def vega(spot_price, strike_price, time_to_maturity, risk_free_rate, volatility) do
    {d1, _d2} = calculate_d1_d2(spot_price, strike_price, time_to_maturity, risk_free_rate, volatility)
    spot_price * :math.sqrt(time_to_maturity) * normal_pdf(d1)
  end

  @doc """
  Calculates Implied Volatility using Newton-Raphson method.

  Solves for volatility (σ) such that the Black-Scholes call price matches the market price.

  ## Parameters
    - market_price: The observed market price of the call option
    - spot_price: Current price of the underlying asset (S_0)
    - strike_price: Strike price of the option (X)
    - time_to_maturity: Time to expiration in years (t)
    - risk_free_rate: Risk-free interest rate (as a decimal, e.g., 5% as 0.05)
    - initial_guess: Initial guess for volatility (as a decimal, e.g., 20% as 0.2)
    - max_iterations: Maximum number of iterations (default: 100)
    - tolerance: Convergence tolerance (default: 0.0001)

  ## Examples
      iex> FinancialEquations.OptionsDerivativesFormulas.implied_volatility(10.450583, 100, 100, 1, 0.05, 0.1)
      0.2
  """
  @spec implied_volatility(float(), float(), float(), float(), float(), float(), integer(), float()) :: float()
  def implied_volatility(market_price, spot_price, strike_price, time_to_maturity, risk_free_rate, initial_guess, max_iterations \\ 100, tolerance \\ 0.0001) do
    newton_raphson(
      initial_guess,
      fn sigma ->
        black_scholes_call(spot_price, strike_price, time_to_maturity, risk_free_rate, sigma) - market_price
      end,
      fn sigma ->
        vega(spot_price, strike_price, time_to_maturity, risk_free_rate, sigma)
      end,
      max_iterations,
      tolerance
    )
  end

  # Helper function to calculate d1 and d2 for Black-Scholes
  @spec calculate_d1_d2(float(), float(), float(), float(), float()) :: {float(), float()}
  defp calculate_d1_d2(spot_price, strike_price, time_to_maturity, risk_free_rate, volatility) do
    d1 =
      (:math.log(spot_price / strike_price) +
         (risk_free_rate + :math.pow(volatility, 2) / 2) * time_to_maturity) /
      (volatility * :math.sqrt(time_to_maturity))

    d2 = d1 - volatility * :math.sqrt(time_to_maturity)
    {d1, d2}
  end

  # Approximation of the cumulative distribution function (CDF) for a standard normal distribution
  @spec normal_cdf(float()) :: float()
  defp normal_cdf(x) do
    # Using the Abramowitz and Stegun approximation for standard normal CDF
    t = 1 / (1 + 0.2316419 * abs(x))
    d = 0.39894228 * :math.exp(-x * x / 2)
    p = d * t * (0.31938153 + t * (-0.356563782 + t * (1.781477937 + t * (-1.821255978 + t * 1.330274429))))
    if x >= 0, do: 1 - p, else: p
  end

  # Probability density function (PDF) for a standard normal distribution
  @spec normal_pdf(float()) :: float()
  defp normal_pdf(x) do
    0.39894228 * :math.exp(-x * x / 2)
  end

  # Newton-Raphson method for solving implied volatility
  @spec newton_raphson(float(), (float() -> float()), (float() -> float()), integer(), float(), integer()) :: float()
  defp newton_raphson(guess, f, f_prime, max_iterations, tolerance, iteration \\ 0) do
    fx = f.(guess)
    if abs(fx) < tolerance || iteration >= max_iterations do
      guess
    else
      fpx = f_prime.(guess)
      new_guess = guess - fx / fpx
      newton_raphson(new_guess, f, f_prime, max_iterations, tolerance, iteration + 1)
    end
  end
end
