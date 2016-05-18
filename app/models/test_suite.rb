class TestSuite < ActiveRecord::Base
  belongs_to :student
  belongs_to :testing
  has_many :histories

  def self.start(student:, testing:)
    test_suite = nil

    transaction do
      test_suite = create(student: student, testing: testing, started_at: Time.now )

      History.start(test_suite)
    end

    test_suite
  end

  def answer(question:, answers:)
    History.answer(test_suite: self, question: question, answers: answers)
  end

  def skip_question(question:)
    History.skip_question(test_suite: self, question: question)
  end

  def finish
    transaction do
      update(finished_at: Time.now)

      History.finish(self)
    end
    
    check_answers
  end
  
  def check_answers
    h = {}
    
    self.histories.each do |history|
      h[history.question.id] = history.answers if history.action == 'answer'
    end
    
    self.result = 0 
    self.testing.questions.each do |question|
      student_answers = h[question.id]
      if student_answers
        correct_answers = question.answers.where(correct: true)
        
        if student_answers.map(&:id).sort == correct_answers.map(&:id).sort
          self.result += 1
        end
      end
    end
    
    save
  end
end
