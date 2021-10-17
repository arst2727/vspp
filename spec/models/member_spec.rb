require 'rails_helper'

RSpec.describe Member, type: :model do
    # before 
    describe 'メンバー登録' do
      it "email、nickname、passwordとpassword_confirmationが存在すれば登録できること" do
        member = build(:member)
        expect(member).to be_valid  # member.valid? が true になればパスする
      end
    end
end