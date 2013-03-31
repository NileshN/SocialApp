class UsersController < ApplicationController
  
  def subscription
    @visited_user = User.find(params[:sub_to])
    return unless @visited_user
    subscription = current_user.subscriptions.new
    subscription.subscribed_to = @visited_user.id
    subscription.save!
    @from = "subscribe"
    if request.xhr?
      render :update do |page|
        flash[:notice] = "Subscribed Successfully"
        page.replace_html "subscribe_link_pane", :inline => ''
      end
    end
  end
  
  def unsubscription
    @visited_user = User.find(params[:unsub_to])
    return unless @visited_user
    subscription = current_user.subscriptions.where("subscribed_to = ?", @visited_user.id).first
    subscription.delete
    @from = "unsubscribe"
    if request.xhr?
      render :update do |page|
        flash[:notice] = "Unubscribed Successfully"
        page.replace_html "subscribe_link_pane", :inline => ''
      end
    end
  end
  
end
