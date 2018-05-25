class Training < ApplicationRecord
    enum training_type: [:mandatory, :role_specific,:other]
    # has_many :user_trainings, dependent: :destroy
    has_and_belongs_to_many :users
    belongs_to :company
end
