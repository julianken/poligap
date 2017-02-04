require 'rails_helper'

feature "visits states path" do
  scenario "successfully" do
    visit states_path
  end
end
