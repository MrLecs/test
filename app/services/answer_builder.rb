class AnswerBuilder
  def initialize params
    @params = params['question']['answers']
    
    process
  end
  
  def process
    @answers = @params.map do |item|
      item['correct'] = 0 if item['correct'].nil?
      
      answer_params = permit_answer_params(item)

      if answer_params['id'].to_i == 0
        answer = Answer.create(answer_params)
      else
        answer = Answer.find(answer_params['id'])
        answer.update(answer_params)
      end
      
      answer
    end
  end
  
  def to_array
    @answers
  end
  
  private
  
  def permit_answer_params p
    p.permit(:id, :content, :correct)
  end
end