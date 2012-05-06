class Post < ActiveRecord::Base
  belongs_to :user
  validates :message, :length => { :maximum => 160}
  validates_presence_of :message 
  attr_accessible :id, :message, :user_id
end
