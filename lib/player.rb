class Player
  attr_accessor :lifepoints, :name 

  def initialize(name)
    @name = name
    @lifepoints = 10
  end

  def show_state
    if @lifepoints <= 0 
      puts "#{@name} a été tué"
    else
      puts "#{@name} a #{@lifepoints} points de vie"
    end
  end

  def gets_damage(damage)
    @lifepoints -= damage
    if @lifepoints <= 0
      puts "#{@name} a été tué !"
    end
  end

  def attacks(attacked_player)
    damage_inflicted = compute_damage
    puts "Le joueur #{@name} attaque #{attacked_player.name}"
    puts "Il lui inflige #{damage_inflicted} points de dommages"
    attacked_player.gets_damage(damage_inflicted)
  end

  def compute_damage
    return rand(1..6)
  end
end


class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    @lifepoints = 100
    @weapon_level = 1
    @name = name
  end

  def show_state
    puts "#{@name} a #{@lifepoints} points de vie et une arme de niveau #{@weapon_level}"
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    level_weapon = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{level_weapon}"
    if level_weapon > @weapon_level 
      @weapon_level = level_weapon
      puts  "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
    else 
      puts "Dommage, elle n'est pas mieux que ton arme actuelle..."
    end
  end

  def search_health_pack
    result = rand(1..6)
    if result == 1 
      puts "Tu n'as rien trouvé... "
    elsif result >= 2 && result <= 5
      if @lifepoints <= 50 
        @lifepoints += 50
      else  
        @lifepoints = 100
      end
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    else
      if @lifepoints <= 20 
        @lifepoints += 80
      else  
        @lifepoints = 100
      end
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
    end
  end
end