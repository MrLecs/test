class AnswerInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    
    values = object.public_send(attribute_name)
    
    (5 - values.size).times do
      values << Answer.new
    end

    Array(values).map do |answer|
      
      @builder.content_tag(:div) do
        build_id_hidden_field(answer, merged_input_options) +
        build_content_text_field(answer, merged_input_options) + 
        build_check_box(answer, merged_input_options)
      end
      
      
    end.join("<br/>").html_safe
  end

  def input_type
    :text
  end
  
  private
  
  def checked_value
    options.fetch(:checked_value, '1')
  end

  def unchecked_value
    options.fetch(:unchecked_value, '0')
  end
  
  def build_id_hidden_field answer, merged_input_options
    @builder.hidden_field(
      nil,
      merged_input_options.merge(
        value: answer.id,
        name: "question[answers][][id]"
      )
    )
  end
  
  def build_content_text_field answer, merged_input_options
    @builder.text_field(
      nil, 
      merged_input_options.merge(
        value: answer.content, 
        name: "question[answers][][content]", 
        class: 'form-control'
      )
    )
  end
  
  def build_check_box answer, merged_input_options
    @builder.check_box(
      'answers', 
      merged_input_options.merge(
        value: answer.correct,
        name: "question[answers][][correct]", 
        class: 'checkbox'
      ), 
      checked_value, unchecked_value
    )
  end
  
  
end
