module ApplicationHelper
  def button_active?(status, current_status)
    'ls-active' if status == current_status
  end
end
