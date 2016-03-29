json.array!(@testings) do |testing|
  json.extract! testing, :id, :title, :description
  json.url testing_url(testing, format: :json)
end
