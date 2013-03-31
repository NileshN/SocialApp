class HomeController < ApplicationController
  
  def index
    @user = current_user
    @statuses = @user.get_wall_statuses
    @users = User.get_users_list([@user.id])
  end
end
