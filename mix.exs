defmodule IncidentIo.Mixfile do
  use Mix.Project

  @source_url "https://github.com/sgerrand/ex_incident_io"
  @version "0.1.0-dev"

  def project do
    [
      app: :incident_io,
      version: @version,
      elixir: "~> 1.9",
      name: "IncidentIo",
      elixirc_paths: elixirc_paths(Mix.env()),
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

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:httpoison, "~> 2.0"},
      {:jason, "~> 1.2"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:expublish, "~> 2.5", only: [:dev], runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:inch_ex, "~> 2.0", only: :dev},
      {:excoveralls, "~> 0.5", only: :test},
      {:exvcr, "~> 0.10", only: :test},
      {:meck, "~> 0.9.2", only: :test}
    ]
  end

  defp package do
    [
      description: "An Elixir client for the incident.io API.",
      maintainers: ["Sasha Gerrand"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url,
        "Changelog" => "https://hexdocs.pm/incident_io/changelog.html"
      }
    ]
  end

  defp docs do
    [
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      extras: [
        "CHANGELOG.md": [title: "Changelog"],
        LICENSE: [title: "License"],
        "README.md": [title: "Overview"]
      ],
      formatters: ["html"]
    ]
  end
end
