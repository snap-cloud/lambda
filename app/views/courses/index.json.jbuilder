json.array!(@courses) do |course|
  json.extract! course, :id, :name, :url, :consumer_key, :consumer_secret, :config
  json.url course_url(course, format: :json)
end
