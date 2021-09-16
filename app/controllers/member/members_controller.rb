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
  # 自分のタイムライン
  def timeline
    @followings_members = current_member.followings.ids


    @musical_piece_comments = MusicalPieceComment.where(member_id: @followings_members)
    

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
