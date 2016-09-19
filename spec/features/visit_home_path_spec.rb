require 'rails_helper'

feature "visits root path" do
  scenario "successfully" do
    visit root_path
    click_link('Wisconsin')
    click_link('Paul Ryan')
    expect(page).to have_css 'li', text: 'Speaker'
  end
end
