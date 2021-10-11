class Member::MembersController < ApplicationController
  before_action :authenticate_member!
  def index
    # @members = Member.all.page(params[:page]).per(100)
    @search_params = member_search_params
    @members = Member.search(@search_params)
  end

  # ログインしているユーザのマイページ
  def my_page
    @musical_piece_comments = MusicalPieceComment.where(member_id: current_member)
  end

  # 他人のページ
  def show
    @member = Member.find(params[:id])
    if @member.id == current_member.id
      @musical_piece_comments = MusicalPieceComment.where(member_id: current_member)
      render :my_page
    end
    @musical_piece_comments = MusicalPieceComment.where(member_id: @member)
    # ダイレクトメッセージ機能
    @currentMemberRoom = MemberRoom.where(member_id: current_member.id)
    @receiveMember = MemberRoom.where(member_id: @member.id)
    # 上記2行でMemberとRoomの中間テーブルのデータそれぞれ割り出す

    unless @member.id == current_member.id
      @currentMemberRoom.each do |cm|
        @receiveMember.each do |m|
          if cm.room_id == m.room_id
            @haveRoom = true
            @roomId = cm.room_id
          end
        end
      end
      # roomが作成されていない場合は作る
      unless @haveRoom
        @room = Room.new
        @member_room = MemberRoom.new
      end
    end
  end

  # 自分のタイムライン(最新100件取得)
  def timeline
    # 自分がフォローしているメンバーのidを取得(複数)
    @followings_members = current_member.followings.ids
    @musical_piece_comments = MusicalPieceComment.where(member_id: @followings_members).order(created_at: :desc).limit(100)
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    if @member.update(member_params)
      flash[:info] = 'プロフィールを更新しました'
      redirect_to my_page_members_path
    else
      flash[:alert] = 'プロフィールを更新できませんでした'
      render :edit
    end
  end

  private

  def member_params
    params.require(:member).permit(:nickname, :email, :profile_image)
  end

  def member_search_params
    params.fetch(:search, {}).permit(:nickname)
  end
end
