##################################################
# Scene Title Screen Miria V1.0                                    
##################################################
# By Moghunter
# http://www.atelier-rgss.com
##################################################
# Tela de titulo animada.
# Crie uma pasta com o nome deTitle dentro da pasta
# Graphics e coloque todas as imagens dentro dela.
# São necessárias as seguintes imagens.
#
# Title           #Imagem que contem o texto do titulo
# Transition    #Imagem da transição de tela
# Plane1        #Imagem da camada 1
# Plane2        #Imagem da camada 2
# Plane3        #Imagem da camada 3
# Com_01       #Imagem do menu seleção NEW GAME
# Com_02       #Imagem do menu seleção CONTINUE
# Com_03       #Imagem do menu seleção EXIT
#
#-------------------------------------------------
#############
#   CONFIG    #
#############
module MOG_VX01
GAME_VERSION = "1.0.0"
WEBSITE_URL = "https://stesproject.com"
#Ativar tela cheia.    (true = Ativar ou false = Desativar) 
FULL_SCREEN = false
# Tempo de transição.
TT = 60
# Fade in speed.
FADE_IN_SPEED = 8
FADE_OUT_SPEED = 3
#Ativar movimento de Onda no texto do titulo.
# (true = Ativar ou false = Desativar) 
TWAVE = false
#Opacidade da imagem camada 1.
TPLANE1_OPA = 255
#Opacidade da imagem camada 2.
TPLANE2_OPA = 220
#Opacidade da imagem camada 3
TPLANE3_OPA = 170
# Velocidade de movimento da camada 1 na horizontal.
TPLANE1_X = 0
# Velocidade de movimento da camada 1 na vertical.
TPLANE1_Y = 0
# Velocidade de movimento da camada 2 na horizontal.
TPLANE2_X = 1
# Velocidade de movimento da camada 2 na vertical.
TPLANE2_Y = 0
# Velocidade de movimento da camada 2 na horizontal.
TPLANE3_X = 2
# Velocidade de movimento da camada 2 na vertical.
TPLANE3_Y = 0

TITLE_X = 0
TITLE_Y = 20

ARROWS_X = 365
ARROWS_Y = 305

COMMANDS_X = 344
COMMANDS_Y = 265
end
#-------------------------------------------------
$mogscript = {} if $mogscript == nil
$mogscript["title_miria"] = true
#-------------------------------------------------
###############
# Module Cache #
###############
module Cache
  def self.title(filename)
    begin
      load_bitmap("Graphics/Title/#{$lang}/", filename)
    rescue
      load_bitmap("Graphics/Title/", filename)
    end
  end
end

class Window_TitleText < Window_Base
  def initialize
    super(-12, 374, 544, 64)
    refresh
  end
  def refresh
    self.contents.clear
    self.contents.font.size = 13
    self.contents.font.italic = false
    self.contents.font.shadow = false
    self.contents.font.color.alpha = 164
    self.contents.draw_text(0, 0, 544, 32, "#{MOG_VX01::GAME_VERSION}")
  end
end

