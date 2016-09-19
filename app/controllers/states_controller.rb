class StatesController < ApplicationController
  def show
    @state = State.find_by(abbreviated_name: params[:state])
  end
end
