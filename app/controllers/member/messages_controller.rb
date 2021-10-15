class Member::MessagesController < ApplicationController
  before_action :authenticate_member!, only: [:create]

  def create
    if MemberRoom.where(member_id: current_member.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params)
      @room = @message.room
      if @message.save
        @roommembernotme = MemberRoom.where(room_id: @room.id).where.not(member_id: current_member.id)
        @theid = @roommembernotme.find_by(room_id: @room.id)
        notification = current_member.active_notifications.new(
          room_id: @room.id,
          message_id: @message.id,
          visited_id: @theid.member_id,
          visitor_id: current_member.id,
          action: 'dm'
        )
        # 自分の投稿に対するコメントの場合は、通知済みとする
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        # validメソッドはエラーがなければtrueを返す(invalidの逆)
        notification.save if notification.valid?
        redirect_to room_path(@message.room_id)
      end
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def message_params
    params.require(:message).permit(:member_id, :message, :room_id).merge(member_id: current_member.id)
  end
end
