class Member::ListsController < ApplicationController
  before_action :authenticate_member!
  before_action :confirm_member, except: [:index,:new]

  # マイリスト一覧表示
  def index
    @lists = current_member.lists.all
  end

  def show
    # どのマイリストを選択したのか取得
    @list = current_member.lists.find(params[:id])
    # 中間テーブルから該当するlist_idの楽曲データをlistsに入れる
    @lists = MusicalPieceList.where(list_id: params[:id])
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
    @list = current_member.lists.find(params[:id])
  end

  def update
    @list = current_member.lists.find(params[:id])
    if @list.update(list_params)
      flash[:info] = "リスト名を更新しました"
      redirect_to lists_path
    else
      render "edit"
    end
  end

  def destroy
    list = current_member.lists.find(params[:id])
    list.destroy
    @lists = current_member.lists.all
    flash[:info] = "リストを削除しました"
    render 'index'
  end


  private

  def list_params
    params.require(:list).permit(:name, :member_id)
  end

  def confirm_member
    @list = List.find_by(params[:id])
    redirect_to lists_path if current_member.id != @list.member_id
  end
end
