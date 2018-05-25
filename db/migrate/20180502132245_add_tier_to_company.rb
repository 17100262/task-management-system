class AddTierToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :tier, :integer,default: 5
  end
end
