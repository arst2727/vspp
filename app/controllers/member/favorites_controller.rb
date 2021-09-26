class Member::FavoritesController < ApplicationController
  before_action :authenticate_member!
  def create
    @musical_piece_comment = MusicalPieceComment.find(params[:musical_pieces_comment_id])
    favorite = @musical_piece_comment.favorites.new(member_id: current_member.id)
    favorite.save
  end

  def destroy
    @musical_piece_comment = MusicalPieceComment.find(params[:musical_pieces_comment_id])
    favorite = @musical_piece_comment.favorites.find_by(member_id: current_member.id)
    favorite.destroy
  end
end
