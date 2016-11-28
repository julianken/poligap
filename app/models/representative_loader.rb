require 'pp'
require 'net/http'
require 'json'
require 'nokogiri'

class RepresentativeLoader

  def self.populate
    representative_list
  end

  def self.populate_cash
    cids.each do |cid|
      if Representative.find_by(cid: cid).cash_total == nil
        summary = open_secrets_summary(cid)
        update_representative_cash(summary)
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
      repepresentative = list_hash["opensecrets_id"]

      save_to_database(representative)
    end
  end

  def self.cids
    Representative.all.map { |representative| representative.cid }
  end

  def self.update_representative_cash(representative)
    record = Representative.find_by(cid: representative["cid"])
    record.cash_total = representative["total"]
    record.cash_on_hand = representative["cash_on_hand"]
    record.cash_spent = representative["spent"]
    record.cash_debt = representative["debt"]
    record.save
  end

  def self.open_secrets_summary(cid)
    open_secrets_content = OpenSecrets::Candidate.new(open_secrets_api_key)
    unwrapped_summary = open_secrets_content.summary({:cid => cid})["response"]
    pp unwrapped_summary['summary']
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
