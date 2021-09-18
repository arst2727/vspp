class Member::ListsController < ApplicationController
  before_action :authenticate_member!

  def index
    @lists = current_member.lists.all
  end

  def show
    @lists = MusicalPieceList.where(list_id: params[:id])
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = current_member.lists.new(list_params)

    if @list.save
      @lists = current_member.lists.all
      flash[:success] = "リストを新規作成しました"
      render 'index'
    # 保存できなかった場合
    else
      render 'new'
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      flash[:info] = "リスト名を更新しました"
      redirect_to lists_path
    else
      render "edit"
    end
  end

  def destroy
    list = List.find(params[:id])
    list.destroy
    @lists = current_member.lists.all
    flash[:info] = "リストを削除しました"
    render 'index'
  end


  private

  def list_params
    params.require(:list).permit(:name, :member_id)
  end
end
