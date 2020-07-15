class Vendor < ApplicationRecord
    validates :title,:description, presence: true
    acts_as_paranoid


    scope :available, -> {where(online: true)}
end
