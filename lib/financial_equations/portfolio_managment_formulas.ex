defmodule FinancialEquations.PortfolioManagmentFormulas do
  @moduledoc """
  A module for advanced investment and portfolio management calculations.
  """

  @doc """
  Calculates the expected portfolio return.

  ## Parameters
    - weights: List of weights (list of floats)
    - returns: List of returns (list of floats)

  ## Examples
      iex> PortfolioManagement.expected_portfolio_return([0.6, 0.4], [0.1, 0.05])
      0.08
  """
  @spec expected_portfolio_return(list(float()), list(float())) :: float()
  def expected_portfolio_return(weights, returns) do
    Enum.zip(weights, returns)
    |> Enum.reduce(0.0, fn {w, r}, acc -> acc + w * r end)
  end

  @doc """
  Calculates the portfolio variance for two assets.

  ## Parameters
    - w1: Weight of asset 1 (float)
    - w2: Weight of asset 2 (float)
    - var1: Variance of asset 1 (float)
    - var2: Variance of asset 2 (float)
    - p: Correlation coefficient between assets (float)

  ## Examples
      iex> PortfolioManagement.portfolio_variance_two_assets(0.6, 0.4, 0.04, 0.02, 0.5)
      0.0208
  """
  @spec portfolio_variance_two_assets(float(), float(), float(), float(), float()) :: float()
  def portfolio_variance_two_assets(w1, w2, var1, var2, p) do
    term1 = :math.pow(w1, 2) * var1
    term2 = :math.pow(w2, 2) * var2
    term3 = 2 * w1 * w2 * p * :math.sqrt(var1) * :math.sqrt(var2)
    term1 + term2 + term3
  end

  @doc """
  Calculates the covariance between two assets.

  ## Parameters
    - returns_x: List of returns for asset X (list of floats)
    - returns_y: List of returns for asset Y (list of floats)

  ## Examples
      iex> PortfolioManagement.covariance([0.1, 0.2, 0.3], [0.05, 0.15, 0.25])
      0.005
  """
  @spec covariance(list(float()), list(float())) :: float()
  def covariance(returns_x, returns_y) do
    n = length(returns_x)
    mean_x = Enum.sum(returns_x) / n
    mean_y = Enum.sum(returns_y) / n

    Enum.zip(returns_x, returns_y)
    |> Enum.reduce(0.0, fn {x, y}, acc -> acc + (x - mean_x) * (y - mean_y) end)
    |> Kernel./(n - 1)
  end

  @doc """
  Calculates the correlation coefficient between two assets.

  ## Parameters
    - cov: Covariance between assets (float)
    - std_x: Standard deviation of asset X (float)
    - std_y: Standard deviation of asset Y (float)

  ## Examples
      iex> PortfolioManagement.correlation(0.005, 0.1, 0.05)
      1.0
  """
  @spec correlation(float(), float(), float()) :: float()
  def correlation(cov, std_x, std_y) do
    cov / (std_x * std_y)
  end

  @doc """
  Calculates the expected return using the Capital Market Line (CML).

  ## Parameters
    - rf: Risk-free rate (float)
    - er_m: Expected return of the market (float)
    - std_m: Standard deviation of the market (float)
    - std_p: Standard deviation of the portfolio (float)

  ## Examples
      iex> PortfolioManagement.cml(0.03, 0.1, 0.2, 0.15)
      0.0775
  """
  @spec cml(float(), float(), float(), float()) :: float()
  def cml(rf, er_m, std_m, std_p) do
    rf + ((er_m - rf) / std_m) * std_p
  end

  @doc """
  Calculates the expected return using the Security Market Line (SML) / CAPM.

  ## Parameters
    - rf: Risk-free rate (float)
    - beta: Beta of the asset (float)
    - er_m: Expected return of the market (float)

  ## Examples
      iex> PortfolioManagement.sml(0.03, 1.2, 0.1)
      0.114
  """
  @spec sml(float(), float(), float()) :: float()
  def sml(rf, beta, er_m) do
    rf + beta * (er_m - rf)
  end

  @doc """
  Calculates the Arbitrage Pricing Theory (APT) expected return.

  ## Parameters
    - rf: Risk-free rate (float)
    - factors: List of factor sensitivities (list of floats)
    - risk_premia: List of risk premia for each factor (list of floats)

  ## Examples
      iex> PortfolioManagement.apt(0.03, [1.2, 0.8], [0.05, 0.03])
      0.114
  """
  @spec apt(float(), list(float()), list(float())) :: float()
  def apt(rf, factors, risk_premia) do
    factor_contributions =
      Enum.zip(factors, risk_premia)
      |> Enum.reduce(0.0, fn {f, rp}, acc -> acc + f * rp end)

    rf + factor_contributions
  end

  @doc """
  Calculates the expected return using the Fama-French Three-Factor Model.

  ## Parameters
    - rf: Risk-free rate (float)
    - beta_m: Market beta (float)
    - er_m: Expected return of the market (float)
    - beta_smb: SMB beta (float)
    - smb: SMB factor return (float)
    - beta_hml: HML beta (float)
    - hml: HML factor return (float)

  ## Examples
      iex> PortfolioManagement.fama_french(0.03, 1.1, 0.1, 0.5, 0.04, 0.3, 0.02)
      0.121
  """
  @spec fama_french(float(), float(), float(), float(), float(), float(), float()) :: float()
  def fama_french(rf, beta_m, er_m, beta_smb, smb, beta_hml, hml) do
    market_premium = beta_m * (er_m - rf)
    smb_premium = beta_smb * smb
    hml_premium = beta_hml * hml
    rf + market_premium + smb_premium + hml_premium
  end

  @doc """
  Calculates the expected return using the Carhart Four-Factor Model.

  ## Parameters
    - rf: Risk-free rate (float)
    - beta_m: Market beta (float)
    - er_m: Expected return of the market (float)
    - beta_smb: SMB beta (float)
    - smb: SMB factor return (float)
    - beta_hml: HML beta (float)
    - hml: HML factor return (float)
    - beta_mom: Momentum beta (float)
    - mom: Momentum factor return (float)

  ## Examples
      iex> PortfolioManagement.carhart_four_factor(0.03, 1.1, 0.1, 0.5, 0.04, 0.3, 0.02, 0.2, 0.03)
      0.127
  """
  @spec carhart_four_factor(float(), float(), float(), float(), float(), float(), float(), float(), float()) :: float()
  def carhart_four_factor(rf, beta_m, er_m, beta_smb, smb, beta_hml, hml, beta_mom, mom) do
    market_premium = beta_m * (er_m - rf)
    smb_premium = beta_smb * smb
    hml_premium = beta_hml * hml
    mom_premium = beta_mom * mom
    rf + market_premium + smb_premium + hml_premium + mom_premium
  end

  # Helper function to calculate standard deviation (used internally for tests)
  # defp standard_deviation(values) do
  #   n = length(values)
  #   mean = Enum.sum(values) / n
  #   variance =
  #     Enum.reduce(values, 0.0, fn x, acc -> acc + :math.pow(x - mean, 2) end) / (n - 1)
  #   :math.sqrt(variance)
  # end
end
