class Member::MusicalPieceListsController < ApplicationController

  def create
    @musical_piece_list = MusicalPieceList.new(musical_piece_list_params)
    if @musical_piece_list.save
      redirect_back fallback_location: root_path, success: "マイリストに追加しました"
    else
      redirect_back fallback_location: root_path, danger: "選択したリストにすでに追加済みか、または他の理由によりリストに追加できませんでした"
    end
  end

  def destroy
    @musical_piece_list = MusicalPieceList.find(params[:id])
    @musical_piece_list.destroy
    redirect_back fallback_location: root_path, success: "マイリストから削除しました"
  end

  private
  def musical_piece_list_params
    params.require(:musical_piece_list).permit(:list_id, :musical_piece_id)
  end
end
