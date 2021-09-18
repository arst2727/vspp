class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @musical_pieces = MusicalPiece.where(is_active: false)
  end
end
