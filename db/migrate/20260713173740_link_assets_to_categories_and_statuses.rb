class LinkAssetsToCategoriesAndStatuses < ActiveRecord::Migration[7.2]
  def up
    execute <<~SQL
      INSERT INTO categories (name, created_at, updated_at)
      SELECT DISTINCT category, NOW(), NOW()
      FROM assets
      WHERE category IS NOT NULL AND category <> ''
      ON CONFLICT (name) DO NOTHING
    SQL

    execute <<~SQL
      INSERT INTO statuses (name, color, created_at, updated_at)
      SELECT DISTINCT status,
             CASE LOWER(status)
               WHEN 'available'   THEN 'green'
               WHEN 'deployed'    THEN 'blue'
               WHEN 'maintenance' THEN 'amber'
               WHEN 'archived'    THEN 'gray'
               ELSE 'gray'
             END,
             NOW(), NOW()
      FROM assets
      WHERE status IS NOT NULL AND status <> ''
      ON CONFLICT (name) DO NOTHING
    SQL

    execute <<~SQL
      INSERT INTO statuses (name, color, created_at, updated_at)
      VALUES ('Available', 'green', NOW(), NOW()),
             ('Deployed', 'blue', NOW(), NOW()),
             ('Maintenance', 'amber', NOW(), NOW()),
             ('Archived', 'gray', NOW(), NOW())
      ON CONFLICT (name) DO NOTHING
    SQL

    add_reference :assets, :category, foreign_key: true
    add_reference :assets, :status, foreign_key: true

    execute <<~SQL
      UPDATE assets
      SET category_id = (SELECT id FROM categories WHERE categories.name = assets.category),
          status_id   = (SELECT id FROM statuses   WHERE statuses.name   = assets.status)
    SQL

    remove_column :assets, :category
    remove_column :assets, :status
  end

  def down
    add_column :assets, :category, :string
    add_column :assets, :status, :string

    execute <<~SQL
      UPDATE assets
      SET category = (SELECT name FROM categories WHERE categories.id = assets.category_id),
          status   = (SELECT name FROM statuses   WHERE statuses.id   = assets.status_id)
    SQL

    remove_reference :assets, :category
    remove_reference :assets, :status
  end
end
