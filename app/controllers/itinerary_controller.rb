class ItineraryController < ApplicationController
  def new
  end

  def show
    @itinerary = Itinerary.find(params[:id])
    @trip = @itinerary.trips.last
  end
  
  def index
    @itineraries = Itinerary.all
  end
end
