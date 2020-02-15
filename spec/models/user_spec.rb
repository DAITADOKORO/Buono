require 'rails_helper'

RSpec.describe User do

  describe 'バリデーションのテスト' do
    context 'nameカラム' do
      it '空欄でないこと' do
        user = User.new(name: '', name_kana: 'カタカナ', email: 'email@gmail.com',password: 'password')
        user.save
        expect(user.valid?).to eq false
      end
    end

    context 'name_kanaカラム' do
      it '空欄でないこと' do
        user = User.new(name: 'テスト', name_kana: '', email: 'email@gmail.com',password: 'password')
        user.save
        expect(user.valid?).to eq false
      end
      it 'カナ入力であること' do
        user = User.new(name: '片仮名', name_kana: 'カタカナ', email: 'email@gmail.com',password: 'password')
        user.save
        expect(user.valid?).to eq true
      end
      it 'かな入力はできないこと' do
        user = User.new(name: '平仮名', name_kana: 'ひらがな', email: 'email@gmail.com',password: 'password')
        user.save
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