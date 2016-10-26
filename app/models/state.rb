class State < ApplicationRecord
  has_many :representatives

  attr_reader :summary, :party_count, :senators

    def to_param
      state
    end

    def senators
      senators = []
      representatives.each do |representative|
        if representative.congress_office === "sen"
          senators.push(representative)
        end
      end
      senators
    end

    def congresspersons
      congresspersons = []
      representatives.each do |representative|
        if representative.congress_office === "rep"
          congresspersons.push(representative)
        end
      end
      congresspersons
    end

    def senate_stats
      party_counter = {
        'democrat' => 0,
        'republican' => 0,
        'other' => 0
      }
      gender_counter = {
        'male' => 0,
        'female' => 0
      }
      self.senators.each do |senator|
        if senator.party == 'Democrat'
          party_counter["democrat"] += 1
        elsif senator.party == 'Republican'
          party_counter["republican"] += 1
        else
          party_counter["other"] += 1
        end
        if senator.gender == 'M'
          gender_counter['male'] += 1
        elsif senator.gender == 'F'
          gender_counter['female'] += 1
        end
      end
      {
        'party' => {
          'democrat' => {
            'percentage' => ((party_counter["democrat"].to_f / 2) * 100).round,
            'count' => party_counter["democrat"],
          },
          'republican' => {
            'percentage' => ((party_counter["republican"].to_f / 2) * 100).round,
            'count' => party_counter["republican"],
          },
          'other' => {
            'percentage' => ((party_counter["other"].to_f / 2) * 100).round,
            'count' => party_counter["other"],
          }
        },
        'gender' => {
          'male' => {
            'percentage' => ((gender_counter["male"].to_f / self.senators.count) * 100).round,
            'count' => gender_counter["male"],
          },
          'female' => {
            'percentage' => ((gender_counter["female"].to_f / self.senators.count) * 100).round,
            'count' => gender_counter["female"]
          }
        }
      }
    end

    def congress_stats
      party_counter = {
        'democrat' => 0,
        'republican' => 0,
        'other' => 0
      }
      gender_counter = {
        'male' => 0,
        'female' => 0
      }
      self.congresspersons.each do |congressperson|
        if congressperson.party == 'Democrat'
          party_counter["democrat"] += 1
        elsif congressperson.party == 'Republican'
          party_counter["republican"] += 1
        else
          party_counter["other"] += 1
        end
        if congressperson.gender == 'M'
          gender_counter['male'] += 1
        elsif congressperson.gender == 'F'
          gender_counter['female'] += 1
        end
      end
      {
        'total' => congresspersons.count,
        'party' => {
          'democrat' => {
            'percentage' => ((party_counter["democrat"].to_f / self.congresspersons.count) * 100).round,
            'count' => party_counter["democrat"],
          },
          'republican' => {
            'percentage' => ((party_counter["republican"].to_f / self.congresspersons.count) * 100).round,
            'count' => party_counter["republican"],
          },
          'other' => {
            'percentage' => ((party_counter["other"].to_f / self.congresspersons.count) * 100).round,
            'count' => party_counter["other"],
          }
        },
        'gender' => {
          'male' => {
            'percentage' => ((gender_counter["male"].to_f / self.congresspersons.count) * 100).round,
            'count' => gender_counter["male"],
          },
          'female' => {
            'percentage' => ((gender_counter["female"].to_f / self.congresspersons.count) * 100).round,
            'count' => gender_counter["female"]
          }
        }

      }
    end

    def self.state_abbreviations
      state_list.keys
    end

    def self.populate
      if State.all.length < 1
        state_list.each do |abbreviated_name, full_name|
          state = State.new

          state.abbreviated_name = abbreviated_name
          state.full_name = full_name
          state.save
        end
      else
        puts "State list is already populated"
      end
    end

    def summary
      member = OpenSecrets::Member.new(api_key)

      content = member.get_legislators({:id => abbreviated_name})
      pp content['response']['legislator']
    end

    def self.state_list
      {
        'AL' => 'Alabama',
        'AK' => 'Alaska',
        'AZ' => 'Arizona',
        'AR' => 'Arkansas',
        'CA' => 'California',
        'CO' => 'Colorado',
        'CT' => 'Connecticut',
        'DE' => 'Delaware',
        'FL' => 'Florida',
        'GA' => 'Georgia',
        'HI' => 'Hawaii',
        'ID' => 'Idaho',
        'IL' => 'Illinois',
        'IN' => 'Indiana',
        'IA' => 'Iowa',
        'KS' => 'Kansas',
        'KY' => 'Kentucky',
        'LA' => 'Louisiana',
        'ME' => 'Maine',
        'MD' => 'Maryland',
        'MA' => 'Massachusetts',
        'MI' => 'Michigan',
        'MN' => 'Minnesota',
        'MS' => 'Mississippi',
        'MO' => 'Missouri',
        'MT' => 'Montana',
        'NE' => 'Nebraska',
        'NV' => 'Nevada',
        'NH' => 'New Hampshire',
        'NJ' => 'New Jersey',
        'NM' => 'New Mexico',
        'NY' => 'New York',
        'NC' => 'North Carolina',
        'ND' => 'North Dakota',
        'OH' => 'Ohio',
        'OK' => 'Oklahoma',
        'OR' => 'Oregon',
        'PA' => 'Pennsylvania',
        'RI' => 'Rhode Island',
        'SC' => 'South Carolina',
        'SD' => 'South Dakota',
        'TN' => 'Tennessee',
        'TX' => 'Texas',
        'UT' => 'Utah',
        'VT' => 'Vermont',
        'VA' => 'Virginia',
        'WA' => 'Washington',
        'WV' => 'West Virginia',
        'WI' => 'Wisconsin',
        'WY' => 'Wyoming'
      }
    end

    def api_key
      'ad444fa84f3cf1fd936f4b2c4f768fc2'
    end

end
