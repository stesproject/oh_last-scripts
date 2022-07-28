#==============================================================================
# Crissaegrim ABS
#==============================================================================
#------------------------------------------------------------------------------
# Créditos: Vlad
#------------------------------------------------------------------------------
# Para Criar um inimigo, coloque os seguintes comentários em um evento no mapa:

# Enemy ID - onde ID é o id do monstro no database;
# Die Erase - Apaga o Enemy_In_battle quando ele morrer morrer;
# Die Switch Local A - Ativa a Switch Local A quando o Enemy_In_battle morrer;
# Die Switch Local B - Ativa a Switch Local B quando o Enemy_In_battle morrer;
# Die Switch Local C - Ativa a Switch Local C quando o Enemy_In_battle morrer;
# Die Switch Local D - Ativa a Switch Local D quando o Enemy_In_battle morrer;
# Die Switch X - Ativa a Switch X quando o Enemy_In_battle morrer;
# Die Variable X - Soma +1 à Variável X quando o Enemy_In_battle morrer;
# Follow X - Para o evento seguir o herói automaticamente, mude X para a distância da visão do Enemy_In_battle.
# Kill Weapon ID - mude ID para o id de uma arma, assim o Enemy_In_battle irá morrer, apenas se a arma determinada for usada contra ele.
# Kill Skill ID - mude ID para o id de uma skill, assim o Enemy_In_battle irá morrer, apenas se a skill determinada for usada contra ele.
# Kill Item ID - mude ID para o ide de um item, assim o Enemy_In_battle irá morrer, apenas se o item determinado for usado contra ele.

#------------------------------------------------------------------------------
# CONFIGURAÇÕES GERAIS
#------------------------------------------------------------------------------
module Crissaegrim_ABS
#------------------------------------------------------------------------------
#Tecla de Ataque com a mão direita
Right_Attack_Button = Input::Letters["S"]
#------------------------------------------------------------------------------
#Tecla de Ataque com a mão esquerda e escudo
Left_Attack_and_Shield_Button = Input::Letters["F12"]
#------------------------------------------------------------------------------
# Teclas que memorizam as skills:
Skill_Button = {}
Skill_Button[1] = {Input::Numberkeys[4] => 0, Input::Numberkeys[5] => 0, Input::Numberkeys[6] => 0}
Skill_Button[10] = {Input::Numberkeys[4] => 0, Input::Numberkeys[5] => 0, Input::Numberkeys[6] => 0}
#------------------------------------------------------------------------------
# Teclas que memorizam os itens:
Item_Button = {Input::Numberkeys[1] => 0, Input::Numberkeys[2] => 0, Input::Letters["F12"] => 0,}
#------------------------------------------------------------------------------
# Armas de Distância.
# Para criar uma arma de distância, copie: Distance_Weapons[S] = [T, U, V, W, X, Y, Z] e mude:
# S:ID da Arma, T:Char, U:Index do Char, V:Velocidade, W:Distância, X:Tempo de espera para atacar, Y:Munição 1, Z:Munição 2
Distance_Weapons = {}
Distance_Weapons[6] = ["AB", 1, 6, 20, 10, 8, 22]
Distance_Weapons[8] = ["AB", 2, 7, 22, 9, 8, 22]
Distance_Weapons[10] = ["AB", 3, 7, 22, 9, 17, 22]
Distance_Weapons[11] = ["$RaggioLGrin", 0, 7, 22, 0, 25, 22]
Distance_Weapons[12] = ["AB", 7, 7, 22, 0, 23, 22]
Distance_Weapons[14] = ["AB", 7, 7, 22, 0, 23, 22]
#------------------------------------------------------------------------------
# Armas com animação
# Para criar uma arma com animação, copie: Animate_Weapons[X] = ["Y", Z] e mude:
# X para o id da arma no database e Y para o prefixo do nome do char atacando, e Z para o Index do Char
Animate_Weapons = {}
Animate_Weapons[0] = ["_Attacking", 0]
#------------------------------------------------------------------------------
# Som ao atirar
# Para criar uma arma com som, copie: Weapon_Shot_SE[X] = "Y" e mude:
# X para o ID da arma, e Y para o nome do som na pasta SE
Weapon_Shot_SE = {}
Weapon_Shot_SE[6] = "Laser1"
Weapon_Shot_SE[8] = "Laser1"
Weapon_Shot_SE[10] = "Fire5"
Weapon_Shot_SE[11] = "microwave"
Weapon_Shot_SE[12] = "Laser2"
#------------------------------------------------------------------------------
# Skills de Distância.
# Para criar uma skill de distância, copie: Distance_Skills[U] = [V, W, X, Y, Z] e mude:
# U:ID da skill, V:Char, W:Index do Char, X:Velocidade, Y:Distância, Z:Tempo de espera para atacar
Distance_Skills = {}
Distance_Skills[1] = ["AB", 5, 5, 15, 60]
Distance_Skills[2] = ["AB", 7, 6, 15, 120]
Distance_Skills[3] = ["AB", 6, 6, 30, 60]
Distance_Skills[4] = ["AB", 2, 6, 30, 20]
Distance_Skills[5] = ["AB", 4, 5, 30, 60]
Distance_Skills[6] = ["AB", 5, 5, 15, 60]
Distance_Skills[7] = ["AB", 7, 6, 20, 10]
Distance_Skills[8] = ["$missile2", 0, 7, 17, 10]

#------------------------------------------------------------------------------
# Skills com animação
# Para criar uma skill com animação, copie: Animate_Weapons[X] = ["Y", Z] e mude:
# X para o id da arma no database e Y para o prefixo do nome do char atacando, e Z para o Index do Char
Animate_Skills = {}
Animate_Skills[0] = ["_Casting", 0]
#------------------------------------------------------------------------------
# Som ao soltar skill
# Para criar uma skill com som, copie: Skill_Cast_SE[X] = "Y" e mude:
# X para o ID da skill, e Y para o nome do som na pasta SE
Skill_Cast_SE = {}
Skill_Cast_SE[1] = "Fire1"
Skill_Cast_SE[2] = "Laser2"
Skill_Cast_SE[3] = "Laser2"
Skill_Cast_SE[4] = "Laser2"
Skill_Cast_SE[5] = "Thunder3"
Skill_Cast_SE[6] = "Fire1"
Skill_Cast_SE[7] = "Laser2"
Skill_Cast_SE[8] = "Fire8"

#------------------------------------------------------------------------------
# Ítens de Distância.
# Para criar um ítem de distância, copie: Distance_Items[U] = [V, W, X, Y, Z] e mude:
# U:ID do item, V:Char, W:Index do Char, X:Velocidade, Y:Distância, Z:Tempo de espera para atacar
Distance_Items = {}
Distance_Items[16] = ["Energy Ball", 0, 5, 5, 30]
Distance_Items[18] = ["Energy Ball", 7, 5, 5, 30]
Distance_Items[20] = ["Energy Ball", 3, 5, 5, 30]
#------------------------------------------------------------------------------
# Itens com animação
# Para criar um ítem com animação, copie: Animate_Weapons[X] = ["Y", Z] e mude:
# X para o id da arma no database e Y para o prefixo do nome do char atacando, e Z para o Index do Char
Animate_Items = {}
Animate_Items[0] = ["_UsingItem", 0]
#------------------------------------------------------------------------------
# Som ao soltar item
# Para criar um item com som, copie: Item_Cast_SE[X] = "Y" e mude:
# X para o ID do item, e Y para o nome do som na pasta SE
Item_Cast_SE = {}
Item_Cast_SE[16] = "Fire1"
Item_Cast_SE[18] = "Ice1"
Item_Cast_SE[20] = "Thunder1"
#------------------------------------------------------------------------------
# Escudos, para que o herói use o escudo para se defender.
# Para criar um escudo, copie: Shields[X] = ["Y", Z] e mude:
# X para o id do escudo no database e Y para o prefixo do char usando o escudo, e Z para o index do char
Shields = {}
Shields[1] = ["_Shield", 0]
#------------------------------------------------------------------------------
# Drop
# Para criar o gráfico do item ao dropar, copie: Items_Drop[X] = ["Y",Z] e mude:
# X para o ID do ítem, Y para o Gráfico e Z para o index do grafico
Items_Drop = {}
Items_Drop[1] = ["Potions",0]
Items_Drop[2] = ["Potions",0]
Items_Drop[4] = ["Potions",1]

Weapons_Drop = {}
Weapons_Drop[0] = ["",0]

Armors_Drop = {}
Armors_Drop[0] = ["",0]
#------------------------------------------------------------------------------
Drop_Duration_Time = 800 # Tempo que o item fica no chão, após isso ele é deletado

Drop_Item_SE = "DropItem" # som quando o item é dropado
Drop_Money_SE = "DropMoney" # som quando o dinheiro é dropado
Get_Reward_SE = "GetReward" # som quando pega o item ou o dinheiro

