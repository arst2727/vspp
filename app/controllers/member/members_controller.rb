class Member::MembersController < ApplicationController
  before_action :authenticate_member!
  # ログインしているユーザのマイページ
  def my_page
  end
  # 他人のマイページ
  def show
    @member = Member.find(params[:id])
    if @member.id==current_member.id
      render :my_page
    end
  end
  # 自分のタイムライン
  def timeline
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
