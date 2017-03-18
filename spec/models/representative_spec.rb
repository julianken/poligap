require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe '#chamber' do
    it 'returns Senate for {sen} abbreviation' do
      rep = Representative.new
      rep.congress_office = 'sen'
      rep.save

      expect(rep.chamber).to(eq('Senate'))
    end

    it 'returns House of Representatives for {con}' do
      rep = Representative.new
      rep.congress_office = 'rep'
      rep.save

      expect(rep.chamber).to(eq('House of Representatives'))
    end
  end

  describe '#full_name' do
    it 'returns a full name string that concats first_name and last_name' do
      rep = Representative.new(first_name: "Julian", last_name: "Kennon")
      rep.save

      expect(rep.full_name).to(eq('Julian Kennon'))
    end
  end

  describe '#prefix' do
    it 'returns the prefix Senator for {sen}' do
      rep = Representative.new(congress_office: 'sen')
      rep.save

      expect(rep.prefix).to(eq('Senator'))
    end
  end

    describe '#prefix' do
    it 'returns the prefix Representative for {rep}' do
      rep = Representative.new(congress_office: 'rep')
      rep.save

      expect(rep.prefix).to(eq('Representative'))
    end
  end
end
