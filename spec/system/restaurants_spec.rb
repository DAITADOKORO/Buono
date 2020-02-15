require 'rails_helper'

describe 'レストラン関連のテスト' do
  let(:restaurant) { Restaurant.create(name: "らーめん はやし",shop_id: 'gfrg400', image:"https://uds.gnst.jp/rest/img/hrexkrjs0000/t_0n5e.jpg", prefecture: '東京都', area:'AREAS2126') }
  let(:user) { User.create(name: '田中',name_kana: 'タナカ', email: 'tanaka@gmail.com', password: 'password') }
  let(:rest_comment) {RestComment.create(comment: 'テストコメント')}
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログインする'

    visit restaurant_path(restaurant.shop_id)
  end
  describe 'コメントのテスト' do
    context 'コメントのバリデーション' do
      it '投稿に成功する' do
        fill_in 'rest_comment[comment]', with: rest_comment.comment
        click_button '送信する'
        expect(current_path).to eq('/restaurants/' + restaurant.id.to_s + '/rest_comments')
      end

      it '空欄では投稿できない' do
        fill_in 'rest_comment[comment]', with: ''
        click_button '送信する'
        expect(page).to have_content 'コメントで応援しよう！'
      end

      it '501文字以上では投稿できない' do
        fill_in 'rest_comment[comment]', with: '５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。５０１文字のコメントを打ち込んでいます。'
        click_button '送信する'
        expect(page).to have_content 'コメントで応援しよう！'
      end
    end
  end
end