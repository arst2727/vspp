class Admin::MusicalPiecesController < ApplicationController
  before_action :authenticate_admin!

  # 楽曲一覧
  def index
    @musical_pieces = MusicalPiece.all
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

  # 楽曲編集
  def edit
    @musical_piece = MusicalPiece.find(params[:id])
  end

  # 楽曲データ更新
  def update
    @musical_piece = MusicalPiece.find(params[:id])
    if @musical_piece.update(musical_piece_params)
      redirect_to admin_musical_pieces_path, notice: "You have updated musical_piece successfully."
    else
      render "index"
    end
  end

  def destroy
    musical_piece = MusicalPiece.find(params[:id])
    musical_piece.destroy
    redirect_to admin_musical_pieces_path
  end

  private

  def musical_piece_params
    params.require(:musical_piece).permit(:composer_id, :musical_piece_name, :year_of_composition, :performance_time, :reference_URL, :is_active)
  end
end
