#!/usr/bin/env ruby
require_relative "../lib/cexio"
DEMO_USR = "up131139167"
DEMO_KEY = "NJGrN6Dev9M57nyxQDaFQzZa4Q"
DEMO_SECRET = "MI87dH6sDIh1g0aQQNfV1PdaimQ"

puts "Are you familiar with the CEX.IO Trading Bot?"

familiar = gets.chomp.upcase == "Y" ? true : false

if familiar
  puts "Do you have a CEX.IO API Key?"
else
  puts "Welcome to the pleasure of automated trading on the world's best cryptocurrency market!"
  puts "This software atomates all market operations of buying, selling, placing orders, etc., in a secure and profitable way."
  puts "You are not required to have any trading experience. You only need to provide your authorizations details."
  puts "CEX.io Bot does the job.!"
  puts "Do you have an API Key to access this market?"
end

authorized = gets.chomp.upcase == "Y" ? true : false
if authorized
  puts "Please enter your CEX.IO API KEY details:"
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
  puts "I'm sorry, but an API Key is required to access this market."
  puts "Do you whant to run the Bot in the demo mode?"
  demo = gets.chomp.upcase == "Y" ? true : false
end
if authorized
  puts "You have successfully connected to a real account."
  connect = CEX::API.new(usr, api_key, secret)
elsif demo
  puts "Bot is running in the demo mode."
  connect = CEX::API.new(DEMO_USR, DEMO_KEY, DEMO_SECRET)
end
run = true
while run
  puts "What do you want to do next?"
  puts "Please choose your desired operation:
1: Check balance
2: Start Bot in the automatic trading mode
3. Get trading fees
4. Get order book for a specific pair
5. Get the list of the open orders
6. Cancel an order
7. Place an order
8. Convert currency
9. Get ticker
You chose option: "
  operation = gets.to_i
  if operation == 1
    (connect.OPS(operation - 1)).each do |key, value|
      print "#{key} : "
      value.each { |key1, value1| print "#{key1} : #{value1} " } if value.is_a?(Hash)
      puts ""
    end
  elsif operation == 2
    puts "The Bot is now running in the automatic mode. Type q to stop."
    while run
      char = STDIN.getch
      connect.autotrade
      break if char == "q"
    end
    puts "I got you. I am now running your desired operation."
    # (connect.OPS(operation - 1))(PARAMETERS))
  else
  end
  puts "Do you want to continue?"
  continue = gets.chomp.upcase == "Y" ? true : false
  if !continue
    puts "It was a pleasure serving you! See you soon!"
  end
  run = continue
end
