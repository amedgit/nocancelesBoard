module UsersHelper
  def user_posts(user)
    user.transports.count + user.ocios.count + user.alojamientos.count
  end
end
