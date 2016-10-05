class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
    render :json => @representatives
  end

  def show
    @representative = Representative.find(params[:id])
    render :json => @representative
  end
end
