#===============================================================
# ● [RPG MAKER VX] ◦ Cambiare Windowskin ◦ 
#--------------------------------------------------------------
# ◦ by Woratana [woratana@hotmail.com]
# ◦ Rilasciato il: 10/03/2008
# ◦ Tradotto by Eikichi
# ◦ Rilasciato il: 12/03/2008
#--------------------------------------------------------------
# Nota: piccola opzione eliminata in rpgmaker vp
=begin
●----●----●----●----● +[Istruzioni]+ ●----●----●----●----●
Chiama Script:
$game_system.skin = 'Nome della Windowskin'
(La WindowSkin deve essere messa in: 'Graphics/System')

Esempio:  $game_system.skin = 'Window'


=end
#===============================================================

class Window_Base < Window
  alias wor_changeskin_winbase_ini initialize
  alias wor_changeskin_winbase_upd update
  
  # Cambia WindowSkin quando viene aperta una finestra per la prima volta 
  def initialize(x, y, width, height)
    wor_changeskin_winbase_ini(x, y, width, height)
    self.windowskin = Cache.system($game_system.skin)
    @winskin = $game_system.skin
  end
  
  # Cambia WindowSkin se $game_system.skin non è la stessa già in uso
  def update
    wor_changeskin_winbase_upd
    if @winskin != $game_system.skin
      self.windowskin = Cache.system($game_system.skin)
      @winskin = $game_system.skin
    end
  end
end
class Game_System
  attr_accessor :skin
  alias wor_changeskin_gamesys_ini initialize
  
  # Aggiunge la variabile $game_system.skin per gestire il nome della windowskin
  def initialize
    wor_changeskin_gamesys_ini
    @skin = 'Window'
  end
end