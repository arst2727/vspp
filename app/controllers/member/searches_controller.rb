class Member::SearchesController < ApplicationController
  def search
    @musical_piece = MusicalPiece.new
    return nil if params["content"] == ""
    @model = params["model"]
    @content = params["content"]
    @records = search_for(@model, @content)
    # インクリメンタル検索結果用文字列を用意
    if @model == 'musical_pieces'
      musical_piece_names = @records.map(&:musical_piece_name)
      respond_to do |format|
        format.html
        # ↓検索結果のデータをレスポンスするコード
        format.json { render json: musical_piece_names }
      end
    elsif @model == 'composers'
      composer_names = @records.map(&:name_kana)
      respond_to do |format|
        format.html
        # ↓検索結果のデータをレスポンスするコード
        format.json { render json: composer_names }
      end
    end
  end

  private

  def search_for(model, content)
    # 部分一致検索
    if model == 'composers'
      Composer.where('name_kana LIKE ? or name_lang_en LIKE?',
      '%' + content + '%', '%' + content + '%')
    elsif model == 'musical_pieces'
      MusicalPiece.where('musical_piece_name LIKE ?', '%' + content + '%')
    else
    end
  end
end
