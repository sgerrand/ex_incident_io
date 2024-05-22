defmodule IncidentIo.Mixfile do
  use Mix.Project

  @source_url "https://github.com/sgerrand/ex_incident_io"
  @version "0.0.0-dev"

  def project do
    [
      app: :incident_io,
      version: @version,
      elixir: "~> 1.9",
      name: "IncidentIo",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test],
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
            {:httpoison, "~> 2.0"},
            {:jason, "~> 1.2"},
            {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
            {:inch_ex, "~> 0.5", only: :dev},
            {:excoveralls, "~> 0.5", only: :test},
            {:exvcr, "~> 0.10", only: :test},
            {:meck, "~> 0.8.9", only: :test}
          ]
  end

  defp package do
    [
      description: "An Elixir client for the incident.io API.",
      maintainers: ["Sasha Gerrand"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      extras: [
        "LICENSE": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      formatters: ["html"]
    ]
  end
end
