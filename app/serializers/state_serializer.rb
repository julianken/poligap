class StateSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :state_description, :abbreviated_name, :senate_stats,
              :congress_stats
end
