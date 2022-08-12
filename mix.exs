defmodule Bolik.MixProject do
  use Mix.Project

  def project do
    [
      app: :bolik,
      version: "0.1.0",
      elixir: "~> 1.13",
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Bolik.Application, []},
      extra_applications: [:plug, :logger, :runtime_tools]
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.5"},
      {:mogrify, "~> 0.9.2"},
      {:jason, "~> 1.3"}
    ]
  end
end
