#Contoller for the assigning admins page
class AdminController < ApplicationController
  def index
    if require_admin
      @admins = User.where(:admin => true)
      @notification_count = Notification.count
    end
  end
  def revoke
    if require_admin
      user = User.find_by_id(params[:id])
      if user
        user.admin = false
        user.save
      end
      redirect_to(admin_path)
    end
  end

  def make
    if require_admin
      User.where(:email => params[:email]).first_or_initialize.tap do |user|
        user.admin = true
        user.email = params[:email]
        user.save!
      end
      redirect_to(admin_path)
    end
  end
end
