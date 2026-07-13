class MoveAssetHoldersToAssignments < ActiveRecord::Migration[7.2]
  def up
    execute <<~SQL
      INSERT INTO asset_assignments
        (asset_id, employe_id, checked_out_at, checked_in_at, created_at, updated_at)
      SELECT id, employe_id, created_at, NULL, NOW(), NOW()
      FROM assets
      WHERE employe_id IS NOT NULL
    SQL

    remove_column :assets, :employe_id
  end

  def down
    add_column :assets, :employe_id, :integer

    execute <<~SQL
      UPDATE assets SET employe_id = (
        SELECT employe_id FROM asset_assignments
        WHERE asset_assignments.asset_id = assets.id
          AND asset_assignments.checked_in_at IS NULL
        LIMIT 1
      )
    SQL
  end
end
