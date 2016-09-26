class RepresentativeSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :state_id, :party, :cid
end
