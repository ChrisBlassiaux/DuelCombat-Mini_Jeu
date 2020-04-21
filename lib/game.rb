class Game 
  attr_accessor :human_player, :players_left, :enemies_in_sight
  @@tour = 0

  def initialize(human)
    @human_player = HumanPlayer.new(human)
    @players_left = 10
    @enemies_in_sight = []
  end

  def start
    puts " "
    puts "=================== TOUR DE JEU ##{@@tour} ===================="
    puts " "
    @@tour += 1
  end

  def kill_player(player)
    @enemies_in_sight.delete(player)
  end

  def is_still_ongoing?
    if @human_player.lifepoints > 0 && @players_left > 0
      true
    else
      false
    end
  end

  def show_players  
    puts "---------------- Voici l'état de #{@human_player.name} ----------------"
    puts @human_player.show_state
    puts "------------- Nombre d'enemies restant : #{@enemies_in_sight.size} ------------"
    puts " "
  end

  def menu 
    bot = 0
    puts '---------- Quelle action veux-tu effectuer ? ---------'
    puts 'a - chercher une meilleure arme'
    puts 's - chercher à se soigner'
    puts '------------ Attaquer un joueur en vue : ------------'
    @enemies_in_sight.each do |enemie|
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
      @human_player.attacks(@enemies_in_sight[choice.to_i])
      if @enemies_in_sight[choice.to_i].lifepoints <= 0
        kill_player(@enemies_in_sight[choice.to_i])
      end
    end
  end

  def enemies_attack
    puts "-------- Les autres joueurs t'attaquent ! --------"
    @enemies_in_sight.each do |enemie|
      if enemie.lifepoints > 0 
        enemie.attacks(@human_player)
      end
    end
  end

  def new_players_in_sight
    if @enemies_in_sight == @players_left
      puts "Tous les joueurs sont déjà en vue"
    end
    random = rand(1..6)
    if random == 1 
      puts "Aucun nouveau joueur n'arrive"
    elsif random >= 2 && random <= 4
      puts "Un nouveau joueur arrive"
      @enemies_in_sight << Player.new("bot_#{rand(1..1000)}")
    else
      puts "Deux nouveau joueur arrive"
      @enemies_in_sight << Player.new("bot_#{rand(1..1000)}")
      @enemies_in_sight << Player.new("bot_#{rand(1..1000)}")
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