#############
# Scene_Title #
#############
$full_screen = 0
class Scene_Title
attr_accessor :title_commands
include  MOG_VX01
  def main
    if $BTEST                       
      battle_test                     
    return
    end      
    $full_screen += 1
    if MOG_VX01::FULL_SCREEN == true and $full_screen == 1
    $showm = Win32API.new 'user32', 'keybd_event', %w(l l l l), ' ' 
    $showm.call(18,0,0,0) 
    $showm.call(13,0,0,0) 
    $showm.call(13,0,2,0) 
    $showm.call(18,0,2,0)
    end     
    start                         
    perform_transition          
    post_start                    
    Input.update                
    loop do
      Graphics.update            
      Input.update                
      update                      
      break if $scene != self    
    end
    Graphics.update
    pre_terminate                 
    Graphics.freeze               
    terminate                     
  end

  def initialize_commands
    @title_commands = [
      Vocab::new_game,
      Vocab::continue,
      $local.get_text("website"),
      $local.get_text("menu_language"),
      Vocab::shutdown
    ]
  end

  def translate_db
    localize_items($data_skills)
    localize_items($data_items)
    localize_items($data_weapons)
    localize_items($data_armors)
  end

  def start
    load_database                    
    create_game_objects            
    check_continue                    
    create_title_graphic             
    create_command_window         
    play_title_music                 
  end
  def perform_transition
      if $transition == true
      Graphics.transition(TT, "Graphics/Title/Transition")
    else
      Graphics.transition(20)
    end
  end
  def post_start
    open_command_window
  end
  def pre_terminate
    close_command_window
  end
  def terminate
    dispose_command_window
    snapshot_for_background
    dispose_title_graphic
    translate_db
    $transition = false
  end
  def update
    @command_window.update
    comm = "Com_0#{@command_window.index + 1}"
    @com.bitmap = Cache.title(comm)
    @com.x = COMMANDS_X
    @com.y = COMMANDS_Y

    @sprite_title.opacity += FADE_IN_SPEED
    @com.opacity += FADE_IN_SPEED if @sprite_title.opacity > 150
    @sprite.ox += TPLANE1_X
    @sprite.oy += TPLANE1_Y
    @sprite2.ox += TPLANE2_X
    @sprite2.oy += TPLANE2_Y
    @sprite3.ox += TPLANE3_X
    @sprite3.oy += TPLANE3_Y
    @sprite_title.update if TWAVE == true
    @arrows.opacity = @command_window.index == 3 ? 255 : 0
    if Input.trigger?(Input::C)
      case @command_window.index
      when 0    #New game
        command_new_game
      when 1    # Continue
        command_continue
      when @title_commands.size - 1    # Shutdown
        command_shutdown
      when 2    # Website
        command_website
      when 3    # Language
        # command_language
      end
    elsif Input.trigger?(Input::RIGHT) && Localization::LANG.size > 1
      case @command_window.index
      when 3    # Language
        command_language(1)
      end
    elsif Input.trigger?(Input::LEFT) && Localization::LANG.size > 1
      case @command_window.index
      when 3    # Language
        command_language(-1)
      end
    end
  end
  def update_slide
    @sprite.ox += TPLANE1_X
    @sprite.oy += TPLANE1_Y
    @sprite2.ox += TPLANE2_X
    @sprite2.oy += TPLANE2_Y
    @sprite3.ox += TPLANE3_X
    @sprite3.oy += TPLANE3_Y
    @sprite_title.update if TWAVE == true    
  end
  def load_database
    $data_actors        = load_data("Data/Actors.rvdata")
    $data_classes       = load_data("Data/Classes.rvdata")
    $data_skills        = load_data("Data/Skills.rvdata")
    $data_items         = load_data("Data/Items.rvdata")
    $data_weapons       = load_data("Data/Weapons.rvdata")
    $data_armors        = load_data("Data/Armors.rvdata")
    $data_enemies       = load_data("Data/Enemies.rvdata")
    $data_troops        = load_data("Data/Troops.rvdata")
    $data_states        = load_data("Data/States.rvdata")
    $data_animations    = load_data("Data/Animations.rvdata")
    $data_common_events = load_data("Data/CommonEvents.rvdata")
    $data_system        = load_data("Data/System.rvdata")
    $data_areas         = load_data("Data/Areas.rvdata")
  end
  def load_bt_database
    $data_actors        = load_data("Data/BT_Actors.rvdata")
    $data_classes       = load_data("Data/BT_Classes.rvdata")
    $data_skills        = load_data("Data/BT_Skills.rvdata")
    $data_items         = load_data("Data/BT_Items.rvdata")
    $data_weapons       = load_data("Data/BT_Weapons.rvdata")
    $data_armors        = load_data("Data/BT_Armors.rvdata")
    $data_enemies       = load_data("Data/BT_Enemies.rvdata")
    $data_troops        = load_data("Data/BT_Troops.rvdata")
    $data_states        = load_data("Data/BT_States.rvdata")
    $data_animations    = load_data("Data/BT_Animations.rvdata")
    $data_common_events = load_data("Data/BT_CommonEvents.rvdata")
    $data_system        = load_data("Data/BT_System.rvdata")
  end
  def create_game_objects
    $game_temp          = Game_Temp.new
    $game_message       = Game_Message.new
    $game_system        = Game_System.new
    $game_switches      = Game_Switches.new
    $game_variables     = Game_Variables.new
    $game_self_switches = Game_SelfSwitches.new
    $game_actors        = Game_Actors.new
    $game_party         = Game_Party.new
    $game_troop         = Game_Troop.new
    $game_map           = Game_Map.new
    $game_player        = Game_Player.new
  end
  def check_continue
    @continue_enabled = (Dir.glob('Save*.rvdata').size > 0)
  end
  def create_title_graphic
    draw_version_text
    @sprite_title = Sprite.new    
    @sprite_title.bitmap = Cache.title("Title")  
    @sprite_title.opacity = 0
    @sprite_title.x = TITLE_X
    @sprite_title.y = TITLE_Y
    @com = Sprite.new
    @com.bitmap = Cache.title("Com_01")  
    @com.opacity = 0
    @arrows = Sprite.new
    @arrows.bitmap = Cache.title("Arrows")
    @arrows.opacity = 0
    @sprite = Plane.new    
    @sprite.bitmap = Cache.title("Plane1")
    @sprite2 = Plane.new 
    @sprite2.bitmap = Cache.title("Plane2")
    @sprite3 = Plane.new    
    @sprite3.bitmap = Cache.title("Plane3")
    @sprite.opacity = TPLANE1_OPA
    @sprite2.opacity = TPLANE2_OPA    
    @sprite3.opacity = TPLANE3_OPA    
    @sprite.z  = 1
    @sprite2.z = 2
    @sprite3.z = 5
    @com.z = 4
    @arrows.x = ARROWS_X
    @arrows.y = ARROWS_Y
    @arrows.z = 7
    @sprite_title.z = 3  
  if TWAVE == true
    @sprite_title.wave_amp = 8
    @sprite_title.wave_length = 240
    @sprite_title.wave_speed = 320
  end
    end
  def dispose_title_graphic
    @sprite.bitmap.dispose
    @sprite2.bitmap.dispose
    @sprite3.bitmap.dispose    
    @com.bitmap.dispose    
    @arrows.bitmap.dispose    
    @sprite_title.bitmap.dispose 
    @sprite.dispose
    @sprite2.dispose
    @sprite3.dispose
    @arrows.dispose
    @com.dispose
    @sprite_title.dispose
    @text_window.dispose
  end
  def create_command_window(index = 1)
    initialize_commands
    @command_window = Window_Command.new(172, @title_commands)
    @command_window.opacity = 0
    @command_window.contents_opacity = 0
    if @continue_enabled                    # If continue is enabled
      @command_window.index = index         # Move cursor over command
    else                                    # If disabled
      @command_window.draw_item(1, false)   # Make command semi-transparent
    end
    if index != 1
      @command_window.index = index
    end
  end
  def title_fade
   if TWAVE == true    
    @sprite_title.wave_amp = 34
    @sprite_title.wave_length =120
    @sprite_title.wave_speed = 800
    end    
    for i in 0..120
    @sprite_title.opacity -= FADE_OUT_SPEED
    @sprite_title.update if TWAVE == true    
    @com.opacity -= FADE_OUT_SPEED
     case @command_window.index
     when 0    
     @sprite.zoom_x += 0.01
     @sprite.zoom_y += 0.01   
     @sprite2.zoom_x += 0.01
     @sprite2.zoom_y += 0.01       
     @sprite3.zoom_x += 0.01
     @sprite3.zoom_y += 0.01       
     @sprite.ox += 2
     @sprite.oy += 2
     @sprite2.ox += 2
     @sprite2.oy += 2
     @sprite3.ox += 2
     @sprite3.oy += 2    
     end
    update_slide
    Graphics.update  
    end         
  end  
  def dispose_command_window
    @command_window.dispose
  end
  def open_command_window
    @command_window.open
    begin
      @command_window.update
      Graphics.update
    end until @command_window.openness == 255
  end
  def close_command_window
    @command_window.close
    begin
      @command_window.update
      Graphics.update
    end until @command_window.openness == 0
  end
  def play_title_music
    $data_system.title_bgm.play
    RPG::BGS.stop
    RPG::ME.stop
  end
  def confirm_player_location
    if $data_system.start_map_id == 0
      print "Player start location not set."
      exit
    end
  end
  def command_new_game
    confirm_player_location
    Sound.play_decision
    title_fade
    $game_party.setup_starting_members        
    $game_map.setup($data_system.start_map_id)   
    $game_player.moveto($data_system.start_x, $data_system.start_y)
    $game_player.refresh
    $scene = Scene_Map.new
    #Vars_Initialization.new
    RPG::BGM.fade(1500)
    close_command_window
    Graphics.fadeout(60)
    Graphics.wait(40)
    Graphics.frame_count = 0
    RPG::BGM.stop
    $game_map.autoplay
  end
  def command_continue
    if @continue_enabled
      Sound.play_decision
      title_fade
      $scene = Scene_File.new(false, true, false)
    else
      Sound.play_buzzer
    end
  end
  def command_website
    Sound.play_decision
    Thread.new {system("start #{MOG_VX01::WEBSITE_URL}")}
  end
  #--------------------------------------------------------------------------
  # * Command: Language
  #--------------------------------------------------------------------------
  def command_language(value = 1)
    Sound.play_decision
    $local.switch_language(value)
  end
  def command_shutdown    
    Sound.play_decision
    title_fade
    RPG::BGM.fade(800)
    RPG::BGS.fade(800)
    RPG::ME.fade(800)
    $scene = nil
  end
  def battle_test
    load_bt_database              
    create_game_objects         
    Graphics.frame_count = 0          
    $game_party.setup_battle_test_members
    $game_troop.setup($data_system.test_troop_id)
    $game_troop.can_escape = true
    $game_system.battle_bgm.play
    snapshot_for_background
    $scene = Scene_Battle.new
  end
  def snapshot_for_background
    $game_temp.background_bitmap.dispose
    $game_temp.background_bitmap = Graphics.snap_to_bitmap
    $game_temp.background_bitmap.blur
  end
  #--------------------------------------------------------------------------
  # * Translate data from Database (items, weapons, armors, skills)
  #--------------------------------------------------------------------------
  def localize_items(items)
    for i in 1...items.size
      item_name = items[i].name
      item_description = items[i].description
      item = $local.get_db_object(item_name)
      items[i].name = item.name
      items[i].description = item.desc
    end
  end

  def draw_version_text
    @text_window = Window_TitleText.new
    @text_window.back_opacity = 0
    @text_window.opacity = 0
  end
end