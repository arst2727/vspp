class Member::MusicalPiecesController < ApplicationController
  before_action :authenticate_member!, except: [:index]

  # 楽曲一覧
  def index
    @musical_pieces = MusicalPiece.all.order(musical_piece_name: :asc).page(params[:page]).per(10)
    @musical_piece = MusicalPiece.new
  end

  # 楽曲詳細
  def show
    @musical_piece = MusicalPiece.find(params[:id])

    @musical_piece_comments = @musical_piece.musical_piece_comments
    @musical_piece_comment = MusicalPieceComment.new

    @musical_piece_list = MusicalPieceList.new
  end

  # 楽曲登録処理
  def create
    @musical_piece = MusicalPiece.new(musical_piece_params)
    if @musical_piece.save
      @musical_pieces = MusicalPiece.all.page(params[:page]).per(10)
      flash[:success] = '楽曲の追加申請が完了しました。反映までお待ち下さい。'
      render 'index'
    else
      @musical_pieces = nil
      render 'index'
    end
  end

  private

  def musical_piece_params
    params.require(:musical_piece).permit(:composer_id, :musical_piece_name, :year_of_composition,
                                    :performance_time, :reference_URL, :is_active)
  end
end
