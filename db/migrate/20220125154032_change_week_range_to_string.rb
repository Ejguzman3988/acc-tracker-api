class ChangeWeekRangeToString < ActiveRecord::Migration[6.1]
  def change
    change_column :breakdowns, :week_range, :string
  end
end
