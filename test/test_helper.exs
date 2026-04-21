Mox.defmock(IncidentIo.Json.Mock, for: IncidentIo.Json)
Application.put_env(:incident_io, :json_module, IncidentIo.Json.Mock)

ExUnit.configure(exclude: [skip: true])
ExUnit.start()
