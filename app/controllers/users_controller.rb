  class UsersController < ApplicationController

  def show
    @events = bandsintown_service.on_sale_soon
  end
end
