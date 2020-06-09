#!/usr/bin/env ruby
require_relative '../lib/cexio'

puts 'Testing connection with the CEX.IO API'
usr = 'up131139167'
api_key = 'NJGrN6Dev9M57nyxQDaFQzZa4Q'
sec = 'MI87dH6sDIh1g0aQQNfV1PdaimQ'
cex = CEX::API.new(usr, api_key, sec)

cex.balance.each do |key, value|
  print "#{key} : "
  value.each { |key1, value1| print "#{key1} : #{value1} " } if value.is_a?(Hash)
  puts ''
end

puts 'Congratulations! My Bot project setup is completed!'
