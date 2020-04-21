require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

player1 = Player.new("Josiane")
player2 = Player.new("José")


#VERSION 1.0

while player1.lifepoints > 0 && player2.lifepoints > 0
  puts "---- Voici l'état de chaque joueur ----"
  print player1.show_state
  puts player2.show_state

  puts "**** Passons à la phase d'attaque ****"
  print player1.attacks(player2)
  break if player2.lifepoints <= 0 
  puts player2.attacks(player1)
end

