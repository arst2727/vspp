class Member::SearchesController < ApplicationController
  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = search_for(@model, @content, @method)
  end

  private

  def search_for(model, content, method)
    if model == 'composers'
      if method == "forward_match"
        Composer.where('name_kana LIKE?', content+'%')
      elsif method == "backward_match"
        Composer.where('name_kana LIKE?', '%'+content)
      elsif method == "perfect_match"
        Composer.where(name_kana: content)
      elsif method == "partial_match"
        Composer.where('name_kana LIKE ?', '%'+content+'%')
      else

      end
    elsif model == 'musical_pieces'
      if method == "forward_match"
        MusicalPiece.where('musical_piece_name LIKE?', content+'%')
      elsif method == "backward_match"
        MusicalPiece.where('musical_piece_name LIKE?', '%'+content)
      elsif method == "perfect_match"
        MusicalPiece.where(musical_piece_name: content)
      elsif method == "partial_match"
        MusicalPiece.where('musical_piece_name LIKE ?', '%'+content+'%')
      else

      end
    end
  end
end
