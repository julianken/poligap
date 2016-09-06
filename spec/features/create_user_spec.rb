require 'rails_helper'

feature 'creates a user' do
  scenario 'successfully' do
    user = User.new
    user.username = 'Julian'
    user.email = 'juliankennon@gmail.com'
    user.save
  end
end
