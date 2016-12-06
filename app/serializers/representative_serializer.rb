class RepresentativeSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :state_id, :party, :cid, :state,
            :image_url, :gender, :congress_office, :image_url, :party_letter,
            :twitter_id, :phone_number, :youtube_url, :facebook_id, :website,
            :cash_spent, :cash_on_hand, :cash_debt, :cash_total,
            :contribution_information
end
