class CreateEmployes < ActiveRecord::Migration[7.2]
  def change
    create_table :employes do |t|
      t.timestamps
    end
  end
end
