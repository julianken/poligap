class IndexController < ApplicationController
  def index
    @states = State.all
  end
end
