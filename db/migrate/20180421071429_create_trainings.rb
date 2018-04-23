class CreateTrainings < ActiveRecord::Migration[5.1]
  def change
    create_table :trainings do |t|
      t.string :name
      t.date :date_of_completion
      t.integer :duration
      t.date :training_expiry
      t.integer :training_type
      t.string :training_provider

      t.timestamps
    end
  end
end
