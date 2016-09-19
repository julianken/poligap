class PoliticiansController < ApplicationController

  def index
    @representatives = Representative.all
  end

  def show
    @politician = Representative.find_by(cid: params[:cid])
  end

end
