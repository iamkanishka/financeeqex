defmodule FinanceEquations.MixProject do
  use Mix.Project

  @source_url "https://github.com/iamkanishka/financeeqex"
  @version "0.1.0"

  def project do
    [
      app: :finance_equations,
      version: @version,
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      description:
        "A collection of essential financial formulas and models implemented in Elixir. Covers topics such as interest calculations, present and future value, annuities, loan amortization, investment returns, and risk metrics",
      package: package()
    ]
  end

  defp package do
    [
      name: "finance_equations",
      # License, e.g., MIT, Apache 2.0
      licenses: ["Apache-2.0"],
      links: %{
        GitHub: @source_url
      },
      maintainers: ["Kanishka Naik"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.28", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
