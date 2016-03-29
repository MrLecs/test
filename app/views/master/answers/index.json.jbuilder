json.array!(@answers) do |answer|
  json.extract! answer, :id, :question_id, :content, :correct
  json.url answer_url(answer, format: :json)
end
