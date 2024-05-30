# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    nickname { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6, mix_case: true, special_characters: false) }
    password_confirmation { password }
    first_name { "太郎" }
    last_name { "山田" }
    first_name_kana { "タロウ" }
    last_name_kana { "ヤマダ" }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
