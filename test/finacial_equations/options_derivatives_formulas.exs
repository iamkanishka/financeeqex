defmodule FinancialEquations.OptionsDerivativesFormulasTest do
  use ExUnit.Case
  doctest FinancialEquations.OptionsDerivativesFormulas

  test "black scholes call price calculation" do
    assert_in_delta OptionsDerivativesFormulas.black_scholes_call(100, 100, 1, 0.05, 0.2),
                    10.450583,
                    0.001
  end

  test "black scholes put price calculation" do
    assert_in_delta OptionsDerivativesFormulas.black_scholes_put(100, 100, 1, 0.05, 0.2),
                    5.573526,
                    0.001
  end

  test "put call parity calculation" do
    assert_in_delta OptionsDerivativesFormulas.put_call_parity(nil, 5.573526, 100, 100, 1, 0.05),
                    10.450583,
                    0.001
  end

  test "delta calculation for call option" do
    assert_in_delta OptionsDerivativesFormulas.delta(100, 100, 1, 0.05, 0.2, :call),
                    0.636831,
                    0.001
  end

  test "gamma calculation" do
    assert_in_delta OptionsDerivativesFormulas.gamma(100, 100, 1, 0.05, 0.2),
                    0.019676,
                    0.001
  end

  test "theta calculation" do
    assert_in_delta OptionsDerivativesFormulas.theta(100, 100, 1, 0.05, 0.2),
                    -4.506986,
                    0.001
  end

  test "vega calculation" do
    assert_in_delta OptionsDerivativesFormulas.vega(100, 100, 1, 0.05, 0.2),
                    39.351847,
                    0.001
  end

  test "implied volatility calculation" do
    assert_in_delta OptionsDerivativesFormulas.implied_volatility(10.450583, 100, 100, 1, 0.05, 0.1),
                    0.2,
                    0.001
  end
end
