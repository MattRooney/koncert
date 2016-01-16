class UsersController < ApplicationController

  def bandsintown_service
    @bandsintown_service = BandsInTownService.new
  end

  def show
    @events = bandsintown_service.on_sale_soon
    binding.pry
  end
end
