class CreateTrainingUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :training_users do |t|
      t.references :training
      t.references :user
      t.date :date_of_completion
      t.integer :duration
      t.date :training_expiry
      t.integer :training_type
      t.string :training_provider

      t.timestamps
    end
  end
end
