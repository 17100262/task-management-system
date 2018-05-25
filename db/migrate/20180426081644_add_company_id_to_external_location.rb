class AddCompanyIdToExternalLocation < ActiveRecord::Migration[5.1]
  def change
    add_reference :external_locations, :company, foreign_key: true
  end
end
