require 'rails_helper'

RSpec.describe User do

  describe 'バリデーションのテスト' do
    context 'nameカラム' do
      it '空欄でないこと' do
        user = User.new(name: '')
        expect(user.valid?).to eq false
      end
    end

    context 'name_kanaカラム' do
      it '空欄でないこと' do
        user = User.new(name_kana: '')
        expect(user.valid?).to eq false
      end
      it 'カナ入力であること' do
        user = User.new(name_kana: 'カタカナ')
        expect(user.valid?).to eq true
      end
      it 'かな入力はできないこと' do
        user = User.new(name_kana: 'ひらがな')
        expect(user.valid?).to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Wantモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:wants).macro).to eq :has_many
      end
    end
    context 'Repeatモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:repeats).macro).to eq :has_many
      end
    end
    context 'RestCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:rest_comments).macro).to eq :has_many
      end
    end
  end
end
# アソシエーションのテスト