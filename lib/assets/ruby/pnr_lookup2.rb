#!/usr/bin/env ruby

# FILE:   pnr_lookup.rb
# AUTH:   Richard Lam
# DATE:   2017-02-06
# DESC:   Check the validity of a PNR on Southwest's website

require 'net/http'
require 'uri'
require 'rest-client'


def pnr_lookup(rcrd_loc, first_name, last_name)
  
  base_url = "https://mobile.southwest.com/api/extensions/v1/mobile"
  default_options = {
    "X-API-Key": "l7xx12ebcbc825eb480faa276e7f192d98d1"
  }
  options = {
        params: {
          "first-name": first_name,
          "last-name": last_name,
        }
  }.merge(default_options)
  
  response = RestClient.get("#{base_url}/reservations/record-locator/""#{rcrd_loc}", options)
  
  puts response
  
  
  
  #uri = URI("https://www.southwest.com/flight/view-air-reservation.html")
  #req = Net::HTTP::Post.new(uri)
  #req.set_form_data('confirmationNumberFirstName' => first_name, 'confirmationNumberLastName' => last_name, 'confirmationNumber' => rcrd_loc)
  #res = Net::HTTP.start(uri.hostname, uri.port) do |http|
    #http.request(req)
    #end
    
  
    
  
  #res = Net::HTTP.post_form(uri, 'confirmationNumberFirstName' => first_name, 'confirmationNumberLastName' => last_name, 'confirmationNumber' => rcrd_loc)
  
  #puts res.code
  #puts res['location']
  
  #case res
  #when Net::HTTPSuccess, Net::HTTPRedirection
  #  puts fetch(res['location'],10)
  #else
  #  res.value
    #end
  
  #res = Net::HTTP.post_form(uri, 'confirmationNumberFirstName' => first_name, 'confirmationNumberLastName' => last_name, 'confirmationNumber' => rcrd_loc)
  #puts res.code
  
  #uri = URI("https://www.southwest.com/flight/retrieveCheckinDoc.html")
  #uri = URI("https://www.southwest.com/flight/view-air-reservation.html")

  #Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    #res = Net::HTTP::post_form(uri, 'confirmationNumberFirstName' => first_name, 'confirmationNumberLastName' => last_name, 'confirmationNumber' => rcrd_loc)
    #puts res.body
    
    #request = Net::HTTP::Get.new uri
    #response = http.request request # Net::HTTPResponse object
    #puts response.body
    #end
end

def fetch(uri_str, limit = 10)
  raise ArgumentError, 'Too many HTTP redirects' if limit == 0

  response = Net::HTTP.get_response(URI(uri_str))
  puts response.code

  case response
  when Net::HTTPSuccess then
    puts response.body
    response
  when Net::HTTPRedirection then
    location = response['location']
    warn "redirected to #{location}"
    fetch(location, limit - 1)
  else
    response.value
  end
end

pnr_lookup('5WG7VU','Richard','Lam')
