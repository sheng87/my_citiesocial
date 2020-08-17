require 'faker'
FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    list_price { Faker::Number.between(from:10, to: 50) }
    sell_price { Faker::Number.between(from:1, to: 50) }
    on_sale { false }
    vendor
    category

    trait :with_skus do
      tansient do 
        amount { 2 }
      end
      
        skus { build_list :sku, amount }
    end
  end
end
