class CreateExternalLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :external_locations do |t|
      t.string :name
      t.text :address
      t.string :description

      t.timestamps
    end
  end
end
