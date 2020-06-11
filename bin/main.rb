#!/usr/bin/env ruby
require_relative "../lib/strategy"
require_relative "../lib/user_interface"
require "io/console"
DEMO_USR = "up131139167".freeze
DEMO_KEY = "NJGrN6Dev9M57nyxQDaFQzZa4Q".freeze
DEMO_SECRET = "MI87dH6sDIh1g0aQQNfV1PdaimQ".freeze

on_start_intro

familiarity = gets.chomp.upcase == "Y"

follow_up(familiarity)

authorization = gets.chomp.upcase == "Y"
check_key(authorization)
connect(authorization)

if authorized
  puts "You have successfully connected to a real account."
  connect = Trade::API.new(usr, api_key, secret)
elsif demo
  puts "Bot is running in the demo mode."
  connect = Trade::API.new(DEMO_USR, DEMO_KEY, DEMO_SECRET)
end
run = true
while run
  puts "What do you want to do next?"
  puts "Please choose your desired operation:
1: Check balance
2: Start Bot in the automatic trading mode
3. Get trading fees
You chose option: "
  operation = gets.to_i
  if operation == 1
    puts "I got you. Bellow is your account balance for each currency."
    connect.ops(operation - 1).each do |key, value|
      print "#{key} : " unless key.to_s == "timestamp" || key.to_s == "username"
      value.each { |key1, value1| print "#{key1} : #{value1} " } if value.is_a?(Hash)
      puts ""
    end
  elsif operation == 3
    puts "I got you. Bellow are the current trading fees"
    connect.ops(operation - 1).each do |key, value|
      next unless key.to_s == "data"

      value.each do |key1, value1|
        print "#{key1} : "
        value1.each { |key2, value2| print "#{key2} : #{value2}% " } if value1.is_a?(Hash)
        puts ""
      end
    end
  else
    puts "The Bot is now running in the automatic mode..."
  end
  while operation == 2 && !demo
    connect.autotrade
    puts "The Bot is running in the automatic mode. Type q to stop."
    char = STDIN.getch
    break if char == "q"
  end
  while operation == 2 && demo
    connect.demotrade
    puts "The Bot is running in the automatic mode. Type q to stop."
    char = STDIN.getch
    break if char == "q"
  end
  puts "Do you want to continue (Y/N)?"
  continue = gets.chomp.upcase == "Y"
  puts "It was a pleasure serving you! See you soon!" unless continue
  run = continue
end
