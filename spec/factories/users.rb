FactoryBot.define do 
  factory :user do
    name { "test_user1" }
    email { "test1@example.com" }
    password { "123456" }
    password_confirmation { "123456" }
    admin { true }
  end

  factory :second_user, class: User do
    name { "test_user2" }
    email { "test2@example.com" }
    password { "123456" }
    password_confirmation { "123456" }
    admin { false }
  end
end