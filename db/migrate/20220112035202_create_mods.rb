class CreateMods < ActiveRecord::Migration[6.1]
  def change
    create_table :mods do |t|
      t.string :title
      t.integer :amount
      t.boolean :optional, default: false
      t.belongs_to :phase, null: false, foreign_key: true

      t.timestamps
    end
  end
end
