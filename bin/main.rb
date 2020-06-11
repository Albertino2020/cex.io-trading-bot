#!/usr/bin/env ruby
require_relative '../lib/strategy'
require_relative '../lib/user_interface'
require 'io/console'
DEMO_USR = 'up131139167'.freeze
DEMO_KEY = 'NJGrN6Dev9M57nyxQDaFQzZa4Q'.freeze
DEMO_SECRET = 'MI87dH6sDIh1g0aQQNfV1PdaimQ'.freeze

on_start_intro

familiar = gets.chomp.upcase == 'Y'

follow_up(familiar)

authorized= gets.chomp.upcase == 'Y'

check_key(authorized)

connect(authorized)

run = true

while run
  on_connection_options
  operation = gets.to_i
  on_intro(operation)
  execute(operation)
  puts 'Do you want to continue (Y/N)?'
  continue = gets.chomp.upcase == 'Y'
  puts 'It was a pleasure serving you! See you soon!' unless continue
  run = continue
end
