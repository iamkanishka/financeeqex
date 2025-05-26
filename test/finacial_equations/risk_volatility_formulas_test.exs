defmodule FinancialEquations.RiskVolatilityFormulasTest do
  use ExUnit.Case
  doctest FinancialEquations.RiskVolatilityFormulas

  test "standard deviation calculation" do
    assert_in_delta RiskVolatilityFormulas.standard_deviation([0.1, 0.2, 0.3]),
                    0.0816496580927726,
                    0.000001
  end

  test "variance calculation" do
    assert_in_delta RiskVolatilityFormulas.variance([0.1, 0.2, 0.3]),
                    0.006666666666666667,
                    0.000001
  end

  test "beta calculation" do
    assert_in_delta RiskVolatilityFormulas.beta([0.1, 0.2, 0.3], [
                      0.05,
                      0.15,
                      0.25
                    ]),
                    1.0,
                    0.000001
  end

  test "sharpe ratio calculation" do
    assert_in_delta RiskVolatilityFormulas.sharpe_ratio(0.1, 0.02, 0.15),
                    0.5333333333333333,
                    0.000001
  end

  test "sortino ratio calculation" do
    assert_in_delta RiskVolatilityFormulas.sortino_ratio(0.1, 0.02, 0.12),
                    0.6666666666666666,
                    0.000001
  end

  test "treynor ratio calculation" do
    assert_in_delta RiskVolatilityFormulas.treynor_ratio(0.1, 0.02, 1.2),
                    0.06666666666666667,
                    0.000001
  end

  test "jensens alpha calculation" do
    assert_in_delta RiskVolatilityFormulas.jensens_alpha(0.1, 0.02, 1.2, 0.08),
                    0.016,
                    0.000001
  end

  test "value at risk calculation" do
    assert_in_delta RiskVolatilityFormulas.value_at_risk(
                      100_000,
                      0.95,
                      0.02,
                      1
                    ),
                    3290.0,
                    0.1
  end
end
