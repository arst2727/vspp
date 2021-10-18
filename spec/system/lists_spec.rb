# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'リストのテスト', type: :system do
  # let(:list) { FactoryBot.create(:list) }
  # 事前にログイン処理
  before do
    @member = FactoryBot.create(:member)
    @list = FactoryBot.create(:list)
    sign_in @member
  end

  describe 'リスト画面(lists_path)のテスト' do
    before do
      visit lists_path
    end

    context '表示の確認' do
      it 'リスト画面(lists_path)に「マイリスト」が表示されているか' do
        expect(page).to have_content 'マイリスト'
      end
      it 'lists_pathが"/lists"であるか' do
        expect(current_path).to eq('/lists')
      end
    end
  end

  describe "リスト作成画面(new_list_path)のテスト" do
    before do
      visit new_list_path
    end

    context '表示の確認' do
      it 'new_list_path"/lists/new"であるか' do
        expect(current_path).to eq('/lists/new')
      end
      it '新規追加ボタンが表示されているか' do
        expect(page).to have_button '新規追加'
      end
    end

    context '追加処理のテスト' do
      it '追加後のリダイレクト先は正しいか' do
        fill_in 'list[name]', with: Faker::Lorem.characters(number: 10)
        click_button '新規追加'
        list_last = List.last
        expect(page).to have_current_path lists_path
        expect(page).to have_content list_last.name
        expect(page).to have_link list_last.name
      end
    end
  end

  describe "マイリスト一覧のテスト" do
    before do
      visit lists_path
    end

    context '表示の確認' do
      it '追加されたものが表示されているか' do
        expect(page).to have_content @list.name
        expect(page).to have_link @list.name
      end
      it '削除リンクが存在しているか' do
        expect(page).to have_link '削除'
      end
    end

    context 'list削除のテスト' do
      it 'listの削除' do
        expect { @list.destroy }.to change { List.count }.by(-1)
      end
    end
  end

  describe "リスト詳細画面のテスト" do
    before do
      visit list_path(@list)
    end

    context '表示の確認' do
      it '戻るリンクが存在しているか' do
        expect(page).to have_link 'マイリストに戻る'
      end
    end
  end

  describe '編集画面のテスト' do
    before do
      visit edit_list_path(@list)
    end

    context '表示の確認' do
      it '編集前のリスト名がフォームに表示(セット)されている' do
        expect(page).to have_field 'list[name]', with: @list.name
      end
      it '編集を保存ボタンが表示される' do
        expect(page).to have_button '編集を保存'
      end
    end

    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'list[name]', with: Faker::Lorem.characters(number: 10)
        click_button '編集を保存'
        expect(page).to have_current_path lists_path
      end
    end
  end
end
