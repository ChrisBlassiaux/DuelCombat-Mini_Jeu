require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

#VERSION 3.0


puts "------------------------------------------------"
puts "|   Bienvenue sur 'ILS VEULENT TOUS MA POO' !   |"
puts "------------------------------------------------"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"

puts "*** Quel nom de combattant veux-tu utiliser ? ***"
print ">>> "
user_name = gets.chomp
my_game = Game.new(user_name)


while my_game.is_still_ongoing?
  my_game.start
  my_game.show_players 
  my_game.menu  
  my_game.menu_choice
  my_game.enemies_attack
end
my_game.end

#binding.pry