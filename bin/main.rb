#!/usr/bin/env ruby
require_relative "../lib/cexio"

puts "Are you familiar with the CEX.IO Trading Bot?"

familiar = gets.chomp.upcase == "Y" ? true : false

if familiar
  puts "Do you have CEX.iO API authorization?"
else
  puts "Welcome to the pleasure of automated trading on the world's best cryptocurrency market!"
  puts "This software atomates all market operations of buying, selling, placing orders, etc., in a secure and profitable way."
  puts "You are not required to have any trading experience. You all need to provide your authorizations details."
  puts "CEX.io Bot does the job.!"
  puts "Do you have autorization to access this market?"
end

authorized = gets.chomp.upcase == "Y" ? true : false
if authorized
  puts "Please enter your authorization details:"
  print "User Name: "
  usr = gets.chomp
  puts ""
  print "API KEY: "
  api_key = gets.chomp
  puts ""
  print "Secret Code: "
  secret = gets.chomp
  puts ""
else
  puts "Autorization is required to access this market."
  puts "Do you whant to run the Bot in a demo mode?"
  demo = gets.chomp.upcase == "Y" ? true : false
end
if authorized
  puts "You have successfully connected to a real account."
  connect = CEX::API.new(usr, api_key, secret)
elsif demo
  puts "Bot is running in the demo mode."
  connect = CEX::API.new(demo_usr, demo_key, demo_secret)
end
puts "What do you want to do next?"
puts "Please choose your desired operation: 1: Check balance, 2: , 3: "
operation = gets.to_i
if operation == 1
  connect.balance
elsif operation == 2
  connect.trade
end
