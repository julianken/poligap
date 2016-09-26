class StateSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :abbreviated_name
end
