module SessionHelper
  def current_user
    User[session.fetch('User')] || NullUser.new
  end

  def logged_in?
    session.fetch('User') != nil
  end
end
