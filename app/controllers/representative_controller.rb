class RepresentativeController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def show
    @representative = Representative.find_by(cid: params[:cid])
  end
end
