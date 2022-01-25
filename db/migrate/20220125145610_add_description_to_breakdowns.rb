class AddDescriptionToBreakdowns < ActiveRecord::Migration[6.1]
  def change
    add_column :breakdowns, :description, :string
  end
end
