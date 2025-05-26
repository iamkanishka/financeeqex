defmodule FinancialEquations.RiskVolatilityFormulas do
  @moduledoc """
  A module for risk and volatility metrics including standard deviation, variance, beta, Sharpe ratio,
  Sortino ratio, Treynor ratio, Jensen's alpha, and Value at Risk (VaR).
  All functions assume inputs are numerical and appropriate (e.g., non-zero denominators, sufficient data points).
  """

  @doc """
  Calculates Standard Deviation (Risk Measure): σ = √(Σ(X - μ)^2 / N)

  ## Parameters
    - returns: A list of returns (as decimals, e.g., 5% as 0.05)

  ## Examples
      iex> FinancialEquations.RiskVolatilityFormulas.standard_deviation([0.1, 0.2, 0.3])
      0.0816496580927726
  """
  def standard_deviation(returns) do
    n = length(returns)
    mean = Enum.sum(returns) / n
    variance = Enum.reduce(returns, 0, fn x, acc -> acc + :math.pow(x - mean, 2) end) / n
    :math.sqrt(variance)
  end

  @doc """
  Calculates Variance: σ^2 = Σ(X - μ)^2 / N

  ## Parameters
    - returns: A list of returns (as decimals, e.g., 5% as 0.05)

  ## Examples
      iex> FinancialEquations.RiskVolatilityFormulas.variance([0.1, 0.2, 0.3])
      0.006666666666666667
  """
  def variance(returns) do
    n = length(returns)
    mean = Enum.sum(returns) / n
    Enum.reduce(returns, 0, fn x, acc -> acc + :math.pow(x - mean, 2) end) / n
  end

  @doc """
  Calculates Beta (Stock Volatility vs. Market): β = Cov(r_p, r_m) / Var(r_m)

  ## Parameters
    - portfolio_returns: A list of portfolio returns (as decimals, e.g., 5% as 0.05)
    - market_returns: A list of market returns (as decimals, e.g., 5% as 0.05)

  ## Examples
      iex> FinancialEquations.RiskVolatilityFormulas.beta([0.1, 0.2, 0.3], [0.05, 0.15, 0.25])
      1.0
  """
  def beta(portfolio_returns, market_returns) do
    covariance(portfolio_returns, market_returns) / variance(market_returns)
  end

  @doc """
  Calculates Sharpe Ratio (Risk-Adjusted Return): Sharpe Ratio = (r_p - r_f) / σ_p

  ## Parameters
    - portfolio_return: The portfolio return (as a decimal, e.g., 10% as 0.1)
    - risk_free_rate: The risk-free rate (as a decimal, e.g., 2% as 0.02)
    - portfolio_std_dev: The standard deviation of the portfolio returns

  ## Examples
      iex> FinancialEquations.RiskVolatilityFormulas.sharpe_ratio(0.1, 0.02, 0.15)
      0.5333333333333333
  """
  def sharpe_ratio(portfolio_return, risk_free_rate, portfolio_std_dev) do
    (portfolio_return - risk_free_rate) / portfolio_std_dev
  end

  @doc """
  Calculates Sortino Ratio (Downside Risk-Adjusted Return): Sortino Ratio = (r_p - r_f) / σ_d

  ## Parameters
    - portfolio_return: The portfolio return (as a decimal, e.g., 10% as 0.1)
    - risk_free_rate: The risk-free rate (as a decimal, e.g., 2% as 0.02)
    - downside_dev - The downside deviation (standard deviation of negative returns)

  ## Examples
      iex> FinancialEquations.RiskVolatilityFormulas.sortino_ratio(0.1, 0.02, 0.12)
      0.6666666666666666
  """
  def sortino_ratio(portfolio_return, risk_free_rate, downside_deviation) do
    (portfolio_return - risk_free_rate) / downside_deviation
  end

  @doc """
  Calculates Treynor Ratio (Market Risk-Adjusted Return): Treynor Ratio = (r_p - r_f) / β_p

  ## Parameters
    - portfolio_return: The portfolio return (as a decimal, e.g., 10% as 0.1)
    - risk_free_rate: The risk-free rate (as a decimal, e.g., 2% as 0.02)
    - portfolio_beta: The portfolio's beta

  ## Examples
      iex> FinancialEquations.RiskVolatilityFormulas.treynor_ratio(0.1, 0.02, 1.2)
      0.06666666666666667
  """
  def treynor_ratio(portfolio_return, risk_free_rate, portfolio_beta) do
    (portfolio_return - risk_free_rate) / portfolio_beta
  end

  @doc """
  Calculates Jensen's Alpha (Portfolio Performance): α = r_p - [r_f + β(r_m - r_f)]

  ## Parameters
    - portfolio_return: The portfolio return (as a decimal, e.g., 10% as 0.1)
    - risk_free_rate: The risk-free rate (as a decimal, e.g., 2% as 0.02)
    - portfolio_beta: The portfolio's beta
    - market_return: The market return (as a decimal, e.g., 8% as 0.08)

  ## Examples
      iex> FinancialEquations.RiskVolatilityFormulas.jensens_alpha(0.1, 0.02, 1.2, 0.08)
      0.016
  """
  def jensens_alpha(portfolio_return, risk_free_rate, portfolio_beta, market_return) do
    portfolio_return - (risk_free_rate + portfolio_beta * (market_return - risk_free_rate))
  end

  @doc """
  Calculates Value at Risk (VaR) using a simplified statistical measure of potential loss.
  Assumes a normal distribution: VaR = Z x σ x √t, where Z is the Z-score for the confidence level.

  ## Parameters
    - portfolio_value: The value of the portfolio
    - confidence_level: The confidence level (e.g., 0.95 for 95%)
    - volatility: The portfolio's volatility (standard deviation of returns)
    - time_horizon: The time horizon in days

  ## Examples
      iex> FinancialEquations.RiskVolatilityFormulas.value_at_risk(100000, 0.95, 0.02, 1)
      3290.0
  """
  def value_at_risk(portfolio_value, confidence_level, volatility, time_horizon) do
    # Z-scores for common confidence levels (normal distribution)
    z_scores = %{
      0.90 => 1.28155,
      0.95 => 1.64485,
      0.99 => 2.32635
    }
    z_score = z_scores[confidence_level] || raise ArgumentError, "Unsupported confidence level"
    portfolio_value * z_score * volatility * :math.sqrt(time_horizon)
  end

  # Helper function to calculate covariance
  defp covariance(returns1, returns2) do
    n = length(returns1)
    mean1 = Enum.sum(returns1) / n
    mean2 = Enum.sum(returns2) / n
    Enum.zip(returns1, returns2)
    |> Enum.reduce(0, fn {r1, r2}, acc -> acc + (r1 - mean1) * (r2 - mean2) end)
    |> Kernel./(n)
  end
end
