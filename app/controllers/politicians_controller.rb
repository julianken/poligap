class PoliticiansController < ApplicationController
  def index
  end
  def show
    @politician = Politician.new(params[:cid])
  end
end
