class AddMangerIdToShift < ActiveRecord::Migration[5.1]
  def change
    add_column :shifts, :manager_id, :integer
    add_reference :shifts, :company, foreign_key: true
  end
end
