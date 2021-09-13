class Member::ListsController < ApplicationController
  before_action :authenticate_member!

  def index
    @lists = current_member.lists.all
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = current_member.lists.new(list_params)

    if @list.save
      @lists = current_member.lists.all
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
      redirect_to list_path(@list), notice: "You have updated list successfully."
    else
      render "edit"
    end
  end

  def destroy
    list = List.find(params[:id])
    list.destroy
    @lists = current_member.lists.all
    render 'index'
  end

  def all_destroy
  end

  private

  def list_params
    params.require(:list).permit(:musical_piece_id, :name)
  end
end
