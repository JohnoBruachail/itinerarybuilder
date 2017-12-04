class Trip < ApplicationRecord
  belongs_to :itinerary
  
  def self.receive_mail(message)

    puts "++++++++++++++++++++++++++++++++++++++++"

    puts message.body.inspect
    puts "++++++++++++++++++++++++++++++++++++++++"
    

    #message = # create a message using the same fields as returned by inspect
    
    #  starts_at = message.body # find the start at time inside the body string, using regular expressions
      # (try using IDs or something like that to determine easily where is each value you need).
      
 #     trip = Trip.new do |new_trip|
 #         new_trip.starts_at = 
#          new_trip.ends_at = ends_at
 #         new_trip.carrier = carrier
  #        new_trip.starting_location = starting_location
   #       new_trip.ending_location = ending_location
    ##      new_trip.confirmation_number = confirmation_number
      #    new_trip.seat_number = seat_number
          # new_trip.itinerary = itinerary
 #     end
  #John's parser:

          @email = message

        
        #take from DB
        airplane = ["plane", "airplane", "flight"]
        train = ["train", "rail" ]
        bus = [""]
        
        airlines = ["aer lingus", "asl airlines ireland", "cityjet", "norwegian air international", "ryanair", "stobard air"]
        railcarrier = ["dart", "northern commuter", "south eastern commuter", "south western commuter", "western commuter"]
        buscarrier = ["bus eireann", "matthews"]
        
        confirmationNo = ["confirmationNumber:", "Number"]
        type = ""
                  
        airplane.each do |word|
            if @email.body.include?(word)
                type = word
            end
        end
        train.each do |word|
            if @email.body.include?(word)
                type = word
            end  
        end
        bus.each do |word|
            if @email.body.include?(word)
                type = word
            end
        end
        carrier = ""
        if type.present? && airplane.include? type
            airlines.each do |word|
                if @email.body.include?(word)
                    carrier = word
                end
            end
            
            startLocation = @email.body[/\b[A-Z]/, 0]
            endLocation = @email.body[/\b[A-Z]/, 1]

        elsif type.present? && type == "train"
            traincarrier.each do |word|
                if @email.body.include?(word)
                    carrier = word
                end
            end
            
            
        elsif type.present? && type == "bus"
            buscarrier.each do |word|
                if @email.body.include?(word)
                    carrier = word
                end
            end
            
            
        end
        
        confirmationNo.each do |word|
            if @email.body.match(/#{word}\/(\w*/)[1]
                #take the value after that word
                confirmationNumber = word
            end
        end

        startTime = @email.body[/^([0-1][0-9]|[2][0-3]):([0-5][0-9])$/, 0]
        
        endTime = @email.body[/^([0-1][0-9]|[2][0-3]):([0-5][0-9])$/, 1]
        
        startDate = @email.body[/\d{1,2}\/\d{1,2}\/\d{4}/, 0]
        
        endDate = @email.body[/\d{1,2}\/\d{1,2}\/\d{4}/, 1]

        @user = User.find(params[@email.from])
        
        @itinerary = @user.itineraries.new
        @itinerary.save!
        @trip = @itinerary.trips.new(
            starts_at: startTime,
            ends_at: endTime,
            carrier: carrier,
            starting_location: startLocation,
            ending_location: endLocation,
            confirmation_number: confirmationNumber
        )
       
        @trip.save!

    end
end

  
  
  

