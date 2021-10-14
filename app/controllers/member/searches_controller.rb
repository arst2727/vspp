class Member::SearchesController < ApplicationController
  before_action :authenticate_member!
  def search
    # 楽曲追加申請用
    @musical_piece = MusicalPiece.new
    @model = params["model"]
    # 何も入力せずに検索ボタンを押した場合に対応
    return nil if params["content"] == ""
    # 入力された文字
    @content = params["content"]
    @start_year = params["start_year"]
    @end_year = params["end_year"]
    if (@start_year == nil && @end_year == nil )
      @records = search_for(@model, @content)
    elsif (@start_year != nil && @end_year != nil &&(@start_year <= @end_year) )
      records = search_for_second(@model, @start_year, @end_year)
      # return対策で入れていた文字列を一度空にする
      @content = nil
      # 検索結果キーワード用文字列を作る
      @content = @start_year+"-"+@end_year+"年"
      @records = records
    else
      @content = nil
      return nil
    end
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

  def search_for_second(model, start_year, end_year)
    if model == 'composers'
      Composer.where('year_of_birth BETWEEN ? AND ? OR year_of_death BETWEEN ? AND ?', start_year, end_year, start_year, end_year )
    elsif model == 'musical_pieces'
      MusicalPiece.where('year_of_composition BETWEEN ? AND ?', start_year, end_year)
    else
    end
  end
end
