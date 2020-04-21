class Player
  attr_accessor :lifepoints, :name 

  def initialize(name)
    @name = name
    @lifepoints = 10
  end

  def show_state
    puts "#{@name} a #{@lifepoints} points de vie"
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