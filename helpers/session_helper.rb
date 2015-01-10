module SessionHelper
  def current_user
    User[session.fetch('User')] || NullUser.new
  end
end
