class AddPhaseToBreakdowns < ActiveRecord::Migration[6.1]
  def change
    add_reference :breakdowns, :phase, foreign_key: true
  end
end
