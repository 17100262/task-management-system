class Company < ApplicationRecord
    has_many :users
    has_many :locations, dependent: :destroy
end
