class User < ApplicationRecord
  
  before_create :confirmation_token
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_one :profile
  has_many :itineraries
  has_many :trips, through: :itineraries
  
  delegate :full_name, to: :profile, prefix: false, allow_nil: true
  
  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end
  
  
  
end
