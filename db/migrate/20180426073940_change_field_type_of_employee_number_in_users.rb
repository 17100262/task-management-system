class ChangeFieldTypeOfEmployeeNumberInUsers < ActiveRecord::Migration[5.1]
  def change
    change_column(:users, :employee_number, :string)
  end
end
