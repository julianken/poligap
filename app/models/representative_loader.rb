require 'pp'

class RepresentativeLoader

  def self.populate
    representative_list
  end

  private

  def self.representative_list
    puts 'representative_list start'
    states = State.state_abbreviations
    states.each do |state|
      member = OpenSecrets::Member.new(open_secrets_api_key)
      state_representatives = member.get_legislators({:id => state})["response"]["legislator"]
      save_state_representatives(state_representatives)
    end
  end

  def self.open_secrets_summary(cid)
    puts 'open_secrets_summary start'
    open_secrets_content = OpenSecrets::Candidate.new(open_secrets_api_key)
    puts 'new candidate instantiated'
    puts cid
    unwrapped_summary = open_secrets_content.summary({:cid => cid})["response"]
    puts 'unwrapped_summary completed'
    pp unwrapped_summary
    unwrapped_summary['summary']
  end

  def self.sunlight_foundation_summary(cid)
    puts 'sunlight_foundation_summary start'

    sunlight_foundation_content = open('http://congress.api.sunlightfoundation.com/legislators?crp_id=' + cid + '&apikey=' + sunglight_foundation_api_key + '
').read
    results = JSON.parse(sunlight_foundation_content)
    results['results'][0]
  end

  def self.image(bioguide_id)
    puts 'image start'
    'https://theunitedstates.io/images/congress/450x550/' + bioguide_id + '.jpg'
  end

  def self.open_secrets_api_key
    puts 'open_secrets_api_key_start'
    'ad444fa84f3cf1fd936f4b2c4f768fc2'
  end

  def self.sunglight_foundation_api_key
    puts 'sunglight_foundation_api_key start'
    'ed97856623a54009a38c0b8c9a960a7a'
  end

  def self.save_state_representatives(state_representatives)
    state_representatives.each do |representative|
      puts representative
      save_to_database(representative)
    end
  end

  def self.save_to_database(representative)
    puts 'save_to_database start'
    sunlight = sunlight_foundation_summary(representative['cid'])
    opensecrets = open_secrets_summary(representative['cid'])

    pp sunlight
    pp opensecrets
    pp representative
    rep = Representative.new
    rep.full_name = opensecrets['firstlast']
    nameArray = representative['firstlast'].split
    rep.first_name = nameArray[0]
    rep.last_name = nameArray.last
    rep.cid = representative['cid']
    rep.state_abbreviated = sunlight['state']
    rep.image_url = image(sunlight['bioguide_id'])
    rep.gender =  representative['gender']
    rep.website = representative['website']
    rep.phone_number = representative['phone']
    rep.fax_number = representative['fax']
    rep.twitter_id = representative['twitter_id']
    rep.youtube_url = representative['youtube_url']
    rep.facebook_id = representative['facebook_id']
    rep.congress_office = representative['congress_office']
    rep.party = representative['party']
    rep.birthdate = representative['birthdate']
    rep.webform = representative['webform']

    puts rep.state_full
    state = State.find_by(abbreviated_name: rep.state_abbreviated)
    rep.state = state
    rep.save
  end

end
