class Member::MusicalPieceListsController < ApplicationController
  before_action :authenticate_member!
  def create
    @musical_piece_list = MusicalPieceList.new(musical_piece_list_params)
    if @musical_piece_list.save
      flash[:success] = "マイリストに追加しました"
      redirect_back fallback_location: root_path
    else
      flash[:danger] = "選択したリストにすでに追加済みか、または他の理由によりリストに追加できませんでした"
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @musical_piece_list = MusicalPieceList.find(params[:id])
    @musical_piece_list.destroy
    flash[:info] = "マイリストから削除しました"
    redirect_back fallback_location: root_path
  end

  private

  def musical_piece_list_params
    params.require(:musical_piece_list).permit(:list_id, :musical_piece_id)
  end
end
