class AddDepartmentToLocation < ActiveRecord::Migration[5.1]
  def change
    add_reference :locations, :department, foreign_key: true
  end
end
