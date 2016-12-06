class RepresentativeSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :state_id, :party, :cid, :state,
            :image_url, :gender, :congress_office, :image_url, :party_letter,
            :cash_spent, :cash_on_hand, :cash_debt, :cash_total, :contribution_information
end
