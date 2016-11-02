class Representative < ApplicationRecord
  belongs_to :state

  attr_reader :party_letter

  def party_letter
    party[0,1]
  end
end
