class AddCompanyIdToTraining < ActiveRecord::Migration[5.1]
  def change
    add_reference :trainings, :company, foreign_key: true
  end
end
