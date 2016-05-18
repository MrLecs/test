json.array!(@test_suites) do |test_suite|
  json.extract! test_suite, :id, :student_id, :testing_id, :started_at, :finished_at
  json.url test_suite_url(test_suite, format: :json)
end
