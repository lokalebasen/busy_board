defmodule BusyBoard.Mixfile do
  use Mix.Project

  def project do
    [app: :busy_board,
     version: "0.2.0",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :cowboy, :plug, :gproc, :poison],
     mod: {BusyBoard, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:plug, "~> 1.1"},
      {:cowboy, "~> 1.0"},
      {:poison, "~> 2.1"},
      {:gproc, "~> 0.5"},
      {:exrm, "~> 1.0"}
    ]
  end
end
