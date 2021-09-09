class Member::MusicalPiecesCommentsController <
  def create
    musical_piece = MusicalPieceComment.find(params[:musical_piece_id])
    comment = current_user.musical_piece_comments.new(musical_piece_comment_params)
    comment.musical_piece_id = musical_piece.id
    if comment.save
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "comment can't be blank<br>maximum is 200 characters"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    MusicalPieceComment.find_by(id: params[:id], musical_piece_id: params[:musical_piece_id]).destroy
    redirect_to musical_piece_path(params[:musical_piece_id])
  end

  private

  def musical_piece_comment_params
    params.require(:musical_piece_comment).permit(:comment)
  end
end
