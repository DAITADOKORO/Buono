require 'rails_helper'

RSpec.describe 'Restaurantモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:) { create(:user) }
    let!(:book) { build(:book, user_id: user.id) }

  end
  describe 'アソシエーションのテスト' do
    context 'Wantモデルとの関係' do
      it 'N:1となっている' do
        expect(Book.reflect_on_association(:wants).macro).to eq :has_many
      end
    end
    context 'Repeatモデルとの関係' do
      it 'N:1となっている' do
        expect(Book.reflect_on_association(:repeats).macro).to eq :has_many
      end
    end
    context 'RestCommentモデルとの関係' do
      it 'N:1となっている' do
        expect(Book.reflect_on_association(:rest_comments).macro).to eq :has_many
      end
    end
  end
end