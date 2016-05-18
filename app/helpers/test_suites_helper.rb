module TestSuitesHelper
  def action_label(action)
    css_class = case action
    when 'start', 'finish' then 'label-success'
    when 'answer'          then 'label-info'
    when 'skip_question'   then 'label-warning'
    else 'label-default'
    end

    content_tag(:span, class: [ 'label', css_class ]) do
      I18n.t(action, scope: 'test_suite')
    end
  end
end
