class Member::ComposersController < ApplicationController
  before_action :authenticate_member!, except: [:index, :chronology]
  # 作曲家一覧
  def index
    @composers = Composer.all.order(name_kana: :asc).page(params[:page]).per(10)
  end

  # 作曲家詳細
  def show
    @composer = Composer.find(params[:id])
  end

  # 作曲家年表
  def chronology
    @composers = Composer.all.order(year_of_birth: :asc)
  end
end
