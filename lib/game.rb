class Game 
  attr_accessor :human_player, :enemies
  @@tour = 0

  def initialize(human)
    @human_player = HumanPlayer.new(human)
    bot_1 = Player.new('bot_1')
    bot_2 = Player.new('bot_2')
    bot_3 = Player.new('bot_3')
    bot_4 = Player.new('bot_4')
    @enemies = [bot_1, bot_2, bot_3, bot_4]
  end

  def start
    puts " "
    puts "=================== TOUR DE JEU ##{@@tour} ===================="
    puts " "
    @@tour += 1
  end

  def kill_player(player)
    @enemies.delete(player)
  end

  def is_still_ongoing?
    if @human_player.lifepoints > 0 && @enemies.size > 0
      true
    else
      false
    end
  end

  def show_players  
    puts "---------------- Voici l'état de #{@human_player.name} ----------------"
    puts @human_player.show_state
    puts "------------- Nombre d'enemies restant : #{@enemies.size} ------------"
    puts " "
  end

  def menu 
    bot = 0
    puts '---------- Quelle action veux-tu effectuer ? ---------'
    puts 'a - chercher une meilleure arme'
    puts 's - chercher à se soigner'
    puts '------------ Attaquer un joueur en vue : ------------'
    @enemies.each do |enemie|
      puts "#{bot} Attaquer le #{enemie.name}"
      bot += 1
    end
  end

  def menu_choice
    print ">> "
    choice = gets.chomp
  
    if choice == "a" 
      @human_player.search_weapon
    elsif choice == "s"
      @human_player.search_health_pack
    else
      @human_player.attacks(@enemies[choice.to_i])
      if @enemies[choice.to_i].lifepoints <= 0
        kill_player(@enemies[choice.to_i])
      end
    end
  end

  def enemies_attack
    puts "-------- Les autres joueurs t'attaquent ! --------"
    @enemies.each do |enemie|
      if enemie.lifepoints > 0 
        enemie.attacks(@human_player)
      end
    end
  end

  def end
    puts "---------------- La partie est finie ----------------" 
    if @human_player.lifepoints > 0 
      puts "---------------- BRAVO ! TU AS GAGNE ! ----------------"
    else
      puts "---------------- Loser ! Tu as perdu ! ----------------"
    end
  end
end
