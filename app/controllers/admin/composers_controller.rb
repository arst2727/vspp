class Admin::ComposersController < ApplicationController
  before_action :authenticate_admin!

  # 作曲家一覧
  def index
    @composers = Composer.all
  end

  # 楽曲新規作成
  def new
    @composer = Composer.new
  end

  # 楽曲登録処理
  def create
    @composer = Composer.new(composer_params)
    if @composer.save
      @composers = Composer.all
      render 'index'
    else
      render 'new'
    end
  end

  # 作曲家データ編集
  def edit
    @composer = Composer.find(params[:id])
  end

  # 作曲家データ更新
  def update
    @composer = Composer.find(params[:id])
    if @composer.update(composer_params)
      redirect_to admin_composers_path, notice: "作曲家の情報を更新しました"
    else
      flash[:alert] = "作曲家データを更新できませんでした"
      render "edit"
    end
  end

  def destroy
    composer = Composer.find(params[:id])
    composer.destroy
    redirect_to admin_composers_path
  end

  private

  def composer_params
    params.require(:composer).permit(:name_kana, :name_lang_en, :image, :year_of_birth,
                                      :year_of_death, :reference_url, :is_active)
  end
end
