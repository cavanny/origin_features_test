class CreateAssetAssignments < ActiveRecord::Migration[7.2]
  def change
    create_table :asset_assignments do |t|
      t.references :asset, null: false, foreign_key: true
      t.references :employe, null: false, foreign_key: true
      t.datetime :checked_out_at, null: false
      t.datetime :checked_in_at
      t.text :notes

      t.timestamps
    end

    add_index :asset_assignments, :asset_id,
              unique: true,
              where: "checked_in_at IS NULL",
              name: "index_asset_assignments_on_one_active_per_asset"
  end
end
