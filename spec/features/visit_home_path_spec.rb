require 'rails_helper'

feature "visits root path" do
  scenario "successfully" do
    visit root_path
    click_link('California')
    click_link('Barbara Boxer')
    expect(page).to have_css 'li', text: 'Senator'
  end
end
