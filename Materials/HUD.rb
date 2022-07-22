#==============================================================================
# Crissaegrim HUD
#==============================================================================
module Crissaegrim_Hud
  
Background = "HUD-Background" # Imagem de fundo da hud

HP_Bar = "HP-Bar" # Imagem da barra de HP

MP_Bar = "MP-Bar" # Imagem da barra de MP

Base = "Bars-Base" # Imagm do fundo das barras

Q_Bar = "Q-Bar" # Add by Ste

OnOff_Hud_Switch = 40 # Switch que ativa / desativa a HUD

Show_Hide_Button = Input::Fkeys[12] # Tecla que mostra / esconde a HUD

end
#------------------------------------------------------------------------------
class Window_CrissaegrimHud < Window_Base
  def initialize
    super(0,0,544,416)
    self.opacity = 0
  end
  def update
    @actor = $game_party.members[0]
    self.contents.font.size = 16
    self.contents.clear
    skill_count = 0
    if Crissaegrim_ABS::Skill_Button[@actor.id] != nil
      for button in Crissaegrim_ABS::Skill_Button[@actor.id].keys
        next if button == nil
        x = 420
        y = 16
        skill = $data_skills[Crissaegrim_ABS::Skill_Button[@actor.id][button]]
        next if skill == nil
        show_icon(skill, (29 * skill_count) + x, y)
        skill_count += 1
      end
    end
    item_count = 0
    for btn in Crissaegrim_ABS::Item_Button.keys
      next if btn == nil
      item = $data_items[Crissaegrim_ABS::Item_Button[btn]]
      next if item == nil
      x = 0
      y = 354
      show_icon(item, (29 * item_count) + x, y)
      item_count += 1
      self.contents.font.size = 18
      self.contents.font.color = text_color(15)
      self.contents.draw_text((29 * item_count) + x-32, 360, 32, 28, $game_party.item_number(item),1)
      self.contents.font.size = 16
      self.contents.font.color = text_color(0)
      self.contents.draw_text((29 * item_count) + x-32, 360, 32, 28, $game_party.item_number(item),1)
    end
    refresh
  end
  def refresh
    draw_hp(@actor, 0, 0)
    draw_mp(@actor, 0, 40)
    # draw_q(@actor, 145, 13) if $game_variables[36] == 0 #Gruppo / Add by Ste
    # show_state(@actor, 130, 0)
    if Crissaegrim_ABS::Distance_Weapons.has_key?(@actor.weapon_id)
      if Crissaegrim_ABS::Distance_Weapons[@actor.weapon_id][5] > 0
        show_icon($data_items[Crissaegrim_ABS::Distance_Weapons[@actor.weapon_id][5]], 128, 3)
        self.contents.font.size = 18
        self.contents.font.color = text_color(15)
        self.contents.draw_text(146, 2, 24, 28, $game_party.item_number($data_items[Crissaegrim_ABS::Distance_Weapons[@actor.weapon_id][5]]),1)
        self.contents.font.size = 16
        self.contents.font.color = text_color(0)
        self.contents.draw_text(146, 2, 24, 28, $game_party.item_number($data_items[Crissaegrim_ABS::Distance_Weapons[@actor.weapon_id][5]]),1)
      end
      if Crissaegrim_ABS::Distance_Weapons[@actor.weapon_id][6] > 0
        show_icon($data_items[Crissaegrim_ABS::Distance_Weapons[@actor.weapon_id][6]], 61, 346)
        self.contents.font.size = 18
        self.contents.font.color = text_color(15)
        self.contents.draw_text(600, 354, 24, 28, $game_party.item_number($data_items[Crissaegrim_ABS::Distance_Weapons[@actor.weapon_id][6]]),1)
        self.contents.font.size = 16
        self.contents.font.color = text_color(0)
        self.contents.draw_text(610, 355, 24, 28, $game_party.item_number($data_items[Crissaegrim_ABS::Distance_Weapons[@actor.weapon_id][6]]),1)
      end
    end
    # Add by Ste
    if @actor.weapon_id
      show_icon($data_weapons[@actor.weapon_id], 142, 2)
    end
  end
  def show_state(actor, x, y)
    count = 0
    for state in actor.states
      draw_icon(state.icon_index, x, y + 24 * count)
      count += 1
      break if (24 * count > 76)
    end
  end
  def show_icon(item, x, y)
    if item != nil
      draw_icon(item.icon_index, x, y)
    end
  end
  def draw_hp(actor, x, y)
    meter = Cache.system(Crissaegrim_Hud::HP_Bar)
    cw = meter.width  * actor.hp / actor.maxhp
    ch = meter.height
    src_rect = Rect.new(0, 0, cw, ch)
    self.contents.blt(x, y, meter, src_rect)
    back = Cache.system(Crissaegrim_Hud::Base)
    cw = back.width
    ch = back.height
    src_rect = Rect.new(0, 0, cw, ch)
    self.contents.blt(x, y, back, src_rect)
  end  
  def draw_mp(actor, x, y)
    meter = Cache.system(Crissaegrim_Hud::MP_Bar)    
    cw = meter.width  * actor.mp / actor.maxmp
    ch = meter.height 
    src_rect = Rect.new(0, 0, cw, ch)
    self.contents.blt(x, y, meter, src_rect)
    back = Cache.system(Crissaegrim_Hud::Base)    
    cw = back.width
    ch = back.height
    src_rect = Rect.new(0, 0, cw, ch)    
    self.contents.blt(x, y, back, src_rect)
  end
  def draw_q(actor, x, y)
    back = Cache.system(Crissaegrim_Hud::Q_Bar) # Add by Ste
    cw = actor.weapon_id ? back.width : 14
    ch = back.height
    src_rect = Rect.new(0, 0, cw, ch)    
    self.contents.blt(x, y, back, src_rect)
  end
end

#------------------------------------------------------------------------------
class Scene_Map
  alias crissaegrim_abs_hud_start start
  alias crissaegrim_abs_hud_update update
  alias crissaegrim_abs_hud_terminate terminate
  def start
    crissaegrim_abs_hud_start
    if Crissaegrim_Hud::Background != ""
      @bg = Sprite.new
      @bg.bitmap = Cache.system(Crissaegrim_Hud::Background)
    end
    @hud = Window_CrissaegrimHud.new
    showing_hud
    @show = true
  end
  def update
    crissaegrim_abs_hud_update
    @bg.update if Crissaegrim_Hud::Background != ""
    @hud.update
    showing_hud
  end
  def terminate
    crissaegrim_abs_hud_terminate
    @bg.dispose if Crissaegrim_Hud::Background != ""
    @hud.dispose
  end
  def showing_hud
    if Input.trigger?(Crissaegrim_Hud::Show_Hide_Button)
      if @show == true
        @show = false
      else
        @show = true
      end
    end
    if Crissaegrim_Hud::OnOff_Hud_Switch == 0 or $game_switches[Crissaegrim_Hud::OnOff_Hud_Switch] == true
      if @show == true
        @hud.visible = true
        @bg.visible = true if Crissaegrim_Hud::Background != ""
      elsif @show == false
        @hud.visible = false
        @bg.visible = false if Crissaegrim_Hud::Background != ""
      end
     else
       @hud.visible = false
       @bg.visible = false if Crissaegrim_Hud::Background != ""
     end
   end
end
