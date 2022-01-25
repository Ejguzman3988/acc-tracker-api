class AddTotalAssignmentsToBreakdowns < ActiveRecord::Migration[6.1]
  def change
    add_column :breakdowns, :total_assignments, :string
  end
end
