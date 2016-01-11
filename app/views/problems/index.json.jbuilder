json.array!(@problems) do |problem|
  json.extract! problem, :id, :title, :points, :content, :tests, :initial_file, :metadata, :tags
  json.url problem_url(problem, format: :json)
end
