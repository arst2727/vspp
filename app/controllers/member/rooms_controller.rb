class Member::RoomsController < ApplicationController
  before_action :authenticate_member!

  def create
    @room = Room.create
    @member_room1 = MemberRoom.create(room_id: @room.id, member_id: current_member.id)
    @member_room2 = MemberRoom.create(join_room_params)
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    if MemberRoom.where(member_id: current_member.id,room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @member_rooms = @room.member_rooms
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def join_room_params
    params.permit(:member_id, :room_id).merge(room_id: @room.id)
  end
end
