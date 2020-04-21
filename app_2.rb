require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

#VERSION 2.0

puts "------------------------------------------------"
puts "|   Bienvenue sur 'ILS VEULENT TOUS MA POO' !   |"
puts "------------------------------------------------"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"

puts "*** Quel nom de combattant veux-tu utiliser ? ***"
print ">>> "
user_name = gets.chomp
user = HumanPlayer.new(user_name)

bot_1 = Player.new('Josiane')
bot_2 = Player.new('José')
enemies = [bot_1, bot_2]
tour = 0

while user.lifepoints > 0 && (bot_1.lifepoints > 0 || bot_2.lifepoints > 0)
 
  puts " "
  puts "=================== TOUR DE JEU ##{tour} ===================="
  puts " "
  puts "-------- Voici l'état de #{user_name} --------"
  puts user.show_state

  puts '-------- Quelle action veux-tu effectuer ? --------'
  puts 'a - chercher une meilleure arme'
  puts 's - chercher à se soigner'
  puts '-------- Attaquer un joueur en vue : --------'
  print "0 - "
  bot_1.show_state
  print "1 - "
  bot_2.show_state

  print ">> "
  choice = gets.chomp

  case choice 
  when "a" then user.search_weapon
  when "s" then user.search_health_pack
  when "0" then user.attacks(bot_1)
  when "1" then user.attacks(bot_2)
  else
    puts "==> Ta saisie n'est pas correct, recommence ! <==="
  end
  puts " "
  puts "-------- Les autres joueurs t'attaquent ! --------"

  enemies.each do |enemie|
    if enemie.lifepoints > 0 
      enemie.attacks(user)
    end
  end

  tour += 1
end

puts "---- La partie est finie ----" 
if user.lifepoints > 0 
  puts "---- BRAVO ! TU AS GAGNE ! ----"
else
  puts "---- Loser ! Tu as perdu ! ----"
end