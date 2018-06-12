class AddAttributeToShiftUser < ActiveRecord::Migration[5.1]
  def change
    add_column :shift_users, :confirmed_by_manager, :boolean, default: false
  end
end
