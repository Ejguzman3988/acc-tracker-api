class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|
      t.string :goal
      t.text :blockers
      t.text :knowledge
      t.text :timing
      t.text :amount
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
