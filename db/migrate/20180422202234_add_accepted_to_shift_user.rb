class AddAcceptedToShiftUser < ActiveRecord::Migration[5.1]
  def change
    add_column :shift_users, :accepted, :boolean,default: false
  end
end
