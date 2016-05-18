class History < ActiveRecord::Base
  belongs_to :test_suite
  belongs_to :question

  has_and_belongs_to_many :answers

  def self.start(test_suite)
    create(action: :start, test_suite: test_suite)
  end

  def self.answer(test_suite:, question:, answers:)
    create(action: :answer, test_suite: test_suite, question: question, answers: answers)
  end

  def self.skip_question(test_suite:, question:)
    create(action: :skip_question, test_suite: test_suite, question: question)
  end

  def self.finish(test_suite)
    create(action: :finish, test_suite: test_suite)
  end
end
