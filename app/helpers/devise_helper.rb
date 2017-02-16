module DeviseHelper
  def devise_error_messages!
    return if resource.errors.empty?

    safe_join(['<div class="ls-alert-danger"><h3>'.html_safe,
               sentence, '</h3>'.html_safe, messages, '</div>'.html_safe])
  end

  private

  def messages
    resource.errors.full_messages.map { |msg| content_tag(:p, msg) }.join
  end

  def sentence
    I18n.t('errors.messages.not_saved',
           count: resource.errors.count,
           resource: resource.class.model_name.human.downcase)
  end
end
