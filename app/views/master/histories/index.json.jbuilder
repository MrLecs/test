json.array!(@histories) do |history|
  json.extract! history, :id, :student_id, :testings_id, :answer_id, :action
  json.url history_url(history, format: :json)
end
