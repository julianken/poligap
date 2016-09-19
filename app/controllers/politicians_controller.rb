class PoliticiansController < ApplicationController

  def index
    @states = State.all
  end

  def show
    @politician = Politician.new(params[:cid])
  end

end