Gold_Drop = ["$Gold",0] # Gáfico do dinheiro quando dropado
Default_Items_Drop = ["$Box",0] # Gráfico padrão dos itens dropados
Default_Weapons_Drop = ["$Box",0] # Gráfico padrão das armas droapadas
Default_Armors_Drop = ["$Box",0] # Gráfico padrão das armaduras dropadas
#------------------------------------------------------------------------------
# Animação qando o Herói passa de Level.
# Mude o 40 para o ID da animação.
LevelUp_Animation = 40
#------------------------------------------------------------------------------
# Animações do inimigo
# Copie  Enemy_animations[W] = [X, Y, Z] e mude:
# W para o ID do inimigo, X para o ID da animação do ataque do inimigo,
# Y para o ID da animação quando o inimigo morrer, e Z para o SE quando o inimigo morrer
Enemy_animations = {}
Enemy_animations[1] = [35,82,""]
Enemy_animations[2] = [7,82,""]
Enemy_animations[3] = [104,82,""]
Enemy_animations[4] = [50,82,""]
Enemy_animations[5] = [83,89,"Earth1"]
Enemy_animations[6] = [1,90,"DropMoney"]
Enemy_animations[7] = [0,96,""]
Enemy_animations[8] = [7,82,""]
Enemy_animations[9] = [89,83,""]
Enemy_animations[10] = [104,82,""]
Enemy_animations[11] = [104,97,""]
Enemy_animations[12] = [104,92,""]
Enemy_animations[13] = [104,82,""]
Enemy_animations[14] = [83,92,""]
Enemy_animations[15] = [104,92,""]
Enemy_animations[16] = [35,83,""]
Enemy_animations[17] = [104,92,""]
Enemy_animations[18] = [104,92,""]
Enemy_animations[19] = [104,92,""]
Enemy_animations[20] = [114,90,""]
Enemy_animations[21] = [55,83,""]
Enemy_animations[22] = [90,90,"Flash1"]
Enemy_animations[23] = [7,82,""]
Enemy_animations[24] = [7,82,""]
Enemy_animations[25] = [81,82,""]
Enemy_animations[26] = [7,82,""]
Enemy_animations[27] = [23,83,""]
Enemy_animations[28] = [35,97,""]
Enemy_animations[29] = [23,83,""]
Enemy_animations[31] = [104,92,""]
Enemy_animations[32] = [104,92,""]
Enemy_animations[33] = [83,92,""]
Enemy_animations[34] = [83,92,""]
Enemy_animations[35] = [125,82,""]
Enemy_animations[36] = [134,90,""]
Enemy_animations[37] = [134,90,""]
#------------------------------------------------------------------------------
end
#==============================================================================

#------------------------------------------------------------------------------
# Game Character
#------------------------------------------------------------------------------
class Game_Character
  alias crissaegrim_abs_gchar_initialize initialize
  attr_accessor :damage
  attr_accessor :critical
  def initialize
    crissaegrim_abs_gchar_initialize
    @damage = nil
    @critical = false
  end
  def move_toward(object)
    sx = distance_x_from(object)
    sy = distance_y_from(object)
    if sx != 0 or sy != 0
      if sx.abs > sy.abs
        sx > 0 ? move_left : move_right
        if @move_failed and sy != 0
          sy > 0 ? move_up : move_down
        end
      else
        sy > 0 ? move_up : move_down 
        if @move_failed and sx != 0
          sx > 0 ? move_left : move_right
        end
      end
    end
  end
  def distance_x_from(object)
    sx = @x - object.x
    if $game_map.loop_horizontal?
      if sx.abs > $game_map.width / 2
        sx -= $game_map.width
      end
    end
    return sx
  end
  def distance_y_from(object)
    sy = @y - object.y
    if $game_map.loop_vertical?
      if sy.abs > $game_map.height / 2
        sy -= $game_map.height
      end
    end
    return sy
  end
  def in_range?(element, object, range)
    x = (element.x - object.x) * (element.x - object.x)
    y = (element.y - object.y) * (element.y - object.y)
    r = x + y
    return true if r <= (range * range)
    return false
  end
  def in_direction?(element, object)
    return true if element.direction == 2 and object.y >= element.y and object.x == element.x
    return true if element.direction == 4 and object.x <= element.x and object.y == element.y
    return true if element.direction == 6 and object.x >= element.x and object.y == element.y
    return true if element.direction == 8 and object.y <= element.y and object.x == element.x
    return false
  end 
end

#------------------------------------------------------------------------------
# Game Event
#------------------------------------------------------------------------------
class Game_Event < Game_Character
  attr_reader :in_battle
  attr_reader :enemy_called
  attr_reader :kill_weapon
  attr_reader :kill_skill
  attr_reader :kill_item
  attr_reader :no_jump
  attr_accessor :skill_id
  attr_accessor :deffending
  alias crissaegrim_abs_gevent_initialize initialize
  alias crissaegrim_abs_gevent_update update
  alias crissaegrim_abs_gevent_refresh refresh
  def initialize(map_id, event)
    @enemy_id = 0
    @attack_time = 0
    @in_battle = false
    @deffending = false
    crissaegrim_abs_gevent_initialize(map_id, event)
  end
  def update
    crissaegrim_abs_gevent_update
    if @in_battle and !@enemy_called.dead?
      make_attack($data_enemies[@enemy_id])
    elsif @in_battle and @enemy_called.dead?
      @blend_type = 0
      kill_enemy
    end
    @attack_time -= 1 if @attack_time > 0
  end
  def refresh
    crissaegrim_abs_gevent_refresh
    @enemy_id = check_comment("Enemy")
    @follow_distance = check_comment("Follow")
    @erase = check_com("Die Erase")
    @no_jump = check_com("No Jump")
    @switch_local_a = check_com("Die Switch Local A")
    @switch_local_b = check_com("Die Switch Local B")
    @switch_local_c = check_com("Die Switch Local C")
    @switch_local_d = check_com("Die Switch Local D")
    @switch = check_comment("Die Switch")
    @variable = check_comment("Die Variable")
    @kill_weapon = check_comment("Kill Weapon")
    @kill_skill = check_comment("Kill Skill")
    @kill_item = check_comment("Kill Item")
    @Skill = check_comment("Gelo")
    @enemy_killed = false
    if @enemy_id > 0 and @in_battle == false
      @enemy_called = GameABS_Enemy.new(@enemy_id)
      @enemy_called.recover_all
      @in_battle = true
    elsif @enemy_id <= 0
      @in_battle = false
      @blend_type = 0
      @opacity = 255
    end
  end
  def make_attack(enemy)
    return false if $game_map.interpreter.running?
     for action in enemy.actions
       @ranting = action.rating if @attack_time <= 0
       next if enemy_pre_attack(@enemy_called, action)
       case action.kind
       when 0
         case action.basic
         when 0
           attack_normal
         when 1
           @deffending = true
         end
       when 1
         @skill_id = action.skill_id
         next if $data_skills[action.skill_id] == nil
         case $data_skills[action.skill_id].scope
         when 1..6
           if Crissaegrim_ABS::Distance_Skills.has_key?(action.skill_id)
             see_range = Crissaegrim_ABS::Distance_Skills[action.skill_id][3]
             if @direction == 2 and $game_player.x == @x and $game_player.y <= (@y + see_range) and $game_player.y > @y
               skill_range
             elsif @direction == 4 and $game_player.x >= (@x - see_range) and $game_player.x < @x and $game_player.y == @y
               skill_range
             elsif @direction == 6 and $game_player.x <= (@x + see_range) and $game_player.x > @x and $game_player.y == @y
               skill_range
             elsif @direction == 8 and $game_player.x == @x and $game_player.y >= (@y - see_range) and $game_player.y < @y
               skill_range
             elsif action.rating == 10
               skill_range
             end
           else
             skill_normal
           end
            when 7..11
              skill_recover
            end
          end
        end
      end
      def enemy_pre_attack(enemy, action)
       case action.condition_type
       when 1
         n = $game_troop.turn_count
         a = action.condition_param1
         b = action.condition_param2
         return false if (b == 0 and n != a)
         return false if (b > 0 and (n < 1 or n < a or n % b != a % b))
       when 2
         hp_rate = enemy.hp * 100.0 / enemy.maxhp
         return false if hp_rate < action.condition_param1
         return false if hp_rate > action.condition_param2
       when 3
         mp_rate = enemy.mp * 100.0 / enemy.maxmp
         return false if mp_rate < action.condition_param1
         return false if mp_rate > action.condition_param2
       when 4
         return false unless state?(action.condition_param1)
       when 5
         return false if $game_party.max_level < action.condition_param1
       when 6
         switch_id = action.condition_param1
         return false if $game_switches[switch_id] == false
       end
       r = rand(11)
       return true if action.rating < r
       return false
     end
     def attack_normal
       new_x = (@x + (@direction == 4 ? -1 : @direction == 6 ? 1 : 0))
       new_y = (@y + (@direction == 8 ? -1 : @direction == 2 ? 1 : 0))
       guard_x = (@x + ($game_player.direction == 4 ? 1 : $game_player.direction == 6 ? -1 : 0))
       guard_y = (@y + ($game_player.direction == 8 ? 1 : $game_player.direction == 2 ? -1 : 0))
       if $game_player.x == new_x and $game_player.y == new_y and @attack_time <= 0
         dmg = $game_party.members[0].make_attack_damage_value(@enemy_called)
         if Crissaegrim_ABS::Enemy_animations[@enemy_id] != nil and Crissaegrim_ABS::Enemy_animations[@enemy_id][0] != 0
           $game_player.animation_id = Crissaegrim_ABS::Enemy_animations[@enemy_id][0]
         else
           $game_player.animation_id = 1
         end
         if $game_player.deffending == true and $game_player.x == guard_x and $game_player.y == guard_y
           $game_player.damage = ""
         else
           $game_party.members[0].attack_effect(@enemy_called)
           $game_player.damage = dmg
           $game_player.jump(0,0)
         end
         @attack_time = 90
       end
     end
     def skill_normal
       new_x = (@x + (@direction == 4 ? -1 : @direction == 6 ? 1 : 0))
       new_y = (@y + (@direction == 8 ? -1 : @direction == 2 ? 1 : 0))
       guard_x = (@x + ($game_player.direction == 4 ? 1 : $game_player.direction == 6 ? -1 : 0))
       guard_y = (@y + ($game_player.direction == 8 ? 1 : $game_player.direction == 2 ? -1 : 0))
       if @enemy_called.mp >= $data_skills[@skill_id].mp_cost and $game_player.x == new_x and $game_player.y == new_y and @attack_time <= 0
         @enemy_called.mp -= $data_skills[@skill_id].mp_cost
         $game_temp.common_event_id = $data_skills[@skill_id].common_event_id if $data_skills[@skill_id].common_event_id > 0
         dmg = $game_party.members[0].make_obj_damage_value(@enemy_called, $data_skills[@skill_id])
         $game_player.animation_id = $data_skills[@skill_id].animation_id
         if $game_player.deffending == true and $game_player.x == guard_x and $game_player.y == guard_y and !$data_skills[@skill_id].ignore_defense
           $game_player.damage = ""
         else
           $game_party.members[0].skill_effect(@enemy_called, $data_skills[@skill_id])
           $game_player.damage = dmg
           $game_player.jump(0,0)
         end
         @attack_time = 90
       end
     end
     def skill_range
       if @enemy_called.mp >= $data_skills[@skill_id].mp_cost and @attack_time <= 0
         @enemy_called.mp -= $data_skills[@skill_id].mp_cost
         $game_temp.common_event_id = $data_skills[@skill_id].common_event_id if $data_skills[@skill_id].common_event_id > 0
         $game_range.push(Game_Range.new(self,Crissaegrim_ABS::Distance_Skills[@skill_id][0],Crissaegrim_ABS::Distance_Skills[@skill_id][1],Crissaegrim_ABS::Distance_Skills[@skill_id][2],Crissaegrim_ABS::Distance_Skills[@skill_id][3]))
         @attack_time = Crissaegrim_ABS::Distance_Skills[@skill_id][4]
         Audio.se_play("Audio/SE/"+Crissaegrim_ABS::Skill_Cast_SE[@skill_id],80,100) if Crissaegrim_ABS::Skill_Cast_SE[@skill_id] != nil and Crissaegrim_ABS::Skill_Cast_SE[@skill_id] != ""
       end
     end
     def skill_recover
       hp_percent = (@enemy_called.maxhp * 25) / 100
       if @enemy_called.mp >= $data_skills[@skill_id].mp_cost and @enemy_called.hp <= hp_percent
         @enemy_called.mp -= $data_skills[@skill_id].mp_cost
         $game_temp.common_event_id = $data_skills[@skill_id].common_event_id if $data_skills[@skill_id].common_event_id > 0
         rec = @enemy_called.make_obj_damage_value(@enemy_called, $data_skills[@skill_id])
         @enemy_called.skill_effect(@enemy_called, $data_skills[@skill_id])
         self.damage = rec
         @animation_id = $data_skills[@skill_id].animation_id
       end
       @attack_time = 90
     end
     def update_self_movement
       if in_range?(self,$game_player,@follow_distance) and @stop_count > 30 * (5 - @move_frequency)
         return unless movable?
         move_toward_player
       elsif @stop_count > 30 * (5 - @move_frequency)
         case @move_type
         when 1;  move_type_random
         when 2;  move_type_toward_player
         when 3;  move_type_custom
         end
       end
     end
     def movable?
       return false if moving?
       return false if @move_route_forcing
       return true
     end
     def check_comment(comentario)
       com = comentario.downcase
       return 0 if @list.nil? or @list.size <= 0 
       for item in @list
         if item.code == 108 or item.code == 408
           if item.parameters[0].downcase =~ /#{com}[ ]?(\d+)?/
             return $1.to_i
           end
         end
       end
       return 0
     end
     def check_com(comentario)
       return false if @list.nil? or @list.size <= 0 
       for item in @list
         if item.code == 108 or item.code == 408
           if item.parameters[0].downcase.include?(comentario.downcase)
             return true
             end
           end
         end
       end
