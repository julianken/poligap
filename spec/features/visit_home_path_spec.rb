require 'rails_helper'

feature "visits root path" do
  scenario "successfully" do
    visit root_path
    expect(page).to have_css 'h1', text: 'Poligap'
  end
end
