class Pnr < ApplicationRecord
  
  validates_length_of :rcrd_loc, is: 6, message: 'Invalid Confirmation #'
  validates_presence_of :first_name, message: 'First Name cannot be blank'
  validates_presence_of :last_name, message: 'Last Name cannot be blank'
  validates_presence_of :email, message: 'Email cannot be blank'
  validate :email_on_whitelist
  
  has_many :flights
  
  self.primary_key = 'rcrd_loc'
  
  private
  def email_on_whitelist
    Whitelist.exists?(:email => email) ? return : errors.add(:email, 'Invalid BoothHacks member email')
  end
  
end

