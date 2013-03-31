class StatusesController < ApplicationController
  
  respond_to :html, :xml, :json
  
  def index
    @user = User.find params[:user_id]
    @statuses = @user.statuses.order("created_at DESC")
    @users = User.get_users_list([@user.id, current_user.id])
    render :template => "home/index"
  end
  
  def create
    @status = Status.new
    @status.content = params[:content]
    @status.user = current_user

    if @status.save
      if request.xhr?
        render :update do |page|
          flash[:notice] = "Statue posted successfully."
          page.replace_html "status_new", :inline => @status
        end
      else
        redirect_to @status
      end
    else
      if request.xhr?
        render :json => @status.errors, :status => :unprocessable_entity
      else
        render :action => :new, :status => :unprocessable_entity
      end
    end
  end

end
