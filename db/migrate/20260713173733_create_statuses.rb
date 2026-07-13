class CreateStatuses < ActiveRecord::Migration[7.2]
  def change
    create_table :statuses do |t|
      t.string :name, null: false
      t.string :color, null: false, default: "gray"

      t.timestamps
    end

    add_index :statuses, :name, unique: true
  end
end
