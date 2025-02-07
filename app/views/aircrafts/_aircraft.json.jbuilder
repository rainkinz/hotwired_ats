json.extract! aircraft, :id, :registration, :model, :category, :complex, :taa, :high_performance, :pressurized, :created_at, :updated_at
json.url aircraft_url(aircraft, format: :json)
