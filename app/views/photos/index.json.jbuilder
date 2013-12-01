json.array!(@photos) do |photo|
  json.extract! photo, :title, :photographer, :price
  json.url photo_url(photo, format: :json)
end
