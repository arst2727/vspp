class Member::MusicalPiecesCommentsController < ApplicationController

  def create
    @musical_piece = MusicalPiece.find(params[:musical_piece_id])
    @musical_piece_comment = current_member.musical_piece_comments.new(musical_piece_comment_params)
    @musical_piece_comment.musical_piece_id = @musical_piece.id

    if @musical_piece_comment.save
      redirect_to musical_piece_path(params[:musical_piece_id])
    else
      @musical_piece_comments = @musical_piece.musical_piece_comments
      render 'member/musical_pieces/show', id: @musical_piece.id
    end
  end

  def destroy
    MusicalPieceComment.find_by(id: params[:id], musical_piece_id: params[:musical_piece_id]).destroy
    redirect_to musical_piece_path(params[:musical_piece_id])
  end

  private

  def musical_piece_comment_params
    params.require(:musical_piece_comment).permit(:comment, :evaluation)
  end
end
