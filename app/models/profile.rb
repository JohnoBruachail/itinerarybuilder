class Profile < ApplicationRecord
  belongs_to :user
  
  def full_name
      "#{firstname} #{lastname}"
  end
end
