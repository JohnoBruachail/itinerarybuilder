class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.references :itinerary, foreign_key: true
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :carrier
      t.string :starting_location
      t.string :ending_location
      t.string :confirmation_number
      t.string :seat_number

      t.timestamps
    end
  end
end
