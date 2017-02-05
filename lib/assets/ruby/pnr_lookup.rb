#!/usr/bin/ruby -w

# FILE:   pnr_lookup.rb
# AUTH:   Richard Lam
# DATE:   2017-02-06
# DESC:   Check the validity of a PNR on Southwest's website

require 'net/http'
require 'uri'

uri = URI("https://www.southwest.com")

Net::HTTP.start(uri.host, uri.port,
  :use_ssl => uri.scheme == 'https') do |http|
  request = Net::HTTP::Get.new uri

  response = http.request request # Net::HTTPResponse object
  puts response
end