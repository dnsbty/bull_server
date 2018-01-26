defmodule BullServer.Mixfile do
  use Mix.Project

  def project do
    [
      app: :bull_server,
      version: "0.0.2",
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      dialyzer: [plt_add_deps: :transitive, ignore_warnings: ".dialyzer.ignore-warnings"]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {BullServer.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:cowboy, "~> 1.0"},
      {:distillery, "~> 1.5"},
      {:gettext, "~> 0.11"},
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:dialyxir, "~> 0.5", only: [:dev]}
    ]
  end

  # Specifies a list of mix task aliases.
  defp aliases() do
    ["compile": ["compile --warnings-as-errors"]]
  end
end
