#==============================================================================
# MapTexts script
# Author: Ste
# Version: 1.0
#==============================================================================

# ** Spriteset_Map
#------------------------------------------------------------------------------
#  This class brings together map screen sprites, tilemaps, etc. It's used
# within the Scene_Map class.
#==============================================================================

class Spriteset_Map
  #--------------------------------------------------------------------------
  # Alias Listing
  #--------------------------------------------------------------------------
  alias spriteset_name_window_initialize initialize
  alias spriteset_name_window_update update
  alias spriteset_name_window_dispose dispose
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    $tw = nil
    spriteset_name_window_initialize
    update
  end
  #--------------------------------------------------------------------------
  # * Create Windows
  #--------------------------------------------------------------------------
  def create_windows
    $tw = Window_MapTexts.new
    $tw.show_texts
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    spriteset_name_window_update
    if $tw != nil
      $tw.update
    end
  end
  #--------------------------------------------------------------------------
  # * Dispose
  #--------------------------------------------------------------------------
  def dispose
    spriteset_name_window_dispose
    if $tw != nil
      $tw.dispose
    end
  end
end

#==============================================================================
# ** Window_MapTexts
#------------------------------------------------------------------------------
#  Display texts on screen
#==============================================================================

class Window_MapTexts < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(texts="", lh=32, x=0, y=0)
    super(x, y, 544, 416)
    self.visible = false
    self.openness = 255
    self.back_opacity = 0
    self.opacity = 0
    @texts = texts
    @lh = lh
  end
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh
    self.visible = true
    self.contents.clear
    self.contents.font.color = normal_color
    self.contents.font.italic = false
    lh = @lh
    @texts.each do |text|
      self.contents.draw_text(0,0,504,lh,text,1)
      lh += @lh
    end
  end
  #--------------------------------------------------------------------------
  # * Show Texts
  #--------------------------------------------------------------------------
  def show_texts(texts=@texts, lh=@lh)
    @texts = texts
    @lh = lh
    refresh
  end
end