def kill_enemy
    if @opacity >= 250
    $game_party.members[0].gain_exp(@enemy_called.exp, 1)
    make_drop
  end
  if Crissaegrim_ABS::Enemy_animations[@enemy_id] != nil and Crissaegrim_ABS::Enemy_animations[@enemy_id][1] != 0
    @animation_id = Crissaegrim_ABS::Enemy_animations[@enemy_id][1]
  end
  if Crissaegrim_ABS::Enemy_animations[@enemy_id] != nil and Crissaegrim_ABS::Enemy_animations[@enemy_id][2] != "" 
    Audio.se_play("Audio/SE/"+Crissaegrim_ABS::Enemy_animations[@enemy_id][2],80,100)
  elsif @opacity >= 250
    Sound.play_enemy_collapse
  end
  if @blend_type = 0
  if @erase == true
    self.erase
  elsif @switch_local_a == true
    key = [$game_map.map_id, self.id, "A"]
  if $game_self_switches[key] == false
    $game_self_switches[key] = true
    elsif $game_self_switches[key] == true
      $game_self_switches[key] = false
    end
  elsif @switch_local_b == true
    key = [$game_map.map_id, self.id, "B"]
    if $game_self_switches[key] == false
      $game_self_switches[key] = true
    elsif $game_self_switches[key] == true
      $game_self_switches[key] = false
    end
  elsif @switch_local_c == true
    key = [$game_map.map_id, self.id, "C"]
    if $game_self_switches[key] == false
      $game_self_switches[key] = true
    elsif $game_self_switches[key] == true
      $game_self_switches[key] = false
    end
  elsif @switch_local_d == true
    key = [$game_map.map_id, self.id, "D"]
    if $game_self_switches[key] == false
      $game_self_switches[key] = true
    elsif $game_self_switches[key] == true
      $game_self_switches[key] = false
    end
  elsif @switch > 0 and
    if $game_switches[@switch] == false
      $game_switches[@switch] = true
    elsif $game_switches[@switch] == true
      $game_switches[@switch] = false
    end
  elsif @variable > 0
    $game_variables[@variable] += 1
  end
  @in_battle = false
  $game_map.need_refresh = true
end
end
def make_drop
  for item in make_items1
    next if item == nil
    case item
    when RPG::Item
      graphic = Crissaegrim_ABS::Default_Items_Drop[0]
      index = Crissaegrim_ABS::Default_Items_Drop[1]
      graphic = Crissaegrim_ABS::Items_Drop[item.id][0] if Crissaegrim_ABS::Items_Drop[item.id] != nil
      index = Crissaegrim_ABS::Items_Drop[item.id][1] if Crissaegrim_ABS::Items_Drop[item.id] != nil
      $game_drop.push(Game_Drop.new(self,graphic,index,[item],0))
    when RPG::Weapon
      graphic = Crissaegrim_ABS::Default_Weapons_Drop[0]
      index = Crissaegrim_ABS::Default_Weapons_Drop[1]
      graphic = Crissaegrim_ABS::Weapons_Drop[item.id][0] if Crissaegrim_ABS::Weapons_Drop[item.id] != nil
      index = Crissaegrim_ABS::Weapons_Drop[item.id][1] if Crissaegrim_ABS::Weapons_Drop[item.id] != nil
      $game_drop.push(Game_Drop.new(self,graphic,index,[item],0))
    when RPG::Armor
      graphic = Crissaegrim_ABS::Default_Armors_Drop[0]
      index = Crissaegrim_ABS::Default_Armors_Drop[1]
      graphic = Crissaegrim_ABS::Armors_Drop[item.id][0] if Crissaegrim_ABS::Armors_Drop[item.id] != nil
      index = Crissaegrim_ABS::Armors_Drop[item.id][1] if Crissaegrim_ABS::Armors_Drop[item.id] != nil
      $game_drop.push(Game_Drop.new(self,graphic,index,[item],0))
    end
  end
  for item in make_items2
   next if item == nil
   case item
    when RPG::Item
      graphic = Crissaegrim_ABS::Default_Items_Drop[0]
      index = Crissaegrim_ABS::Default_Items_Drop[1]
      graphic = Crissaegrim_ABS::Items_Drop[item.id][0] if Crissaegrim_ABS::Items_Drop[item.id] != nil
      index = Crissaegrim_ABS::Items_Drop[item.id][1] if Crissaegrim_ABS::Items_Drop[item.id] != nil
      $game_drop.push(Game_Drop.new(self,graphic,index,[item],0))
    when RPG::Weapon
      graphic = Crissaegrim_ABS::Default_Weapons_Drop[0]
      index = Crissaegrim_ABS::Default_Weapons_Drop[1]
      graphic = Crissaegrim_ABS::Weapons_Drop[item.id][0] if Crissaegrim_ABS::Weapons_Drop[item.id] != nil
      index = Crissaegrim_ABS::Weapons_Drop[item.id][1] if Crissaegrim_ABS::Weapons_Drop[item.id] != nil
      $game_drop.push(Game_Drop.new(self,graphic,index,[item],0))
    when RPG::Armor
      graphic = Crissaegrim_ABS::Default_Armors_Drop[0]
      index = Crissaegrim_ABS::Default_Armors_Drop[1]
      graphic = Crissaegrim_ABS::Armors_Drop[item.id][0] if Crissaegrim_ABS::Armors_Drop[item.id] != nil
      index = Crissaegrim_ABS::Armors_Drop[item.id][1] if Crissaegrim_ABS::Armors_Drop[item.id] != nil
      $game_drop.push(Game_Drop.new(self,graphic,index,[item],0))
    end
  end
  if @enemy_called.gold > 0
    $game_drop.push(Game_Drop.new(self,Crissaegrim_ABS::Gold_Drop[0],0,[],self.enemy_called.gold))
  end
end
def make_items1
  drop_items = []
  for di in [@enemy_called.drop_item1]
    next if di.kind == 0
    next if rand(di.denominator) != 0
    if di.kind == 1
      drop_items.push($data_items[di.item_id])
    elsif di.kind == 2
      drop_items.push($data_weapons[di.weapon_id])
    elsif di.kind == 3
      drop_items.push($data_armors[di.armor_id])
    end
  end
  return drop_items
