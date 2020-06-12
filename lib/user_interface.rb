require_relative "../lib/strategy"

def on_start_intro
  puts "Are you familiar with the CEX.IO Trading Bot (Y/N)?"
end

def follow_up(familiar)
  if familiar
    puts "Do you have a CEX.IO API Key (Y/N)?"
  else
    puts "Welcome to the pleasure of automated trading on the world's best cryptocurrency market!

    This software automates all market operations of buying, selling, placing orders, etc.,
    in a secure and profitable way.

    You are not required to have any trading experience. You only need to provide your
    API Key details. CEX.io Bot does the job!

    Do you have an API Key to access this market (Y/N)?"
  end
end

def check_key(authorized)
  if authorized
    puts "Please enter your CEX.IO API KEY details:"
    print "User Name: "
    @usr = gets.chomp
    puts ""
    print "API KEY: "
    @api_key = gets.chomp
    puts ""
    print "Secret Code: "
    @secret = gets.chomp
    puts ""
  else
    puts "I'm sorry, but an API Key is required to access this market."
    puts "Do you want to run the Bot in the demo mode (Y/N)?"
    @demo = gets.chomp.upcase == "Y"
  end
end

def connect(authorized)
  if authorized
    puts "You have successfully connected to a real account."
    @account = Trade::API.new(@usr, @api_key, @secret)
  elsif @demo
    puts "Bot is running in the demo mode."
    @account = Trade::API.new(DEMO_USR, DEMO_KEY, DEMO_SECRET)
  end
end

def on_connection_options
  puts "What do you want to do next?"
  puts "Please choose your desired operation:
  1: Check balance
  2: Start Bot in the automatic trading mode
  3. Get trading fees
  You chose option: "
end

def on_intro(option)
  @message_intro = "I got you. "
  if option == 1
    @message = "Your account balance for each currency: "
  elsif option == 2
    @message = "Running in the demo mode. Type q to stop." if @demo
    @message = "The Bot is running in the automatic mode. Type q to stop." unless @demo
  elsif option == 3
    @message = "Your trading fees for each currency: "
  end
  puts @message_intro, @message
end

def execute(operation)
  if operation == 1
    getbalance(operation)
  elsif operation == 3
    getfee(operation)
  elsif operation == 2
    run_bot
  end
end

def getbalance(operation)
  connect(@authorization).ops(operation - 1).each do |key, value|
    print "#{key} : " unless key.to_s == "timestamp" || key.to_s == "username"
    value.each { |key1, value1| print "#{key1} : #{value1} " } if value.is_a?(Hash)
    puts ""
  end
end

def getfee(operation)
  connect(@authorization).ops(operation - 1).each do |key, value|
    next unless key.to_s == "data"

    value.each do |key1, value1|
      print "#{key1} : "
      value1.each { |key2, value2| print "#{key2} : #{value2}% " } if value1.is_a?(Hash)
      puts ""
    end
  end
end

def run_bot
  until @demo
    connect(@authorization).autotrade
    char = STDIN.getch
    break if char == "q"
  end
  while @demo
    connect(@authorization).demotrade
    char = STDIN.getch
    break if char == "q"
  end
end
