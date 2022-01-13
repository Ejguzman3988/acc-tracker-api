class CreateBreakdowns < ActiveRecord::Migration[6.1]
  def change
    create_table :breakdowns do |t|
      t.integer :week_range

      t.timestamps
    end
  end
end
