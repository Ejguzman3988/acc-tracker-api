class AddBreakdownIdToMods < ActiveRecord::Migration[6.1]
  def change
    add_reference :mods, :breakdown, null: false, foreign_key: true
  end
end
