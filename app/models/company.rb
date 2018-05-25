class Company < ApplicationRecord
    has_many :users
    has_many :locations, dependent: :destroy
    has_many :external_locations,dependent: :destroy
    has_many :trainings, dependent: :destroy
    has_many :shifts, dependent: :destroy
end
