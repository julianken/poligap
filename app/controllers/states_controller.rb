class StatesController < ApplicationController

  def index
    @states = State.all
    render :json => @states
  end

  def show
    @state = State.find_by(abbreviated_name: params[:state])
    @representatives = @state.representatives
    render :json => @representatives
  end
end
