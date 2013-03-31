class Status < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  
  validates :content, :presence => true, :exclusion => { :in => "What's in your mind?" }
end
