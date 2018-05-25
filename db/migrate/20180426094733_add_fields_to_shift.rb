class AddFieldsToShift < ActiveRecord::Migration[5.1]
  def change
    add_column :shifts, :end_time, :datetime
    # add_column :shifts, :end_time, :time
  end
end
