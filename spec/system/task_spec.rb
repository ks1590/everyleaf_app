require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task_title", with: 'テスト1'
        fill_in "task_detail", with: 'タスク詳細'
        fill_in "task_deadline", with: '002021/01/10'
        select "中", from: 'task_priority'
        select "完了", from: 'task_status'
        click_on "登録"
        expect(page).to have_content "テスト1"
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'テスト1'
        expect(page).to have_content 'テスト2'
        expect(page).to have_content 'テスト3'
      end
    end
  end
end