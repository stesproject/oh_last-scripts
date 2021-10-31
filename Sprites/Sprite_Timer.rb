#==============================================================================
# ** Sprite_Timer by Johnny 97 v2.1
#------------------------------------------------------------------------------
#  Questo script è utilizzato per far comparire il timer. 
#  Si osserva che $game_system cambia automaticamente le condizioni dello sprite.
# Settare la switch 0001 su ON per visualizzare il timer; 
# settarla invece su OFF per non visualizzare il timer.
# Per cambiare la switch andare alle righe 21 e 23 e sostituire al numero 0001
# l'ID della switch che volete utilizzare.
# Attivare/Disattivare la switch prima di arrivare alla mappa in cui si
# vuole utilizzare il timer.
#==============================================================================
class Sprite_Timer < Sprite
  #--------------------------------------------------------------------------
  # * Iniziallizzazione oggetto
  #     viewport : viewport
  #--------------------------------------------------------------------------
  def initialize(viewport)
    super(viewport)
    self.bitmap = Bitmap.new(88, 48)
    if $game_switches[0026] == true 
    self.bitmap.font.name = "Arial"
  end
    if $game_switches[0026] == false
    self.bitmap.font.name = nil 
  end
    self.bitmap.font.size = 32
    self.x = 544 - self.bitmap.width
    self.y = 0
    self.z = 200
    update
  end
  #--------------------------------------------------------------------------
  # * Disposizione
  #--------------------------------------------------------------------------
  def dispose
    self.bitmap.dispose
    super
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    self.visible = $game_system.timer_working
    if $game_system.timer / Graphics.frame_rate != @total_sec
      self.bitmap.clear
      @total_sec = $game_system.timer / Graphics.frame_rate
      min = @total_sec / 60
      sec = @total_sec % 60
      text = sprintf("%02d:%02d", min, sec)
      self.bitmap.font.color.set(255, 255, 255)
      self.bitmap.draw_text(self.bitmap.rect, text, 1)
    end
  end
end