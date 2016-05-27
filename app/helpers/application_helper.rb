module ApplicationHelper

  def active_menu key
    'active' if controller_name.to_sym == key.to_sym
  end

end
