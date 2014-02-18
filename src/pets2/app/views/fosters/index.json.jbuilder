json.array!(@fosters) do |foster|
  json.extract! foster, :id
  json.url foster_url(foster, format: :json)
end
