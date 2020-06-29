class Vendor < ApplicationRecord
    validates :title,:description, presence: true
end
