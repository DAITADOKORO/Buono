require 'rails_helper'

RSpec.describe 'Wantモデルのテスト', type: :model do

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it '1:Nとなっている' do
        expect(Want.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Restaurantモデルとの関係' do
      it '1:Nとなっている' do
        expect(Want.reflect_on_association(:restaurant).macro).to eq :belongs_to
      end
    end
  end
end