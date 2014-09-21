module FormHelper
  def error_messages_for(object)
    if object.errors.any?
      html = "<div class='alert alert-danger'><ul class='errors'>"
      object.errors.full_messages.each do |msg|
        html << "<li>#{msg}</li>"
      end
      html << "</ul></div>"
      html.html_safe
    end
  end
end
