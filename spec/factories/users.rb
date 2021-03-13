FactoryBot.define do
  factory :user do
    gimei = Gimei.name
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password {'1a' + Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    fristname {gimei.first.kanji}
    lastname {gimei.last.kanji}
    fristname_kana {gimei.first.katakana}
    lastname_kana {gimei.last.katakana}
    birth_date {Faker::Date.in_date_period}
  end
end
