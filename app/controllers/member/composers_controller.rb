class Member::ComposersController < ApplicationController
  # 作曲家一覧
  def index
    @composers = Composer.all
  end

  # 作曲家詳細
  def show
    @composer = Composer.find(params[:id])
    @musical_pieces = @composer.id
  end
end
