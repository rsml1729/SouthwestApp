#!/usr/bin/env ruby

# FILE:   pnr_lookup.rb
# AUTH:   Richard Lam
# DATE:   2017-02-06
# DESC:   Check the validity of a PNR on Southwest's website

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
    Helper.log(pnr.confirmation_number, "Error retrieving reservation.", e.message, json)
    return false
  end
  
  # Parse JSON if valid
  response_json = JSON.parse(response)
  response_json['passengers'][0]['checkinEligibilities'].each do |s|
    seg = s['segmentId'].split('|')
    flt_time = DateTime.strptime(seg[0].split(',')[0],'%Y%m%d%H%M%z')
    @segment = Segment.new(:rcrd_loc => pnr.rcrd_loc, 
                           :od => seg[1], 
                           :flt_num => seg[2],
                           :flt_time => flt_time)
    @segment.save
    pnr.segments << @segment
  end
  return true
  
end

#pnr_lookup('5WG7VU','Richard','Lam',NIL)
