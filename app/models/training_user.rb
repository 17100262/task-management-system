class TrainingUser < ApplicationRecord
    enum training_type: [:mandatory, :role_specific,:other]
    belongs_to :user
    belongs_to :training
end
