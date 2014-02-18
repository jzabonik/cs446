json.array!(@considerations) do |consideration|
  json.extract! consideration, :id
  json.url consideration_url(consideration, format: :json)
end
