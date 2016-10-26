class StateSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :abbreviated_name, :senate_stats, :congress_stats,
              :senators, :congresspersons, :representatives
end
