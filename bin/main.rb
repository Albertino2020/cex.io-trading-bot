#!/usr/bin/env ruby
# frozen_string_literal: true
require_relative '../lib/cexio'

puts "Testing connecting with the CEX.IO API"
usr = 'up100854764'
api_key = 'KRBDeKmP5KkEiWUSpYcR0HcdgQg'
sec = '2NR1o4bf3OOn7HRPdk5HM4jzJyc'
cex = CEX::API.new(usr, api_key, sec)


puts 'Congratulations! My Bot project setup completed!'