end
def make_items2
  drop_items = []
  for di in [@enemy_called.drop_item2]
    next if di.kind == 0
    next if rand(di.denominator) != 0
    if di.kind == 1
      drop_items.push($data_items[di.item_id])
    elsif di.kind == 2
      drop_items.push($data_weapons[di.weapon_id])
    elsif di.kind == 3
      drop_items.push($data_armors[di.armor_id])
    end
  end
  return drop_items
end
end

#------------------------------------------------------------------------------
# Game Player
#------------------------------------------------------------------------------
class Game_Player < Game_Character
  attr_accessor :deffending
  attr_accessor :assigned_skill
  attr_accessor :assigned_item
  attr_accessor :right_attack
  attr_accessor :left_attack
  attr_accessor :skill_attack
  attr_accessor :item_attack
  alias crissaegrim_abs_gplayer_initialize initialize
  alias crissaegrim_abs_gplayer_update update
  alias crissaegrim_abs_gplayer_perform_transfer perform_transfer
  def initialize
    @old_character_name = @character_name
    @old_character_index = @character_index
    @right_attack_time = 0
    @left_attack_time = 0
    @skill_attack_time = 0
    @item_attack_time = 0
    @anime_attack_time = 0
    @recovery_time = 0
    @right_attack = false
    @left_attack = false
    @skill_attack = false
    @item_attack = false
    @deffending = false
    crissaegrim_abs_gplayer_initialize
  end
  def update
    crissaegrim_abs_gplayer_update
    @actor = $game_party.members[0]
    auto_recovery
    $game_temp.next_scene = "gameover" if $game_party.members[0].dead?
    @right_attack_time -= 1 if @right_attack_time > 0
    @left_attack_time -= 1 if @left_attack_time > 0
    @skill_attack_time -= 1 if @skill_attack_time > 0
    @item_attack_time -= 1 if @item_attack_time > 0
    @anime_attack_time -= 1 if @anime_attack_time > 0
    @recovery_time -= 1 if @recovery_time > 0
    if @anime_attack_time <= 0 and @deffending == false
      self.set_graphic($game_actors[$game_party.members[0].id].character_name, $game_actors[$game_party.members[0].id].character_index)
      @step_anime = false
    end
    if Input.trigger?(Crissaegrim_ABS::Right_Attack_Button) and @deffending == false
      @attack_weapon = @actor.weapon_id
      anime_hero_attack if @anime_attack_time <= 0
      if $game_switches[69]
        return
      end
      if Crissaegrim_ABS::Distance_Weapons.has_key?(@attack_weapon) and @attack_weapon != 0 and @right_attack_time <= 0
        @right_attack = true
        @left_attack = false
        @skill_attack = false
        @item_attack = false
        @deffending = false
        range_attack_right
        if $game_party.has_item?($data_items[Crissaegrim_ABS::Distance_Weapons[@attack_weapon][5]])
          Audio.se_play("Audio/SE/"+Crissaegrim_ABS::Weapon_Shot_SE[@attack_weapon],80,100) if Crissaegrim_ABS::Weapon_Shot_SE[@attack_weapon] != nil and Crissaegrim_ABS::Weapon_Shot_SE[@attack_weapon] != ""
        else
          Sound.play_buzzer
        end
      else
        normal_attack_right
      end
    end
    if Input.pressed?(Crissaegrim_ABS::Left_Attack_and_Shield_Button)
      if !@actor.two_swords_style or !@actor.two_hands_legal? and @actor.armor1_id != 0
        use_shield
        @deffending = true
      end
    else
      @deffending = false
    end
    if Input.trigger?(Crissaegrim_ABS::Left_Attack_and_Shield_Button) and @deffending == false
      anime_hero_attack
      if @actor.two_swords_style
        @attack_weapon_and_Shield = @actor.armor1_id
      else
        @attack_weapon_and_Shield = @actor.weapon_id
      end
      if Crissaegrim_ABS::Distance_Weapons.has_key?(@attack_weapon_and_Shield) and @attack_weapon_and_Shield != 0 and @left_attack_time <= 0
        @right_attack = false
        @left_attack = true
        @skill_attack = false
        @item_attack = false
        range_attack_left
        if $game_party.has_item?($data_items[Crissaegrim_ABS::Distance_Weapons[@attack_weapon_and_Shield][5]])
          Audio.se_play("Audio/SE/"+Crissaegrim_ABS::Weapon_Shot_SE[@attack_weapon_and_Shield],80,100) if Crissaegrim_ABS::Weapon_Shot_SE[@attack_weapon_and_Shield] != nil and Crissaegrim_ABS::Weapon_Shot_SE[@attack_weapon_and_Shield] != ""
        else
          Sound.play_buzzer
        end
      else
        normal_attack_left
      end
    end
    if Crissaegrim_ABS::Skill_Button[@actor.id]!= nil
      for button in Crissaegrim_ABS::Skill_Button[@actor.id].keys
        if Input.trigger?(button) and Crissaegrim_ABS::Skill_Button[@actor.id][button] != nil and Crissaegrim_ABS::Skill_Button[@actor.id][button] != 0
          @assigned_skill = Crissaegrim_ABS::Skill_Button[@actor.id][button]
          case $data_skills[@assigned_skill].scope
          when 1
            if Crissaegrim_ABS::Distance_Skills.has_key?(@assigned_skill)
              @right_attack = false
              @left_attack = false
              @skill_attack = true
              @item_attack = false
              skill_attack_range
            else
              skill_attack_normal
            end
          when 2
            skill_attack_all
          when 7..11
            skill_recover
          end
        end
      end
    end
  for button in Crissaegrim_ABS::Item_Button.keys
    if Input.trigger?(button) and Crissaegrim_ABS::Item_Button[button] != nil and Crissaegrim_ABS::Item_Button[button] != 0
      @assigned_item = Crissaegrim_ABS::Item_Button[button]
      if Crissaegrim_ABS::Distance_Items.has_key?(@assigned_item)
        @right_attack = false
        @left_attack = false
        @skill_attack = false
        @item_attack = true
        item_attack_range
      else
        case $data_items[@assigned_item].scope
        when 1..6
          item_normal_attack
        when 7..11
          item_recover
        end
      end
    end
  end
end
def normal_attack_right
  if Input.trigger?(Crissaegrim_ABS::Right_Attack_Button)
    @attack_weapon = @actor.weapon_id
    for event in $game_map.events.values
      if event.in_battle
        return if event.enemy_called.dead?
        new_x = (@x + (@direction == 4 ? -1 : @direction == 6 ? 1 : 0))
        new_y = (@y + (@direction == 8 ? -1 : @direction == 2 ? 1 : 0))
        guard_x = (@x + (event.direction == 4 ? 1 : event.direction == 6 ? -1 : 0))
        guard_y = (@y + (event.direction == 8 ? 1 : event.direction == 2 ? -1 : 0))
        if event.x == new_x and event.y == new_y and @right_attack_time <= 0
          dmg = event.enemy_called.make_attack_damage_value(@actor)
          event.animation_id = @actor.atk_animation_id
          if event.deffending == true and event.x == guard_x and event.y == guard_y or event.kill_weapon > 0 and @attack_weapon != event.kill_weapon or event.kill_skill > 0 or event.kill_item > 0
            event.damage = ""
          else
            event.enemy_called.attack_effect(@actor)
            event.damage = dmg
            if event.no_jump != true
              event.jump(0,0)
            end
          end
          @right_attack_time = 15 - (@actor.agi / 100)
        end
      end
    end
  end
end
def range_attack_right
  if $game_party.has_item?($data_items[Crissaegrim_ABS::Distance_Weapons[@attack_weapon][5]])
    $game_party.consume_item($data_items[Crissaegrim_ABS::Distance_Weapons[@attack_weapon][5]])
    $game_range.push(Game_Range.new(self,Crissaegrim_ABS::Distance_Weapons[@attack_weapon][0],Crissaegrim_ABS::Distance_Weapons[@attack_weapon][1],Crissaegrim_ABS::Distance_Weapons[@attack_weapon][2],Crissaegrim_ABS::Distance_Weapons[@attack_weapon][3]))
    @right_attack_time = Crissaegrim_ABS::Distance_Weapons[@attack_weapon][4]
  end
end
def normal_attack_left
  for event in $game_map.events.values
    if event.in_battle
      return if event.enemy_called.dead?
       new_x = (@x + (@direction == 4 ? -1 : @direction == 6 ? 1 : 0))
       new_y = (@y + (@direction == 8 ? -1 : @direction == 2 ? 1 : 0))
       guard_x = (@x + (event.direction == 4 ? 1 : event.direction == 6 ? -1 : 0))
       guard_y = (@y + (event.direction == 8 ? 1 : event.direction == 2 ? -1 : 0))
      if event.x == new_x and event.y == new_y and @left_attack_time <= 0
        dmg = event.enemy_called.make_attack_damage_value(@actor)
        event.animation_id = @actor.atk_animation_id2
        if event.deffending == true and event.x == guard_x and event.y == guard_y or event.kill_weapon > 0 and @attack_weapon_and_Shield != event.kill_weapon or event.kill_skill > 0 or event.kill_item > 0
          event.damage = ""
        else
          event.enemy_called.attack_effect(@actor)
          event.damage = dmg
          if event.no_jump != true
            event.jump(0,0)
          end
        end
        @left_attack_time = 15 - (@actor.agi / 100)
      end
    end
  end
