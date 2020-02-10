require 'rails_helper'

describe 'ユーザー認証のテスト' do
  describe 'ユーザー新規登録' do
    before do
      visit new_user_registration_path
    end
    context '新規登録画面に遷移' do
      it '新規登録に成功する' do
        fill_in 'user[name]', with: Faker::Internet.username(specifier: 5)
        fill_in 'user[name_kana]', with: 'カタカナ'
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '新規登録する'

        expect(current_path).to eq(root_path)
      end
      it '新規登録に失敗する' do
        fill_in 'user[name]', with: ''
        fill_in 'user[name_kana]', with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button '新規登録する'

        expect(page).to have_content 'error'
      end
    end
  end
  describe 'ユーザーログイン' do
    let(:user) { User.create(name: '田中',name_kana: 'タナカ', email: 'tanaka@gmail.com', password: 'password') }
    before do
      visit new_user_session_path
    end
    context 'ログイン画面に遷移' do
      let(:test_user) { user }
      it 'ログインに成功する' do
        fill_in 'user[email]', with: test_user.email
        fill_in 'user[password]', with: test_user.password
        click_button 'ログインする'

        expect(current_path).to eq(root_path)
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログインする'

        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end

describe 'ユーザーのテスト' do
  let(:user) { User.create(name: '田中',name_kana: 'タナカ', email: 'tanaka@gmail.com', password: 'password') }
  let!(:user2) { User.create(name: '佐藤',name_kana: 'サトウ', email: 'sato@gmail.com', password: 'password2') }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログインする'
  end
  describe '編集関連のテスト' do
    context '表示の確認' do
      it 'マイページの場合は編集リンクが表示される' do
        visit user_path(user)
        expect(page).to have_link '', href: edit_user_path(user)
      end
      it '他人のページの場合は編集リンクが表示されない' do
        visit user_path(user2)
        expect(page).to have_no_link '', href: edit_user_path(user)
      end
      it '自分の編集画面に遷移できる' do
        visit edit_user_path(user)
        expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
      end
      it '他人の編集画面には遷移できない' do
        visit edit_user_path(user2)
        expect(current_path).to eq(root_path)
      end
      it '編集に成功する' do
        visit edit_user_path(user)
        click_button '変更を保存する'
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
      it '名前が空欄の場合、編集に失敗する' do
        visit edit_user_path(user)
        fill_in 'user[name]', with: ''
        click_button '変更を保存する'
        expect(page).to have_content 'エラー'
      end
    end
  end
end
