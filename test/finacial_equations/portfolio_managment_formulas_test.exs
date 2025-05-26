defmodule FinancialEquations.InvestmentReturnFormulasTest do
  use ExUnit.Case
  doctest FinancialEquations.PortfolioManagmentFormulas

  test "Expected Portfolio Return calculation" do
    assert PortfolioManagmentFormulas.expected_portfolio_return([0.6, 0.4], [0.1, 0.05]) == 0.08
  end

  test "Portfolio Variance for Two Assets calculation" do
    assert_in_delta PortfolioManagmentFormulas.portfolio_variance_two_assets(0.6, 0.4, 0.04, 0.02, 0.5),
                    0.0208,
                    0.0001
  end

  test "Covariance calculation" do
    assert_in_delta PortfolioManagmentFormulas.covariance([0.1, 0.2, 0.3], [0.05, 0.15, 0.25]),
                    0.005,
                    0.0001
  end

  test "Correlation calculation" do
    returns_x = [0.1, 0.2, 0.3]
    returns_y = [0.05, 0.15, 0.25]
    cov = PortfolioManagmentFormulas.covariance(returns_x, returns_y)
    std_x = PortfolioManagmentFormulas.standard_deviation(returns_x)
    std_y = PortfolioManagmentFormulas.standard_deviation(returns_y)
    assert_in_delta PortfolioManagmentFormulas.correlation(cov, std_x, std_y), 1.0, 0.0001
  end

  test "CML calculation" do
    assert_in_delta PortfolioManagmentFormulas.cml(0.03, 0.1, 0.2, 0.15), 0.0775, 0.0001
  end

  test "SML/CAPM calculation" do
    assert_in_delta PortfolioManagmentFormulas.sml(0.03, 1.2, 0.1), 0.114, 0.0001
  end

  test "APT calculation" do
    assert_in_delta PortfolioManagmentFormulas.apt(0.03, [1.2, 0.8], [0.05, 0.03]), 0.114, 0.0001
  end

  test "Fama-French Three-Factor Model calculation" do
    assert_in_delta PortfolioManagmentFormulas.fama_french(0.03, 1.1, 0.1, 0.5, 0.04, 0.3, 0.02),
                    0.121,
                    0.0001
  end

  test "Carhart Four-Factor Model calculation" do
    assert_in_delta PortfolioManagmentFormulas.carhart_four_factor(
                      0.03,
                      1.1,
                      0.1,
                      0.5,
                      0.04,
                      0.3,
                      0.02,
                      0.2,
                      0.03
                    ),
                    0.127,
                    0.0001
  end
end
