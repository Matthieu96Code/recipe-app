FactoryBot.define do
  factory :recipe do
    name { 'MyString' }
    preparation_time { 1 }
    cooking_time { 1 }
    description { 'MyString' }
    public { false }
    user { nil }
  end
end
