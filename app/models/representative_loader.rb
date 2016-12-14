require 'pp'
require 'net/http'
require 'json'
require 'nokogiri'

class RepresentativeLoader

  def self.populate
    representative_list
    populate_emails_website
  end

  def self.populate_cash
    cids.each do |cid|
      representative = Representative.find_by(cid: cid)
      if (representative.cash_total == nil || representative.contributors == nil) && (representative.cid != "N00030891") && (representative.cid != "N00028418")
        summary = open_secrets_summary(cid)
        contributors = open_secrets_contributors(cid)
        update_representative_cash(summary, contributors)
      end
    end
  end

  private

  def self.representative_list
    data = File.open("#{Rails.root}/public/loader/representatives.json")
    json_string = IO.read(data)
    hash_string = JSON.parse(json_string)

    hash_string.each do |id|

      list_hash = id

      representative = list_hash

      save_to_database(representative)
    end
  end



  # generates a list of all representative cids
  def self.cids
    Representative.all.map { |representative| representative.cid }
  end

  # populates emails using sunlight foundations (no api limit)
  def self.populate_emails_website
    Representative.all.each do |rep|
      sunlight_information = JSON.parse open('http://congress.api.sunlightfoundation.com/legislators?crp_id=' + rep.cid + '&apikey=' + sunglight_foundation_api_key).read
      rep.email = sunlight_information['results'][0]['oc_email']
      rep.website = sunlight_information['results'][0]['website']
      rep.save
    end
  end

  # saves information on representative cash
  def self.update_representative_cash(representative, contributors)
    record = Representative.find_by(cid: representative["cid"])
    record.cash_total = representative["total"]
    record.cash_on_hand = representative["cash_on_hand"]
    record.cash_spent = representative["spent"]
    record.cash_debt = representative["debt"]
    record.contributors = contributors
    record.save
  end

  # retrieves open secrets summary method for each candidaterat
  def self.open_secrets_summary(cid)
    begin
      open_secrets_content = OpenSecrets::Candidate.new(open_secrets_api_key)
      summary = open_secrets_content.summary({:cid => cid})
      unwrapped_summary = summary['response']['summary']
    rescue
      puts 'The Open Secrets API summary method has been exhausted for the day, try again tomorrow'
    end
  end

  # retrieves open secrets contributors method for each candidate
  def self.open_secrets_contributors(cid)
    begin
      open_secrets_content = OpenSecrets::Candidate.new(open_secrets_api_key)
      summary = open_secrets_content.contributors({:cid => cid})
      unwrapped_summary = summary['response']['contributors']
    rescue
      abort('The Open Secrets API contributors method has been exhausted for the day, try again tomorrow, exiting...')
    end
  end



  def self.sunlight_foundation_summary(cid)
    sunlight_foundation_content = open('http://congress.api.sunlightfoundation.com/legislators?crp_id=' + cid + '&apikey=' + sunglight_foundation_api_key + '
').read
    results = JSON.parse(sunlight_foundation_content)
    results['results'][0]
  end

  def self.image(bioguide_id)
    'https://theunitedstates.io/images/congress/450x550/' + bioguide_id + '.jpg'
  end

  def self.open_secrets_api_key
    'ad444fa84f3cf1fd936f4b2c4f768fc2'
  end

  def self.sunglight_foundation_api_key
    'ed97856623a54009a38c0b8c9a960a7a'
  end

  def self.save_state_representatives(state_representatives)
    state_representatives.each do |representative|
      puts representative
      save_to_database(representative)
    end
  end

  def self.save_to_database(representative)
    rep = Representative.new

    rep.first_name = representative['first_name']
    rep.last_name = representative["last_name"]
    rep.full_name = "#{rep.first_name} #{rep.last_name}"
    rep.cid = representative['opensecrets_id']
    rep.gender = representative['gender']
    rep.state_abbreviated = representative['state']
    rep.image_url = image(representative['bioguide_id'])
    rep.website = representative['website']
    rep.phone_number = representative['phone']
    rep.twitter_id = representative['twitter']
    rep.youtube_url = representative['youtube_id']
    rep.facebook_id = representative['facebook']
    rep.congress_office = representative['type']
    rep.party = representative['party']
    rep.birthdate = representative['birthday']
    state = State.find_by(abbreviated_name: rep.state_abbreviated)
    rep.state = state
    rep.save
  end

end
