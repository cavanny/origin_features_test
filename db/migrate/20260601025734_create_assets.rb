class CreateAssets < ActiveRecord::Migration[7.2]
  def change
    create_table :assets do |t|
      t.string :name
      t.string :serial
      t.string :category
      t.string :status
      t.string :checkedOutTo
      t.float :purchaseCost

      t.timestamps
    end
  end
end
