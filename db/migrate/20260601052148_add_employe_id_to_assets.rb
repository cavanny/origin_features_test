class AddEmployeIdToAssets < ActiveRecord::Migration[7.2]
  def change
    add_column :assets, :employe_id, :integer
  end
end
