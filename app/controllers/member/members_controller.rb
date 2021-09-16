class Member::MembersController < ApplicationController
  before_action :authenticate_member!
  # ログインしているユーザのマイページ
  def my_page
  end
  # 他人のページ
  def show
    @member = Member.find(params[:id])
    if @member.id == current_member.id
      render :my_page
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
      redirect_to my_page_members_path
    else
      render :edit
    end
  end

  def member_params
    params.require(:member).permit(:nickname, :email, :profile_image)
  end
end
