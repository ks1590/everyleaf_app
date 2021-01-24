FactoryBot.define do
  factory :task do
    title { 'テスト1' }
    detail { 'test_task1' }
    deadline { '002021/02/01' }
    priority { '中' }
    status { '完了' }
    user
  end

  factory :second_task, class: Task do
    title { 'テスト2' }
    detail { 'test_task2' }
    deadline { '002021/02/10' }
    priority { '高' }
    status { '未着手' }
    user
  end

  factory :third_task, class: Task do
    title { 'テスト3' }
    detail { 'test_task3' }
    deadline { '002021/02/20' }
    priority { '低' } 
    status { '着手中' }
    user
  end
end