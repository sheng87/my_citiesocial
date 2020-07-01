class Vendor < ApplicationRecord
    validates :title,:description, presence: true
    acts_as_paranoid
end
