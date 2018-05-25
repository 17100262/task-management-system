class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts do |t|
      # t.date :shift_date
      t.datetime :start_time
      t.integer :shift_status
      t.text :skills_required
      t.references :external_location, foreign_key: true

      t.timestamps
    end
  end
end
