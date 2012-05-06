ActiveAdmin.register User do
  index do
    column :username
    column :email
    column :created_at
    column :invitation_limit
  default_actions 
  end
end
ActiveAdmin.register AdminUser do
  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    column :last_sign_in_ip
    default_actions
  end
end

