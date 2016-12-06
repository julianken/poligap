class Representative < ApplicationRecord
  belongs_to :state

  attr_reader :party_letter, :contribution_information

  def party_letter
    party[0,1]
  end

  def contribution_information
    if contributors != nil
      JSON.parse(contributors.gsub('=>', ':'))
    else
      {}
    end
  end

  def chamber
    if congress_office == 'sen'
      'Senate'
    else
      'House of Representatives'
    end
  end

  def prefix
    if congress_office == 'sen'
      'Senator'
    else
      'Representative'
    end
  end
end
