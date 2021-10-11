class Member::MessagesController < ApplicationController
  before_action :authenticate_member!, only: [:create]

  def create
    if MemberRoom.where(member_id: current_member.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params)
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
    end
    redirect_to room_path(@message.room_id)
  end

  private

  def message_params
    params.require(:message).permit(:member_id, :message, :room_id).merge(member_id: current_member.id)
  end
end