end
def range_attack_left
  if $game_party.has_item?($data_items[Crissaegrim_ABS::Distance_Weapons[@attack_weapon_and_Shield][6]])
    $game_party.consume_item($data_items[Crissaegrim_ABS::Distance_Weapons[@attack_weapon_and_Shield][6]])
    $game_range.push(Game_Range.new(self,Crissaegrim_ABS::Distance_Weapons[@attack_weapon_and_Shield][0],Crissaegrim_ABS::Distance_Weapons[@attack_weapon_and_Shield][1],Crissaegrim_ABS::Distance_Weapons[@attack_weapon_and_Shield][2],Crissaegrim_ABS::Distance_Weapons[@attack_weapon_and_Shield][3]))
    @left_attack_time = Crissaegrim_ABS::Distance_Weapons[@attack_weapon_and_Shield][4]
  end
end
def skill_attack_normal
  for event in $game_map.events.values
    if event.in_battle
      return if event.enemy_called.dead?
      new_x = (@x + (@direction == 4 ? -1 : @direction == 6 ? 1 : 0))
      new_y = (@y + (@direction == 8 ? -1 : @direction == 2 ? 1 : 0))
      guard_x = (@x + (event.direction == 4 ? 1 : event.direction == 6 ? -1 : 0))
      guard_y = (@y + (event.direction == 8 ? 1 : event.direction == 2 ? -1 : 0))
      if event.x == new_x and event.y == new_y and @skill_attack_time <= 0
        if @actor.mp >= $data_skills[@assigned_skill].mp_cost and @skill_attack_time <= 0
          @actor.mp -= @actor.calc_mp_cost($data_skills[@assigned_skill])
          $game_temp.common_event_id = $data_skills[@assigned_skill].common_event_id if $data_skills[@assigned_skill].common_event_id > 0
          dmg = event.enemy_called.make_obj_damage_value(@actor, $data_skills[@assigned_skill])
          event.animation_id = $data_skills[@assigned_skill].animation_id
          if event.deffending == true and event.x == guard_x and event.y == guard_y or event.kill_weapon > 0 or event.kill_skill > 0 or event.kill_item > 0 and !$data_skills[@assigned_skill].ignore_defense
            event.damage = ""
          else
            event.enemy_called.effect_skill(@actor, $data_skills[@assigned_skill])
            event.damage = dmg
          if event.no_jump != true
            event.jump(0,0)
          end
          end
          @skill_attack_time = 60 - (@actor.agi / 100)
        end
      end
    end
  end
end
def skill_attack_range
  if @actor.mp >= $data_skills[@assigned_skill].mp_cost and @skill_attack_time <= 0
    @actor.mp -= @actor.calc_mp_cost($data_skills[@assigned_skill])
    $game_temp.common_event_id = $data_skills[@assigned_skill].common_event_id if $data_skills[@assigned_skill].common_event_id > 0
    $game_range.push(Game_Range.new(self,Crissaegrim_ABS::Distance_Skills[@assigned_skill][0],Crissaegrim_ABS::Distance_Skills[@assigned_skill][1],Crissaegrim_ABS::Distance_Skills[@assigned_skill][2],Crissaegrim_ABS::Distance_Skills[@assigned_skill][3]))
    @skill_attack_time = Crissaegrim_ABS::Distance_Skills[@assigned_skill][4]
    Audio.se_play("Audio/SE/"+Crissaegrim_ABS::Skill_Cast_SE[@assigned_skill],80,100) if Crissaegrim_ABS::Skill_Cast_SE[@assigned_skill] != nil and Crissaegrim_ABS::Skill_Cast_SE[@assigned_skill] != ""
  end
end
def skill_attack_all
  for event in $game_map.events.values
    if event.in_battle
      return if event.enemy_called.dead?
      if @actor.mp >= $data_skills[@assigned_skill].mp_cost and @skill_attack_time <= 0
         @actor.mp -= @actor.calc_mp_cost($data_skills[@assigned_skill])
         $game_temp.common_event_id = $data_skills[@assigned_skill].common_event_id if $data_skills[@assigned_skill].common_event_id > 0
         dmg = event.enemy_called.make_obj_damage_value(@actor, $data_skills[@assigned_skill])
         event.animation_id = $data_skills[@assigned_skill].animation_id
         if event.deffending == true and event.x == guard_x and event.y == guard_y or event.kill_weapon > 0 or event.kill_skill > 0 or event.kill_item > 0 and !$data_skills[@assigned_skill].ignore_defense
           event.damage = ""
         else
           event.enemy_called.effect_skill(@actor, $data_skills[@assigned_skill])
           event.damage = dmg
          if event.no_jump != true
            event.jump(0,0)
          end
         end
         @skill_attack_time = 60 - (@actor.agi / 100)
       end
     end
   end
 end
def skill_recover
  if @actor.mp >= $data_skills[@assigned_skill].mp_cost and @skill_attack_time <= 0
    @actor.mp -= @actor.calc_mp_cost($data_skills[@assigned_skill])
    $game_temp.common_event_id = $data_skills[@assigned_skill].common_event_id if $data_skills[@assigned_skill].common_event_id > 0
    dmg = @actor.make_obj_damage_value(@actor, $data_skills[@assigned_skill])
    @actor.skill_effect(@actor, $data_skills[@assigned_skill])
    @animation_id = $data_skills[@assigned_skill].animation_id
    @damage = dmg
    @skill_attack_time = 60 - (@actor.agi / 100)
  end
end
def item_normal_attack
  for event in $game_map.events.values
    if event.in_battle
      return if event.enemy_called.dead?
      new_x = (@x + (@direction == 4 ? -1 : @direction == 6 ? 1 : 0))
      new_y = (@y + (@direction == 8 ? -1 : @direction == 2 ? 1 : 0))
      guard_x = (@x + (event.direction == 4 ? 1 : event.direction == 6 ? -1 : 0))
      guard_y = (@y + (event.direction == 8 ? 1 : event.direction == 2 ? -1 : 0))
      if event.x == new_x and event.y == new_y and @item_attack_time <= 0
        if $game_party.has_item?($data_items[@assigned_item]) and @item_attack_time <= 0
          $game_party.consume_item($data_items[@assigned_item])
          $game_temp.common_event_id = $data_items[@assigned_item].common_event_id if $data_items[@assigned_item].common_event_id > 0
          dmg = event.enemy_called.make_obj_damage_value(@actor, $data_items[@assigned_item])
          event.animation_id = $data_items[@assigned_item].animation_id
        if event.deffending == true and event.x == guard_x and event.y == guard_y or event.kill_weapon > 0 or event.kill_skill > 0 or event.kill_item > 0 and !$data_items[@assigned_item].ignore_defense
          event.damage = ""
        else
          event.enemy_called.effect_item(@actor, $data_items[@assigned_item])
          event.damage = dmg
          if event.no_jump != true
            event.jump(0,0)
          end
        end
        @item_attack_time = 60 - (@actor.agi / 100)
      end
    end
  end
end
end
def item_attack_range
  if $game_party.has_item?($data_items[@assigned_item]) and @item_attack_time <= 0
    $game_party.consume_item($data_items[@assigned_item])
    $game_temp.common_event_id = $data_items[@assigned_item].common_event_id if $data_items[@assigned_item].common_event_id > 0
    $game_range.push(Game_Range.new(self,Crissaegrim_ABS::Distance_Items[@assigned_item][0],Crissaegrim_ABS::Distance_Items[@assigned_item][1],Crissaegrim_ABS::Distance_Items[@assigned_item][2],Crissaegrim_ABS::Distance_Items[@assigned_item][3]))
    @item_attack_time = Crissaegrim_ABS::Distance_Items[@assigned_item][4]
    Audio.se_play("Audio/SE/"+Crissaegrim_ABS::Item_Cast_SE[@assigned_item],80,100) if Crissaegrim_ABS::Item_Cast_SE[@assigned_item] != nil and Crissaegrim_ABS::Item_Cast_SE[@assigned_item] != ""
  end
end
def item_recover
  if $game_party.has_item?($data_items[@assigned_item]) and @item_attack_time <= 0
    $game_party.consume_item($data_items[@assigned_item])
    $game_temp.common_event_id = $data_items[@assigned_item].common_event_id if $data_items[@assigned_item].common_event_id > 0
    dmg = @actor.calc_mp_recovery(@actor, $data_items[@assigned_item]) if $data_items[@assigned_item].hp_recovery > 0
    dmg = @actor.calc_hp_recovery(@actor, $data_items[@assigned_item]) if $data_items[@assigned_item].mp_recovery > 0
    @actor.item_effect(@actor, $data_items[@assigned_item])
    @animation_id = $data_items[@assigned_item].animation_id
    @damage = dmg
    @item_attack_time = 60 - (@actor.agi / 100)
  end
end
def anime_hero_attack
  if @attack_weapon != 0 and Crissaegrim_ABS::Animate_Weapons[@attack_weapon] != nil and Crissaegrim_ABS::Animate_Weapons[@attack_weapon] != 0 and Crissaegrim_ABS::Animate_Weapons[@attack_weapon][0] != "" and @anime_attack_time <= 0
    self.set_graphic(@character_name + Crissaegrim_ABS::Animate_Weapons[@attack_weapon][0], Crissaegrim_ABS::Animate_Weapons[@attack_weapon][1])
    @step_anime = true
    @anime_attack_time = 30
  end
end
def use_shield
  if Crissaegrim_ABS::Shields[@actor.armor1_id] != nil and Crissaegrim_ABS::Shields[@actor.armor1_id] != 0 and Crissaegrim_ABS::Shields[@actor.armor1_id][0] != ""
    self.set_graphic($game_actors[$game_party.members[0].id].character_name + Crissaegrim_ABS::Shields[@actor.armor1_id][0], Crissaegrim_ABS::Shields[@actor.armor1_id][1])
  end
end
def auto_recovery
  if $game_party.members[0].auto_hp_recover and @recovery_time <= 0
    hp_percent = $game_party.members[0].maxhp / 10
    $game_party.members[0].hp += hp_percent
    @recovery_time = 1800
  end
