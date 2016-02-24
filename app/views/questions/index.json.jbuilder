json.array!(@questions) do |question|
  json.extract! question, :id, :title, :points, :content, :tests, :initial_file, :metadata, :tags
  json.url question_url(question, format: :json)
end
