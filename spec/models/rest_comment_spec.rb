require 'rails_helper'

RSpec.describe 'RestCommentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    context 'nameカラム' do
      it '空欄でないこと' do
        comment = RestComment.new(comment: '')
        commens.save
        expect(comment.valid?).to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it '1:Nとなっている' do
        expect(RestComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Restaurantモデルとの関係' do
      it '1:Nとなっている' do
        expect(RestComment.reflect_on_association(:restaurant).macro).to eq :belongs_to
      end
    end
  end
end