end
def perform_transfer
  crissaegrim_abs_gplayer_perform_transfer
  for range in $game_range
    next if range == nil
    range.destroy = true
  end
  for drop in $game_drop
    next if drop == nil
    drop.destroy = true
  end
end
end

#------------------------------------------------------------------------------
# Game Range
#------------------------------------------------------------------------------
class Game_Range < Game_Character
  attr_accessor :draw
  attr_accessor :destroy
  attr_accessor :character_name
  def initialize(parent,chara_name="",chara_index=0,speed=4,range=0)
    super()
    @parent = parent
    @character_name = chara_name
    @character_index = chara_index
    @move_speed = speed
    @range = range
    @step = 0
    moveto(@parent.x,@parent.y)
    pd = @parent.direction
    turn_down if pd == 2
    turn_left if pd == 4
    turn_right if pd == 6
    turn_up if pd == 8
    @destroy = false
    @draw = false
    @map_passable = true # parent.is_a?(Game_Event)
  end
  def update
    super
    return @destroy = true if @step >= @range
    move_route
    check_event_trigger_touch(@x, @y)
  end
  def move_route
    return unless movable?
    d = @direction
    move_down if d == 2
    move_left if d == 4
    move_right if d == 6
    move_up if d == 8
    @step += 1
  end
  def movable?
    return false if moving?
    return false if @move_route_forcing
    return true
  end
  def check_event_trigger_touch(x, y)
    return if @destroy
    for event in $game_map.events.values
      if event.in_battle
        hurt_hero(@parent) if $game_player.x == x and $game_player.y == y and @parent.is_a?(Game_Event)
        hurt_enemy_weapon_right(event) if event.x == x and event.y == y and $game_player.right_attack == true and @parent.is_a?(Game_Player)
        hurt_enemy_weapon_left(event) if event.x == x and event.y == y and $game_player.left_attack == true and @parent.is_a?(Game_Player)
        hurt_enemy_skill(event) if event.x == x and event.y == y and $game_player.skill_attack == true and @parent.is_a?(Game_Player)
        hurt_enemy_item(event) if event.x == x and event.y == y and $game_player.item_attack == true and @parent.is_a?(Game_Player)
      end
    end
  end
  def hurt_hero(enemy)
    @destroy = true
    moveto(0,0)
    dmg = $game_party.members[0].make_obj_damage_value(enemy.enemy_called, $data_skills[enemy.skill_id])
    $game_player.animation_id = $data_skills[enemy.skill_id].animation_id
    if $game_player.deffending == true and guard($game_player, enemy) and !$data_skills[enemy.skill_id].ignore_defense
      $game_player.damage = ""
    else
      $game_party.members[0].skill_effect(enemy.enemy_called, $data_skills[enemy.skill_id])
      $game_player.damage = dmg
      $game_player.jump(0,0)
    end
  end
  def hurt_enemy_weapon_right(enemy)
    @destroy = true
    moveto(0,0)
    return if enemy.enemy_called.dead?
    guard_x = (@x + (enemy.direction == 4 ? 1 : enemy.direction == 6 ? -1 : 0))
    guard_y = (@y + (enemy.direction == 8 ? 1 : enemy.direction == 2 ? -1 : 0))
    dmg = enemy.enemy_called.make_attack_damage_value($game_party.members[0])
    enemy.animation_id = $data_items[Crissaegrim_ABS::Distance_Weapons[$game_party.members[0].weapon_id][5]].animation_id
    if enemy.deffending == true and guard(self, enemy) or enemy.kill_weapon > 0 and $game_party.members[0].weapon_id != enemy.kill_weapon or enemy.kill_skill > 0 or enemy.kill_item > 0
      enemy.damage = ""
    else
      enemy.enemy_called.attack_effect($game_party.members[0])
      enemy.damage = dmg
      if enemy.no_jump != true
        enemy.jump(0,0)
      end
    end
  end
  def hurt_enemy_weapon_left(enemy)
    @destroy = true
    moveto(0,0)
    return if enemy.enemy_called.dead?
    guard_x = (@x + (enemy.direction == 4 ? 1 : enemy.direction == 6 ? -1 : 0))
    guard_y = (@y + (enemy.direction == 8 ? 1 : enemy.direction == 2 ? -1 : 0))
    dmg = enemy.enemy_called.make_attack_damage_value($game_party.members[0])
    if $game_party.members[0].two_swords_style
      @weapon = $game_party.members[0].armor1_id
    else
      @weapon = $game_party.members[0].weapon_id
    end
    enemy.animation_id = $data_items[Crissaegrim_ABS::Distance_Weapons[@weapon][6]].animation_id
    if enemy.deffending == true and guard(self, enemy) or enemy.kill_weapon > 0 and @weapon != enemy.kill_weapon or enemy.kill_skill > 0 or enemy.kill_item > 0
      enemy.damage = ""
    else
      enemy.enemy_called.attack_effect($game_party.members[0])
      enemy.damage = dmg
      if enemy.no_jump != true
        enemy.jump(0,0)
      end
    end
  end
  def hurt_enemy_skill(enemy)
    @destroy = true
    moveto(0,0)
    return if enemy.enemy_called.dead?
    guard_x = (@x + (enemy.direction == 4 ? 1 : enemy.direction == 6 ? -1 : 0))
    guard_y = (@y + (enemy.direction == 8 ? 1 : enemy.direction == 2 ? -1 : 0))
    skl = $game_player.assigned_skill
    dmg = enemy.enemy_called.make_obj_damage_value($game_party.members[0], $data_skills[skl])
    enemy.animation_id = $data_skills[skl].animation_id
    if enemy.deffending == true and guard(self, enemy) or enemy.kill_weapon > 0 or enemy.kill_skill > 0 and $game_player.assigned_skill != enemy.kill_skill or enemy.kill_item > 0
      enemy.damage = ""
    else
      enemy.enemy_called.effect_skill($game_party.members[0],$data_skills[skl])
      enemy.damage = dmg
      if enemy.no_jump != true
        enemy.jump(0,0)
      end
    end
  end
  def hurt_enemy_item(enemy)
    @destroy = true
    moveto(0,0)
    return if enemy.enemy_called.dead?
    guard_x = (@x + (enemy.direction == 4 ? 1 : enemy.direction == 6 ? -1 : 0))
    guard_y = (@y + (enemy.direction == 8 ? 1 : enemy.direction == 2 ? -1 : 0))
    itm = $game_player.assigned_item
    dmg = enemy.enemy_called.make_obj_damage_value($game_party.members[0], $data_items[itm])
    enemy.animation_id = $data_items[itm].animation_id
    if enemy.deffending == true and guard(self, enemy) or enemy.kill_weapon > 0 or enemy.kill_skill > 0 or enemy.kill_item > 0 and $game_player.assigned_item != enemy.kill_item
      enemy.damage = ""
    else
      enemy.enemy_called.effect_item($game_party.members[0],$data_items[itm])
      enemy.damage = dmg
      if enemy.no_jump != true
        enemy.jump(0,0)
      end
    end
  end
  def guard(attacker, target)
    if attacker.direction == 2 and target.direction == 8
      return true
    elsif attacker.direction == 4 and target.direction == 6
      return true
    elsif attacker.direction == 6 and target.direction == 4
      return true
    elsif attacker.direction == 8 and target.direction == 2
      return true
    else
      return false
    end
  end
end

#------------------------------------------------------------------------------
# Game Drop
#------------------------------------------------------------------------------
class Game_Drop < Game_Character
  attr_accessor :draw
  attr_accessor :destroy
  attr_accessor :character_name
  def initialize(parent,chara_name="",chara_index=0,items=[],gold=0)
    super()
    @character_name = chara_name
    @character_index = chara_index
    @items = items
    @gold = gold
    @drop_time = Crissaegrim_ABS::Drop_Duration_Time
    moveto(parent.x,parent.y)
    #move_random
    Audio.se_play("Audio/SE/"+Crissaegrim_ABS::Drop_Item_SE,100,100) if Crissaegrim_ABS::Drop_Item_SE != "" and @items != nil
    Audio.se_play("Audio/SE/"+Crissaegrim_ABS::Drop_Money_SE,100,100) if Crissaegrim_ABS::Drop_Money_SE != "" and @gold > 0
    @destroy = false
    @draw = false
  end
  def update
    super
    return if @destroy == true
    if Input.trigger?(Input::Y) || Input.trigger?(Input::C)
      if in_range?($game_player,self,1) and in_direction?($game_player,self)
        get_reward
      end
    end
    @drop_time -= 1 if @drop_time > 0
    @destroy = true if @drop_time <= 0
  end
  def get_reward
    Audio.se_play("Audio/SE/"+Crissaegrim_ABS::Get_Reward_SE,100,100) if Crissaegrim_ABS::Get_Reward_SE != ""
    $game_party.gain_gold(@gold)
    for item in @items
      case item
      when RPG::Item
        $game_party.gain_item($data_items[item.id],1)
      when RPG::Weapon
        $game_party.gain_item($data_weapons[item.id],1)
      when RPG::Armor
        $game_party.gain_item($data_armors[item.id],1)
      end
    end
    @destroy = true
  end
  def move_random
    return false if moving?
    case rand(3)
    when 0
      move_down
    when 1
      move_left
    when 2
      move_right
    when 3
      move_up
    end
  end
  def check_event_trigger_touch(x, y)
  end
end

