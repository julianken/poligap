class RepresentativeSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :state_id, :party, :cid, :image_url, :gender,
            :congress_office, :image_url, :party_letter
end
