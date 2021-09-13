class Member::MusicalPiecesController < ApplicationController
  before_action :authenticate_member!,except: [:index]

  # 楽曲一覧
  def index
    @musical_pieces = MusicalPiece.all.page(params[:page]).per(4)
  end

  # 楽曲詳細
  def show
    @musical_piece = MusicalPiece.find(params[:id])

    @musical_piece_comments = @musical_piece.musical_piece_comments
    @musical_piece_comment = MusicalPieceComment.new
  end

  # 楽曲新規作成
  def new
    @musical_piece = MusicalPiece.new
  end

  # 楽曲登録処理
  def create
    @musical_piece = MusicalPiece.new(musical_piece_params)
    if @musical_piece.save
      @musical_pieces = MusicalPiece.all
      render 'index'
    else
      render 'new'
    end
  end

  private

  def musical_piece_params
    params.require(:musical_piece).permit(:composer_id, :musical_piece_name, :year_of_composition, :performance_time, :reference_URL, :is_active)
  end
end
