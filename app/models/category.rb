class Category < ApplicationRecord
    acts_as_paranoid
    acts_as_list

    validates :name, presence: true
    default_scope { order(position: :asc) }
    has_many :products
end
