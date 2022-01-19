class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :goals, :start_date
end