#------------------------------------------------------------------------------
# Game ABS Enemy
#------------------------------------------------------------------------------
class GameABS_Enemy < Game_Battler
  attr_reader   :enemy_id
  def initialize(enemy_id)
    super()
    @enemy_id = enemy_id
    enemy = $data_enemies[@enemy_id]
  end
  def actor?
    return false
  end
  def enemy
    return $data_enemies[@enemy_id]
  end
  def base_maxhp
    return enemy.maxhp
  end
  def base_maxmp
    return enemy.maxmp
  end
  def base_atk
    return enemy.atk
  end
  def base_def
    return enemy.def
  end
  def base_spi
    return enemy.spi
  end
  def base_agi
    return enemy.agi
  end
  def hit
    return enemy.hit
  end
  def eva
    return enemy.eva
  end
  def cri
    return enemy.has_critical ? 10 : 0
  end
  def odds
    return 1
  end
  def element_rate(element_id)
    rank = enemy.element_ranks[element_id]
    result = [0,200,150,100,50,0,-100][rank]
    for state in states
      result /= 2 if state.element_set.include?(element_id)
    end
    return result
  end
  def state_probability(state_id)
    if $data_states[state_id].nonresistance
      return 100
    else
      rank = enemy.state_ranks[state_id]
      return [0,100,80,60,40,20,0][rank]
    end
  end
  def exp
    return enemy.exp
  end
  def gold
    return enemy.gold
  end
  def drop_item1
    return enemy.drop_item1
  end
  def drop_item2
    return enemy.drop_item2
  end
  def use_sprite?
    return true
  end
  def perform_collapse
    if $game_temp.in_battle and dead?
      @collapse = true
      Sound.play_enemy_collapse
    end
  end
  def escape
    @hidden = true
    @action.clear
  end
  def transform(enemy_id)
    @enemy_id = enemy_id
    if enemy.name != @original_name
      @original_name = enemy.name
      @letter = ''
      @plural = false
    end
    @battler_name = enemy.battler_name
    @battler_hue = enemy.battler_hue
    make_action
  end
  def conditions_met?(action)
    case action.condition_type
    when 1
      n = $game_troop.turn_count
      a = action.condition_param1
      b = action.condition_param2
      return false if (b == 0 and n != a)
      return false if (b > 0 and (n < 1 or n < a or n % b != a % b))
    when 2
      hp_rate = hp * 100.0 / maxhp
      return false if hp_rate < action.condition_param1
      return false if hp_rate > action.condition_param2
    when 3
      mp_rate = mp * 100.0 / maxmp
      return false if mp_rate < action.condition_param1
      return false if mp_rate > action.condition_param2
    when 4
      return false unless state?(action.condition_param1)
    when 5
      return false if $game_party.max_level < action.condition_param1
    when 6
      switch_id = action.condition_param1
      return false if $game_switches[switch_id] == false
    end
    return true
  end
  def make_action
    @action.clear
    return unless movable?
    available_actions = []
    rating_max = 0
    for action in enemy.actions
      next unless conditions_met?(action)
      if action.kind == 1
        next unless skill_can_use?($data_skills[action.skill_id])
      end
      available_actions.push(action)
      rating_max = [rating_max, action.rating].max
    end
    ratings_total = 0
    rating_zero = rating_max - 3
    for action in available_actions
      next if action.rating <= rating_zero
      ratings_total += action.rating - rating_zero
    end
    return if ratings_total == 0
    value = rand(ratings_total)
    for action in available_actions
      next if action.rating <= rating_zero
      if value < action.rating - rating_zero
        @action.kind = action.kind
        @action.basic = action.basic
        @action.skill_id = action.skill_id
        @action.decide_random_target
        return
      else
        value -= action.rating - rating_zero
      end
    end
  end
end

#------------------------------------------------------------------------------
# Game Battler
#------------------------------------------------------------------------------
class Game_Battler
def effect_skill(user, skill)
  clear_action_results
  if rand(100) >= calc_hit(user, skill)
    @missed = true
    return
  end
  if rand(100) < calc_eva(user, skill)
    @evaded = true
    return
  end
  make_obj_damage_value(user, skill)
  make_obj_absorb_effect(user, skill)
  execute_damage(user)
  if skill.physical_attack and @hp_damage == 0
    return                                    
  end
  apply_state_changes(skill)
end
def effect_item(user, item)
  clear_action_results
  if rand(100) >= calc_hit(user, item)
    @missed = true
    return
  end
  if rand(100) < calc_eva(user, item)
    @evaded = true
    return
  end
  hp_recovery = calc_hp_recovery(user, item)
  mp_recovery = calc_mp_recovery(user, item)
  make_obj_damage_value(user, item)
  @hp_damage -= hp_recovery
  @mp_damage -= mp_recovery
  make_obj_absorb_effect(user, item)
  execute_damage(user)
  item_growth_effect(user, item)
  if item.physical_attack and @hp_damage == 0
    return                                    
  end
  apply_state_changes(item)
end
end

#------------------------------------------------------------------------------
# Game Actor
#------------------------------------------------------------------------------
class Game_Actor
  alias crissaegrim_abs_change_exp change_exp
  def change_exp(exp, show)
    last_level = @level
    last_skills = skills
    @exp = [[exp, 9999999].min, 0].max
    while @exp >= @exp_list[@level+1] and @exp_list[@level+1] > 0
      level_up
    end
    while @exp < @exp_list[@level]
      level_down
    end
    @hp = [@hp, maxhp].min
    @mp = [@mp, maxmp].min
    if show and @level > last_level
      show_level_up
    end
    crissaegrim_abs_change_exp(exp,show)
  end
  def show_level_up
    $game_player.animation_id = Crissaegrim_ABS::LevelUp_Animation
    $game_party.members[0].hp = $game_party.members[0].maxhp
    $game_party.members[0].mp = $game_party.members[0].maxmp
    $game_player.damage = "Level Up"
  end
  def atk_animation_id2
    if two_swords_style
      return weapons[1] == nil ? 1 : weapons[1].animation_id
    else
      return 1
    end
  end
end

#------------------------------------------------------------------------------
# Game Map
#------------------------------------------------------------------------------
class Game_Map
  def passable?(x, y, flag = 0x01)
    for drop in $game_drop
      next if drop.nil?
      return false if drop.x == x and drop.y == y
    end
    for event in events_xy(x, y)
      next if event.tile_id == 0
      next if event.priority_type > 0
      next if event.through
      pass = @passages[event.tile_id]
      next if pass & 0x10 == 0x10
      return true if pass & flag == 0x00
      return false if pass & flag == flag
    end
    for i in [2, 1, 0]
      tile_id = @map.data[x, y, i]
      return false if tile_id == nil
      pass = @passages[tile_id]
      next if pass & 0x10 == 0x10
      return true if pass & flag == 0x00
      return false if pass & flag == flag
    end
    return false
  end
end

#------------------------------------------------------------------------------
# Sprite Base
#------------------------------------------------------------------------------
class Sprite_Base 
  alias animation animation_set_sprites
  def animation_set_sprites(frame)
    cell_data = frame.cell_data
    for i in 0..15
      sprite = @animation_sprites[i]
      next if sprite == nil
      pattern = cell_data[i, 0]
      if pattern == nil or pattern == -1
        sprite.visible = false
        next
      end
      if pattern < 100
        sprite.bitmap = @animation_bitmap1
      else
        sprite.bitmap = @animation_bitmap2
      end
      sprite.visible = true
      sprite.src_rect.set(pattern % 5 * 192,
        pattern % 100 / 5 * 192, 192, 192)
      if @animation_mirror
        sprite.x = @animation_ox - cell_data[i, 1] / 2
        sprite.y = @animation_oy - cell_data[i, 2] / 2
        sprite.angle = (360 - cell_data[i, 4])
        sprite.mirror = (cell_data[i, 5] == 0)
      else
        sprite.x = @animation_ox + cell_data[i, 1] / 2
        sprite.y = @animation_oy + cell_data[i, 2] / 2
        sprite.angle = cell_data[i, 4]
        sprite.mirror = (cell_data[i, 5] == 1)
      end
      sprite.z = self.z + 300
      sprite.ox = 96
      sprite.oy = 96
      sprite.zoom_x = cell_data[i, 3] / 200.0
      sprite.zoom_y = cell_data[i, 3] / 200.0
      sprite.opacity = cell_data[i, 6] * self.opacity / 255.0
      sprite.blend_type = cell_data[i, 7]
    end
  end
end

