require "uri"
require "net/http"
require "nokogiri"

class RepresentativeList

  def self.populate
    data = File.open("#{Rails.root}/public/loader/representatives.json")
    json_string = IO.read(data)
    hash_string = JSON.parse(json_string)

    hash_string.each do |id|
      cid = pp id["opensecrets_id"]
      url = URI.parse("http://www.opensecrets.org/api/?method=candSummary&cid=#{cid}&apikey=#{open_secretes_api_key}")
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      puts res.body
      list_hash = Hash.from_xml(res.body)
      representative = list_hash["response"]["summary"]

      rep = Representative.new
      puts "before"
      rep.cid = representative["cid"]
      state = State.where(abbreviated_name: representative["state"])
      state = state[0]
      rep.state_id = state.id
      rep.full_nam
      rep.chamber =
      puts "after"
    end
  end

  def self.open_secretes_api_key
    "ad444fa84f3cf1fd936f4b2c4f768fc2"
  end

end
