class Pnr < ApplicationRecord
  
  validates_length_of :rcrd_loc, is: 6, message: 'Invalid Confirmation #'
  validates_presence_of :first_name, message: 'First Name cannot be blank'
  validates_presence_of :last_name, message: 'Last Name cannot be blank'
  validates_presence_of :email, message: 'Email cannot be blank'
  validate :email_booth
  validate :pnr_is_valid
  
  has_many :segments
    
  self.primary_key = 'rcrd_loc'

  private
  def email_booth
    email.include?("@chicagobooth.edu") ? return : errors.add(:email, 'Invalid Booth email')
  end
  
  def pnr_is_valid
    pnr_lookup(self) ? return : errors.add(:rcrd_loc, 'Invalid Confirmation #')
  end
  
end


require 'net/http'
require 'uri'
require 'rest-client'
require 'json'


def pnr_lookup(pnr)
  
  base_url = "https://mobile.southwest.com/api/extensions/v1/mobile"
  default_options = {
    "X-API-Key": "l7xx12ebcbc825eb480faa276e7f192d98d1"
  }
  options = {
        params: {
          "first-name": pnr.first_name,
          "last-name": pnr.last_name,
        }
  }.merge(default_options)
  
  # Raise exception if not valid reservation
  begin
    response = RestClient.get("#{base_url}/reservations/record-locator/#{rcrd_loc}", options)
  rescue RestClient::ExceptionWithResponse => e
    json = JSON.parse(e.response)
    #Helper.log(pnr.confirmation_number, "Error retrieving reservation.", e.message, json)
    return false
  end
  
  # Parse JSON if valid
  response_json = JSON.parse(response)
  response_json['passengers'][0]['checkinEligibilities'].each do |s|
    seg = s['segmentId'].split('|')
    flt_time = DateTime.strptime(seg[0].split(',')[0],'%Y%m%d%H%M%z')
    @segment = Segment.new(:od => seg[1], 
                           :flt_num => seg[2],
                           :flt_time => flt_time,
                           :checkin_time => flt_time - 1.hour)
    @segment.save
    pnr.segments << @segment
  end
  return true
  
end