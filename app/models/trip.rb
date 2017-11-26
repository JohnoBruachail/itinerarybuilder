class Trip < ApplicationRecord
  belongs_to :itinerary
  
  def self.receive_mail(message)
      starts_at = message.body # find the start at time inside the body string, using regular expressions
      # (try using IDs or something like that to determine easily where is each value you need).
      
      trip = Trip.new do |new_trip|
          new_trip.starts_at = starts_at
          new_trip.ends_at = ends_at
          new_trip.carrier = carrier
          new_trip.starting_location = starting_location
          new_trip.ending_location = ending_location
          new_trip.confirmation_number = confirmation_number
          new_trip.seat_number = seat_number
          # new_trip.itinerary = itinerary
      )
      trip.save!
  end
end
