#==============================================================================
# Boss HUD
#==============================================================================

# Para criar a barra de HP dos Bosses, ponha no evento inimigo o comentário: Boss

module Enemy_Hud
  Base = "Boss-Base" # Imagem de fundo da barra de HP do boss
  HP_Bar = "Boss-HPBar" # Imagem da barra de HP do boss
  Bar_X = 4 # Posição X da barra de HP
  Bar_Y = 6 # Posição Y da barra de HP
end

#==============================================================================
# Game Event
#==============================================================================
class Game_Event < Game_Character
  attr_reader :boss
  alias crissaegrim_abs_gameevent_initialize initialize
  alias crissaegrim_abs_gameevent_refresh refresh
  def initialize(map_id, event)
    @boss = false
    crissaegrim_abs_gameevent_initialize(map_id, event)
  end
  def refresh
    crissaegrim_abs_gameevent_refresh
    @boss = false
    @boss = check_com("Boss")
  end
end

#==============================================================================
# Boss Hud
#==============================================================================
class Boss_HUD < Sprite
  def initialize(id)
    @enemy = $game_map.events[id]
    super()
    self.bitmap = Bitmap.new(544,416)
  end
  def update
    self.bitmap.clear
    show_bar(Enemy_Hud::Bar_X,Enemy_Hud::Bar_Y,@enemy.enemy_called.hp,@enemy.enemy_called.maxhp)
  end
  def show_bar(x,y,hp,max)
    base = Cache.system(Enemy_Hud::Base)
    cw2 = base.width
    ch2 = base.height
    rect2 = Rect.new(0, 0, cw2, ch2)
    src_rect2 = Rect.new(0, 0, cw2, ch2)
    self.bitmap.stretch_blt(rect2, base, src_rect2)
    meter = Cache.system(Enemy_Hud::HP_Bar)
    cw1 = meter.width * hp / max
    ch1 = meter.height
    rect1 = Rect.new(x, y, cw1, ch1)
    src_rect1 = Rect.new(0, 0, cw1, ch1)
    self.bitmap.stretch_blt(rect1, meter, src_rect1)
    self.x = (544-base.width)/2
    self.y = (416-base.height)-24
  end
end

#==============================================================================
# Scene Map
#==============================================================================
class Scene_Map < Scene_Base
  alias boss_hud_update update
  alias boss_hud_terminate terminate
  alias boss_hud_update_transfer_player update_transfer_player
  def update
    super
    for event in $game_map.events.values
      if event.boss == true
        @boss_hud = Boss_HUD.new(event.id) if @boss_hud == nil and !event.enemy_called.dead?
        @boss_hud.update if @boss_hud != nil and !event.enemy_called.dead?
        @boss_hud.dispose if @boss_hud != nil and event.enemy_called.dead?
        @boss_hud = nil if @boss_hud != nil and event.enemy_called.dead?
      end
    end
    boss_hud_update
  end
  def terminate
    super
    @boss_hud.dispose if @boss_hud != nil
    @boss_hud = nil
    boss_hud_terminate
  end
  def update_transfer_player
    return unless $game_player.transfer?
    @boss_hud.dispose if @boss_hud != nil
    @boss_hud = nil
    boss_hud_update_transfer_player
  end
end
