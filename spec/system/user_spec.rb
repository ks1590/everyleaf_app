require 'rails_helper'

RSpec.describe 'ユーザー登録、セッション機能のテスト', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @second_user = FactoryBot.create(:second_user)
  end

  describe 'ユーザー登録のテスト' do
    context 'ユーザーの新規登録した場合' do
      it '新規登録したユーザーのマイページが表示される' do
        visit new_user_path
        fill_in 'user_name', with:'sample_user'
        fill_in 'user_email', with:'sample@example.com'
        fill_in 'user_password', with:'123456'
        fill_in 'user_password_confirmation', with:'123456'
        click_on '新規作成'
        expect(page).to have_content 'sample_user'
        expect(page).not_to have_content 'test_user1'
        expect(page).to have_content 'sample@example.com'
      end
    end

    context 'ユーザーがログインせずにタスク一覧画面に飛んだ時' do
      it 'ログイン画面に遷移される' do
        visit tasks_path
        expect(current_path).to eq new_session_path
        expect(current_path).not_to eq tasks_path
        expect(page).to have_content 'ログインが必要です。'
      end
    end
  end

  describe 'セッション機能のテスト' do
    before do
      visit new_session_path
      fill_in 'session_email', with:'test1@example.com'
      fill_in 'session_password', with:'123456'
      click_on 'ログイン'
    end

    context 'ログインした場合' do
      it 'ログインしたユーザーのマイページが表示される' do
        expect(current_path).to eq user_path(@user.id)
        expect(page).to have_content 'test_user1'
        expect(page).to have_content 'test1@example.com'
        expect(current_path).not_to eq user_path(@second_user.id)
        expect(page).not_to have_content 'test_user2'
        expect(page).not_to have_content 'test2@example.com'
      end
    end

    context 'プロフィールをクリックした場合' do
      it '自分のマイページが表示される' do
        visit tasks_path
        click_on 'プロフィール'
        expect(current_path).to eq user_path(@user.id)
        expect(page).to have_content 'test_user1'
        expect(page).to have_content 'test1@example.com'
        expect(current_path).not_to eq user_path(@second_user.id)
        expect(page).not_to have_content 'test_user2'
        expect(page).not_to have_content 'test2@example.com'
      end
    end

    context '一般ユーザが他人の詳細画面に飛んだ場合' do
      it 'タスク一覧画面に遷移する' do
        visit user_path(@second_user.id)
        expect(current_path).to eq tasks_path
        expect(page).to have_content 'タイトル'        
        expect(current_path).not_to eq user_path(@second_user.id)
      end
    end

    context 'ログアウトした場合' do
      it 'ログイン画面に戻る' do
        click_on 'ログアウト'
        expect(current_path).to eq new_session_path
        expect(current_path).not_to eq user_path(@user.id)
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理画面のテスト' do
    before do
      visit new_session_path
      fill_in 'session_email', with:'test1@example.com'
      fill_in 'session_password', with:'123456'
      click_on 'ログイン'
    end

    context '管理ユーザーが管理画面にアクセスした場合' do
      it 'ユーザー一覧の画面に遷移する' do
        visit admin_users_path
        expect(current_path).to eq admin_users_path
        expect(current_path).not_to eq tasks_path
        expect(page).to have_content 'ユーザーリスト'
      end
    end

    context '一般ユーザーが管理画面にアクセスした場合' do
      it '管理画面にアクセスできない' do
        click_on 'ログアウト'
        visit new_session_path
        fill_in 'session_email', with:'test2@example.com'
        fill_in 'session_password', with:'123456'
        click_on 'ログイン'
        visit admin_users_path
        expect(current_path).not_to eq admin_users_path
        expect(current_path).to eq tasks_path
        expect(page).to have_content '権限が無いためアクセスできません'
      end
    end

    context '管理ユーザーがユーザーの新規登録した場合' do
      it '管理者用のユーザー詳細ページに遷移する' do
        visit new_admin_user_path
        fill_in 'user_name', with:'admin_test1'
        fill_in 'user_email', with:'admin_test@example.com'
        fill_in 'user_password', with:'123456'
        fill_in 'user_password_confirmation', with:'123456'
        uncheck 'user_admin'
        click_on '新規作成'
        expect(page).to have_content 'admin_test1'
        expect(page).to have_content 'admin_test@example.com'
        expect(page).not_to have_content 'test0'
        expect(page).to have_content '登録しました'
        expect(page).to have_content 'ユーザー管理権限'
      end
    end

    context '管理ユーザーがプロフィールをクリックした場合' do
      it '管理者用のユーザー詳細ページにアクセスできる' do
        test = FactoryBot.create(:user, name: "admin_test2", email: "admin_test2@example.com")
        visit admin_users_path
        click_on 'admin_test2'
        expect(current_path).to eq admin_user_path(test)
        expect(current_path).not_to eq user_path(test)
        expect(page).to have_content 'admin_test2さんのアカウント情報です'
        expect(page).to have_content '有'
      end
    end

    context '管理ユーザーがを管理者用アカウント編集画面にアクセスした場合' do
      it 'ユーザーの編集ができる' do
        visit edit_admin_user_path(@user)
        fill_in 'user_name', with:'edit_test'
        fill_in 'user_email', with:'edit_success@example.com'
        check 'user_admin'
        click_on '登録'
        expect(current_path).to eq admin_user_path(@user)
        expect(current_path).not_to eq user_path(@user)
        expect(page).to have_content 'edit_testさんのアカウント情報です'
        expect(page).to have_content 'edit_success@example.com'
        expect(page).to have_content '有'
        expect(page).to have_content '更新しました'
        expect(page).not_to have_content 'test2さんのアカウント情報です'
        expect(page).not_to have_content '無'
      end
    end

    context '管理ユーザーがユーザーの削除ボタンを押した場合' do
      it 'ユーザーの削除ができる' do
        visit admin_users_path
        all('tbody tr')[1].click_link '削除'
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq admin_users_path
        expect(all('tbody tr')[0]).to have_content "#{@user.name}"
        expect(all('tbody tr')[0]).to have_content "#{@user.email}"
        expect(all('tbody tr')[0]).not_to have_content "#{@second_user.name}"
        expect(all('tbody tr')[0]).not_to have_content "#{@second_user.email}"
        expect(page).to have_content "#{@second_user.name}さんのデータを削除しました"
      end
    end
  end
end
