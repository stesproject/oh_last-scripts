#===============================================================================
# Roninator2 : Single Splash Screen
#===============================================================================
# Coded by : Roninator2
#===============================================================================
#========================DESCRIPTION & TERMS OF USE============================#
# This script adds a simple splash image before the title screen
#===============================================================================
# Free for Commercial & Non-Commercial use. As long as I'm credited.
#===============================================================================
$splashDone = $TEST

module R2_Splash
  Splash = "logo" # The Image that'll serve as a splash image
  Xpos = 208
  Ypos = 144
  end
  
  class Scene_Title < Scene_Base
  
    def start
      super
      if $splashDone
        startup
      else
        $splashDone = true
        create_splash
      end
    end
   
    def startup
      load_database                     # Load database
      create_game_objects               # Create game objects
      check_continue                    # Determine if continue is enabled
      create_title_graphic              # Create title graphic
      create_command_window             # Create command window
      play_title_music                  # Play title screen music
    end
  
    def create_splash
      @splash = Sprite.new
      @splash.x = R2_Splash::Xpos
      @splash.y = R2_Splash::Ypos
      @splash.bitmap = Cache.system(R2_Splash::Splash)
      Graphics.wait(30)
      perform_transition
      Graphics.fadein(30)
      hold
    end
  
    def hold
      $transition = true
      Graphics.wait(60)
      Graphics.fadeout(30)
      dispose_splash
    end
  
    def dispose_splash
      @splash.bitmap.dispose
      @splash.dispose
      startup
      Graphics.freeze               
      perform_transition
      Graphics.fadein(30)
    end
  end