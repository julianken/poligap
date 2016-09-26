class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
    render :json => @representatives
  end

  def show
    @representative = Representative.find_by(cid: params[:cid])
    render :json => @representative
  end
end
