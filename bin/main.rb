#!/usr/bin/env ruby
require_relative '../lib/cexio'

puts 'Testing connection with the CEX.IO API'
usr = 'up100854764'
api_key = 'KRBDeKmP5KkEiWUSpYcR0HcdgQg'
sec = '2NR1o4bf3OOn7HRPdk5HM4jzJyc'
cex = CEX::API.new(usr, api_key, sec)

cex.balance.each do |key, value|
  print "#{key} : "
  value.each { |key1, value1| print "#{key1} : #{value1} " } if value.is_a?(Hash)
  puts ''
end

puts 'Congratulations! My Bot project setup is completed!'
