require_relative "../lib/strategy"
# module Interface
# attr_writer :demo, :usr, :api_key, :secret, :account

def on_start_intro
  puts "Are you familiar with the CEX.IO Trading Bot (Y/N)?"
end

def follow_up(familiar)
  if familiar
    puts "Do you have a CEX.IO API Key (Y/N)?"
  else
    puts "Welcome to the pleasure of automated trading on the world's best cryptocurrency market!"
    puts ""
    puts "This software atomates all market operations of buying, selling, placing orders, etc.,
        in a secure and profitable way."
    puts ""
    puts "You are not required to have any trading experience. You only need to provide your
        API Key details. CEX.io Bot does the job.!"
    puts ""
    puts "Do you have an API Key to access this market (Y/N)?"
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
    puts "Do you whant to run the Bot in the demo mode (Y/N)?"
    @demo = gets.chomp.upcase == "Y"
  end
end

def connect(authorized)
  if authorized
    puts "You have successfully connected to a real account."
    @account = Trade::API.new(usr, api_key, secret)
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
