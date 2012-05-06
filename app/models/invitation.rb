class Invitation < ActiveRecord::Base
  attr_accessible :sender_id, :recipient_email, :token, :sent_at
  belongs_to :sender, :class_name => 'User'
  has_one :recipient, :class_name => 'User'
  validates_presence_of :recipient_email
  validate :recipient_is_not_registered
  #validate :sender_has_invitations, :if => :sender
  
  before_create :generate_token
  before_create :decrement_sender_count, :if => :sender
  validates_format_of :recipient_email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  private
  def  recipient_is_not_registered
    errors.add :recipient_email, 'is already registered' if User.find_by_email(recipient_email)
  end
  
  def sender_has_invitations
    unless sender.invitation_limit > 0
      errors.add_to_base 'You have reached your limit of invitations to send.'
    end
  end
  
  def generate_token
    self.token = rand(36**8).to_s(36)+([Time.now, rand].join)
  end
  
  def decrement_sender_count
    sender.decrement! :invitation_limit
  end
end
