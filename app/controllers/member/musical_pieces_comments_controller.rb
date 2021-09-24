class Member::MusicalPiecesCommentsController < ApplicationController
  def create
    @musical_piece = MusicalPiece.find(params[:musical_piece_id])
    @musical_piece_comment = current_member.musical_piece_comments.new(musical_piece_comment_params)
    @musical_piece_comment.musical_piece_id = @musical_piece.id

    if @musical_piece_comment.save
      # カレンダー機能用start_timeにコメントのcreated_atを格納
      @musical_piece_comment.start_time = @musical_piece_comment.created_at
      @musical_piece_comment.save
      flash[:success] = 'レビュー投稿が完了しました'
      redirect_to musical_piece_path(params[:musical_piece_id])
    else
      @musical_piece_comments = @musical_piece.musical_piece_comments
      render 'member/musical_pieces/show', id: @musical_piece.id
    end
  end

  def destroy
    MusicalPieceComment.find_by(id: params[:id], musical_piece_id: params[:musical_piece_id]).destroy
    flash[:info] = 'レビューを削除しました'
    redirect_to musical_piece_path(params[:musical_piece_id])
  end

  private

  def musical_piece_comment_params
    params.require(:musical_piece_comment).permit(:comment, :evaluation, :start_time)
  end
end
