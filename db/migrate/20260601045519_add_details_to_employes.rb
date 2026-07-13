class AddDetailsToEmployes < ActiveRecord::Migration[7.2]
  def change
    add_column :employes, :employeName, :string
    add_column :employes, :title, :string
    add_column :employes, :departement, :string
    add_column :employes, :office, :string
  end
end
