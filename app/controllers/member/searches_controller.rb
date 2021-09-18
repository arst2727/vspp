class Member::SearchesController < ApplicationController
  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = search_for(@model, @content, @method)
    # 追加
    @musical_piece = MusicalPiece.new
  end

  private

  def search_for(model, content, method)
    if model == 'composers'
      if method == "forward_match"
        Composer.where('name_kana LIKE? or name_lang_en LIKE?', content+'%', content+'%')
      elsif method == "backward_match"
        Composer.where('name_kana LIKE? or name_lang_en LIKE?', '%'+content, '%'+content)
      elsif method == "perfect_match"
        Composer.where('name_kana = ? or name_lang_en = ?', content, content)
      elsif method == "partial_match"
        Composer.where('name_kana LIKE ? or name_lang_en LIKE?', '%'+content+'%', '%'+content+'%')
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
