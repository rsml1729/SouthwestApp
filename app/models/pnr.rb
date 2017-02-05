class Pnr < ApplicationRecord
  validates_length_of :rcrd_loc, is: 6, message: 'Invalid Confirmation #'
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  
  has_many :flights
  
  self.primary_key = 'rcrd_loc'
end
