class StatesController < ApplicationController

  def show
    @state = State.find_by(abbreviated_name: params[:state])
    @representatives = @state.representatives
    render :json => @representatives
  end
end
