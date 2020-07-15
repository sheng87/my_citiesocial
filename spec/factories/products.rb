FactoryBot.define do
  factory :product do
    name { "MyString" }
    vendor { nil }
    list_price { "9.99" }
    sell_price { "9.99" }
    on_sale { false }
    code { "MyString" }
    deleted_at { "2020-07-01 22:57:43" }
  end
end
