class Trip < ApplicationRecord
  belongs_to :itinerary
  
  def self.receive_mail(message)
        puts "++++++++++++++++++++++++++++++++++"
        puts message.body.inspect
        puts "++++++++++++++++++++++++++++++++++"
        
        #take from DB
        airplane = ["plane", "airplane", "flight"]
        train = ["train", "rail"]
        bus = ["bus"]
        
        airlines = ["aer lingus", "asl airlines ireland", "cityjet", "norwegian air international", "ryanair", "stobard air"]
        railcarriers = ["dart", "northern commuter", "south eastern commuter", "south western commuter", "western commuter"]
        buscarriers = ["bus eireann", "matthews"]

        @user = User.find_by email: message.from
        
        @itinerary = Itinerary.new(user: @user)
        
        @itinerary.save!
        
        trip = Trip.new(itinerary: @itinerary)
        
        airplane.each do |word|
            if message.body.include?(word)
                trip.type_name = "plane"
            end
        end
        train.each do |word|
            if message.body.include?(word)
                trip.type_name = "train"
            end  
        end
        bus.each do |word|
            if message.body.include?(word)
                trip.type_name = "bus"
            end
        end
 
        if trip.type_name == "plane"
            airlines.each do |word|
                if message.body.include?(word)
                    trip.carrier = word
                end
            end

        elsif trip.type_name == "train"
            railcarriers.each do |word|
                if message.body.include?(word)
                    trip.carrier = word
                end
            end
            
        elsif trip.type_name == "bus"
            buscarriers.each do |word|
                if message.body.include?(word)
                    trip.carrier = word
                end
            end
        end
        
        conf_num = message.body.match(/[a-zA-Z]{3}\d{4}/)
        if conf_num
            trip.confirmation_number = conf_num[0]
        end
        string = message.body.to_s
        
        times = string.scan(/(\d:\d\d[a|p]|\d\d:\d\d[a|p])/)
        starts_at_time = times[0][0]
        ends_at_time = times[1][0]

        locations = string.scan(/[A-Z]{3}\b/)
        trip.starting_location = locations[0]
        trip.ending_location = locations[1]
        
        dates = string.scan(/\d{2}\/\d{2}\/\d{2}/)
        starts_at_date = dates[0]
        ends_at_date = dates[1]

        trip.starts_at =  starts_at_time + starts_at_date
        trip.ends_at = ends_at_time + ends_at_date

       puts"$%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
       puts trip.inspect
       
        trip.save!

    end
end 