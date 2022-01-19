class GoalSerializer < ActiveModel::Serializer
  attributes :id, :goal, :blockers, :knowledge, :timing, :amount
end