#------------------------------------------------------------------------------
# Sprite Character
#------------------------------------------------------------------------------
class Sprite_Character < Sprite_Base
  alias crissaegrim_abs_spchar_update update
  alias crissaegrim_abs_spchar_dispose dispose
  def initialize(viewport, character = nil)
    super(viewport)
    @character = character
    @balloon_duration = 0
    @_damage_duration = 0
    update
  end
  def update
    super
    if @_damage_duration > 0
      @_damage_duration -=1
        @_damage_sprite.x = self.x
        if @_damage_duration <= 0
          dispose_damage
        end
      end
      if @character != nil and @character.damage != nil
      damage(@character.damage, @character.critical)
      @character.damage = nil
      @character.critical = false
    end
    crissaegrim_abs_spchar_update
  end
  def dispose
    crissaegrim_abs_spchar_dispose
    dispose_damage
  end
  def damage(value, critical)
      dispose_damage
      if value.is_a?(Numeric)
        damage_string = value.abs.to_s
      else
        damage_string = value.to_s
      end
      bitmap = Bitmap.new(160, 48)
      bitmap.font.name = "Tahoma"
      bitmap.font.size = 22
      bitmap.font.italic = true
      if value.is_a?(Numeric) and value <= 0
        bitmap.font.color.set(255, 255, 128)
      else
        bitmap.font.color.set(255, 255, 255)
      end
      bitmap.draw_text(1, 13, 160, 36, damage_string, 1)
      bitmap.draw_text(0, 12, 160, 36, damage_string, 1)
      if critical
        bitmap.font.color.set(0, 0, 0)
        bitmap.draw_text(1, 6, 160, 20, "Critical", 1)
        bitmap.font.color.set(255, 255, 128)
        bitmap.draw_text(0, 5, 160, 20, "Critical", 1)
      end
      @_damage_sprite = ::Sprite.new(self.viewport)
      @_damage_sprite.bitmap = bitmap
      @_damage_sprite.ox = 80
      @_damage_sprite.oy = 20
      @_damage_sprite.x = self.x
      @_damage_sprite.y = self.y - self.oy / 2 - 40
      @_damage_sprite.z += 99999
      @_damage_duration = 30
    end
    def show_text(string, size=16, color=0)
      dispose_damage
      damage_string = string
      if string.is_a?(Array)
        array = true
      else
        array = false
      end
      bitmap = Bitmap.new(160, 48)
      bitmap.font.name = "Tahoma"
      bitmap.font.size = size
      bitmap.font.italic = true
      if array
        for i in 0..string.size
          next if damage_string[i] == nil
          bitmap.font.color.set(96, 96-20, 0) if color == 0
          bitmap.font.color.set(0, 0, 0) if color != 0 
          bitmap.draw_text(-1, (12+(16*i)-1)-16, 160, 36, damage_string[i], 1)
          bitmap.draw_text(+1, (12+(16*i)-1)-16, 160, 36, damage_string[i], 1)
          bitmap.draw_text(-1, (12+(16*i)+1)-16, 160, 36, damage_string[i], 1)
          bitmap.draw_text(+1, (12+(16*i)+1)-16, 160, 36, damage_string[i], 1)
          bitmap.font.color.set(255, 245, 155) if color == 0
          bitmap.font.color.set(144, 199, 150) if color == 1
          bitmap.font.color.set(197, 147, 190)if color == 2
          bitmap.font.color.set(138, 204, 198)if color == 3
          bitmap.draw_text(0, (12+(16*i))-16, 160, 36, damage_string[i], 1)
        end
      else
        bitmap.font.color.set(96, 96-20, 0) if color == 0
        bitmap.font.color.set(0, 0, 0) if color != 0 
        bitmap.draw_text(-1, 12-1, 160, 36, damage_string, 1)
        bitmap.draw_text(+1, 12-1, 160, 36, damage_string, 1)
        bitmap.draw_text(-1, 12+1, 160, 36, damage_string, 1)
        bitmap.draw_text(+1, 12+1, 160, 36, damage_string, 1)
        bitmap.font.color.set(255, 245, 155) if color == 0
        bitmap.font.color.set(144, 199, 150) if color == 1
        bitmap.font.color.set(197, 147, 190)if color == 2
        bitmap.font.color.set(138, 204, 198)if color == 3
        bitmap.draw_text(0, 12, 160, 36, damage_string, 1)
      end
      @_damage_sprite = ::Sprite.new(self.viewport)
      @_damage_sprite.bitmap = bitmap
      @_damage_sprite.ox = 80
      @_damage_sprite.oy = 20
      @_damage_sprite.x = self.x
      @_damage_sprite.y = self.y - self.oy / 2
      @_damage_sprite.z = 3000
      @_damage_duration = 30
    end 
    def dispose_damage
    if @_damage_sprite != nil
      @_damage_sprite.dispose
      @_damage_sprite = nil
    end
  end
end

#------------------------------------------------------------------------------
# Spriteset Map
#------------------------------------------------------------------------------
class Spriteset_Map
  alias crissaegrim_abs_sp_map_create_characters create_characters
  alias crissaegrim_abs_sp_map_update_characters update_characters
  alias crissaegrim_abs_sp_map_dispose dispose
  def create_characters
    @range_sprites = []
    for range in $game_range
      next if range == nil
      @range_sprites.push(Sprite_Character.new(@viewport1,range))
    end
    @drop_sprites = []
    for drop in $game_drop
      next if drop == nil
      @drop_sprites.push(Sprite_Character.new(@viewport1,drop))
    end
    crissaegrim_abs_sp_map_create_characters
  end
  def update_characters
    crissaegrim_abs_sp_map_update_characters
    for range in @range_sprites
      next if range == nil
      range.update
    end
    for drop in @drop_sprites
      next if drop == nil
      drop.update
    end
    for range in $game_range
      next if range == nil
      if range.draw == false
        @range_sprites.push(Sprite_Character.new(@viewport1,range))
        range.draw = true
      end
      if range.destroy == true
        $game_range.delete(range)
        range.character_name = ""
      end
    end
    for drop in $game_drop
      next if drop == nil
      if drop.draw == false
        @drop_sprites.push(Sprite_Character.new(@viewport1,drop))
        drop.draw = true
      end
      if drop.destroy == true
        $game_drop.delete(drop)
        drop.character_name = "" 
      end
    end
  end
  def dispose
    for range in @range_sprites
      next if range == nil
      range.dispose
    end
    for drop in @drop_sprites
      next if drop == nil
      drop.dispose
    end
    crissaegrim_abs_sp_map_dispose
  end
end

#------------------------------------------------------------------------------
# Scene Map
#------------------------------------------------------------------------------
class Scene_Map < Scene_Base
  alias crissaegrim_abs_smap_update update
  def update
    for range in $game_range
      next if range == nil
      range.update
    end
    for drop in $game_drop
      next if drop == nil
      drop.update
    end
    crissaegrim_abs_smap_update
  end
end

#------------------------------------------------------------------------------
# Scene File
#------------------------------------------------------------------------------
class Scene_File < Scene_Base
  alias crissaegrim_abs_sfile_write_save_data write_save_data
  alias crissaegrim_abs_sfile_read_save_data read_save_data
  def write_save_data(file)
    crissaegrim_abs_sfile_write_save_data(file)
    Marshal.dump($game_range,         file)
    Marshal.dump($game_drop,         file)
  end
  def read_save_data(file)
    crissaegrim_abs_sfile_read_save_data(file)
    $game_range         = Marshal.load(file)
    $game_drop          = Marshal.load(file)
  end
end

#------------------------------------------------------------------------------
# Scene Title
#------------------------------------------------------------------------------
class Scene_Title < Scene_Base
  alias crissaegrim_abs_scenetitle_command_new_game command_new_game
  def command_new_game
    $game_range = []
    $game_drop = []
    crissaegrim_abs_scenetitle_command_new_game
  end
end

#------------------------------------------------------------------------------
# Window Skill
#------------------------------------------------------------------------------
class Window_Skill < Window_Selectable
  def update_help
    if $skill_lock_description <= 0
      @help_window.set_text(skill == nil ? "" : skill.description)
    else
      @help_window.set_text(skill == nil ? "" : $local.get_text("skill-assigned"))
    end
  end
end
class Scene_Skill < Scene_Base
  alias crissaegrim_abs_sskill_start start
  alias crissaegrim_abs_sskill_update update
  alias crissaegrim_abs_sskill_update_skill_selection update_skill_selection
  alias crissaegrim_abs_sitem_use_skill_nontarget use_skill_nontarget
  def start
    $skill_lock_description = 0
    crissaegrim_abs_sskill_start
  end
  def update
    crissaegrim_abs_sskill_update
    $skill_lock_description -= 1 if $skill_lock_description > 0
  end
  def update_skill_selection
    if Crissaegrim_ABS::Skill_Button[@actor.id]!= nil
      for button in Crissaegrim_ABS::Skill_Button[@actor.id].keys
        if Input.trigger?(button)
          Sound.play_decision
          Crissaegrim_ABS::Skill_Button[@actor.id][button] = @skill_window.skill.id
          $skill_lock_description = 120
        end
      end
    end
    crissaegrim_abs_sskill_update_skill_selection
  end
  def use_skill_nontarget
    return if @skill.scope == 1 or
    @skill.scope == 2 or
    @skill.scope == 3 or
    @skill.scope == 4 or
    @skill.scope == 5 or
    @skill.scope == 6 or
    crissaegrim_abs_sitem_use_skill_nontarget
  end
end

#------------------------------------------------------------------------------
# Window Item
#------------------------------------------------------------------------------
class Window_Item < Window_Selectable
  alias crissaegrim_abs_witem_initialize initialize
  def initialize(x, y, width, height)
    $item_lock_description = 0
    crissaegrim_abs_witem_initialize(x, y, width, height)
  end
  def update_help
    if $item_lock_description <= 0
    @help_window.set_text(item == nil ? "" : item.description)
  else
    @help_window.set_text(item == nil ? "" : $local.get_text("item-assigned"))
  end
end
end
class Scene_Item < Scene_Base
  alias crissaegrim_abs_sitem_start start
  alias crissaegrim_abs_sitem_update update
  alias crissaegrim_abs_sitem_update_item_selection update_item_selection
  alias crissaegrim_abs_sitem_use_item_nontarget use_item_nontarget
  def start
    $item_lock_description = 0
    crissaegrim_abs_sitem_start
  end
  def update
    crissaegrim_abs_sitem_update
    $item_lock_description -= 1 if $item_lock_description > 0
  end
  def update_item_selection
    for button in Crissaegrim_ABS::Item_Button.keys
      if Input.trigger?(button)
        Sound.play_decision
        Crissaegrim_ABS::Item_Button[button] = @item_window.item.id
        $item_lock_description = 120
      end
    end
    crissaegrim_abs_sitem_update_item_selection
  end
  def use_item_nontarget
    return if @item.scope == 1 or
    @item.scope == 2 or
    @item.scope == 3 or
    @item.scope == 4 or
    @item.scope == 5 or
    @item.scope == 6 or
    crissaegrim_abs_sitem_use_item_nontarget
  end
end

#------------------------------------------------------------------------------
# Fim do ABS
#------------------------------------------------------------------------------