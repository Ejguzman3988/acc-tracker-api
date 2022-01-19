class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :goals
end
