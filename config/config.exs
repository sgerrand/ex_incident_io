import Config

if config_env() == :test do
  config :incident_io, :request_options, plug: {Req.Test, :incident_io}
end
