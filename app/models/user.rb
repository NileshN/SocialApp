class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  has_many :statuses
  has_many :subscriptions, :foreign_key => :subscribed_by
  
  validates :first_name, :last_name, :presence => true
  
  def display_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def subscribed_already?(visited_user_id)
    self.collect_subscribed_to_ids.include?(visited_user_id)
  end
  
  def get_wall_statuses
    users_for_status = [self.collect_subscribed_to_ids, self.id].flatten!
    statuses = Status.order("created_at DESC")
    statuses.where("user_id IN (?)", users_for_status)
  end
  
  def collect_subscribed_to_ids
    self.subscriptions.collect(&:subscribed_to)
  end
  
  def self.get_users_list(user_ids)
    where("id NOT IN (?)", user_ids)
  end
end
