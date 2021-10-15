class Member::NotificationsController < ApplicationController
  before_action :authenticate_member!

  def index
    @notifications = current_member.passive_notifications
  end

  def update
    notification = Notification.find(params[:id])
    if notification.update(checked: true)
      redirect_to action: :index
    end
  end
end
