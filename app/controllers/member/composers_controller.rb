class Member::ComposersController < ApplicationController
  before_action :authenticate_member!,except: [:index]
  # 作曲家一覧
  def index
    @composers = Composer.all.page(params[:page]).per(15)
  end

  # 作曲家詳細
  def show
    @composer = Composer.find(params[:id])
  end
end
