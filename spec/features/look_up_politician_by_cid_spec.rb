require 'rails_helper'

feature 'looks up a politician by cid' do
  scenario 'successfully' do
    visit root_path
    fill_in 'CID', :with => 'N00033226'
    click_button 'Search'
    expect(page).to have_css 'h3', text: 'Gary Johnson' 
  end
end
