json.array!(@students) do |student|
  json.extract! student, :id, :surname, :name, :patronymic, :group_id
  json.url student_url(student, format: :json)
end
