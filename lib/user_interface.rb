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
