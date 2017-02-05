class Pnr < ApplicationRecord
  validates_length_of :rcrd_loc, is: 6, message: 'Invalid Confirmation #'
  
  has_many :flights
  
  self.primary_key = 'rcrd_loc'
end
