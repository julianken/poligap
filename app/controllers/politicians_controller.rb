class PoliticiansController < ApplicationController

  def show
    @politician = Politician.new(params[:cid])
  end
  
end
