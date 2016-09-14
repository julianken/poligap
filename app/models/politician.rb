require 'pp'

class Politician

  attr_accessor :first_name, :last_name

  def initialize(cid)
    @cid = cid
    summary = self.summary
    nameArray = summary['cand_name'].split
    @first_name = nameArray[1]
    @last_name = nameArray[0].chomp(',')
  end

  protected

  def summary
    cand = OpenSecrets::Candidate.new(api_key)
    unwrapped_summary = pp cand.summary({:cid => @cid})["response"]
    unwrapped_summary['summary']
  end

  private

  def api_key
   'ad444fa84f3cf1fd936f4b2c4f768fc2'
  end

end
