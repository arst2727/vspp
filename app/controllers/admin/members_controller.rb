class Admin::MembersController < ApplicationController
  def index
    @members = Member.all.page(params[:page]).per(100)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    member = Member.find(params[:id])
    member.update(member_params)
    redirect_to admin_member_path(member)
  end

  def destroy
    member = Member.find(params[:id])
    member.destroy
    redirect_to admin_members_path
  end

  private

  def member_params
    params.require(:member).permit(:nickname, :email, :profile_image)
  end
end
