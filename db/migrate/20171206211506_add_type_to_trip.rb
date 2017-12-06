class AddTypeToTrip < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :type_name, :string
  end
end
