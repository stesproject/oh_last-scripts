###############################################################################
#Pause Script Version 2 Final Release                                         #
###############################################################################

# Name the picture "Pause" and put it inside the system folder.

module Baelgard


  PAUSE_BUTTON = "B" #Press 
  PAUSE_TEXT = "Pausa"
  #allow/disallow freezing play time during pause
  STOP_TIME = true
  #Set a switch name to allow/disallow pause
  PAUSE_SW_NAME = "Pausa" 
  PAUSE_BUTTON2 = eval("Input::#{PAUSE_BUTTON}")
  PAUSE_OPACITY = 255 #opacity of the picture
  def stopping
    
    viewport1 = Viewport.new(0, 0, 640, 480)
    viewport1.z = 10000

    sprite1 = Sprite.new(viewport1)
    sprite1.tone = Tone.new(0, 0, 0, 0)
    sprite1.bitmap = Cache.system ("pause")
    sprite1.opacity = PAUSE_OPACITY
    
    loop do
      Graphics.update
      Input.update
      if Input.trigger?(PAUSE_BUTTON2)
        break
      end
    end

    sprite1.dispose
    sprite1 = nil
   end
  #--------------------------------------------------------------------------

  def can_stop?
    if PAUSE_SW_NAME.is_a?(Numeric)
      return ($game_switches[PAUSE_SW_NAME] rescue true)
    else
      return ($game_switches[$data_system.switches.index(PAUSE_SW_NAME)] rescue true)
    end
   end
  end
#==============================================================================
#  Scene_Map
#==============================================================================

class Scene_Map

  include Baelgard

  alias baelgard_update update
  def update
    if Input.trigger?(PAUSE_BUTTON2) and can_stop?
      tmp = Graphics.frame_count
      stopping
      if STOP_TIME
        Graphics.frame_count = tmp
      end
    end
    baelgard_update
   end
 end
#==============================================================================
# Scene_Battle
#==============================================================================

class Scene_Battle
  include Baelgard
  alias baelgard_update update
  def update
    if Input.trigger?(PAUSE_BUTTON2) and can_stop?
      tmp = Graphics.frame_count
       stopping
      if STOP_TIME
        Graphics.frame_count = tmp
      end
    end
    baelgard_update
  end
end 