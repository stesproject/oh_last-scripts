#==============================================================================
# MapTexts script
# Author: Ste
# Version: 2.0
# Date: 22-07-2022
# Change Log:
#     - Add convert_special_characters method
#     - Add font size and alignment parameters
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
  def initialize(texts="", lh=32, x=0, y=0, font_size = 16, align = 1)
    super(x, y, 544, 416)
    self.visible = false
    self.openness = 255
    self.back_opacity = 0
    self.opacity = 0
    self.contents.font.size = font_size
    self.contents.font.color = normal_color
    self.contents.font.italic = false
    @align = align
    @text = nil 
    @texts = texts
    @lh = lh
  end
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh
    self.visible = true
    self.contents.clear
    lh = @lh
    @texts.each do |text|
      @text = text
      convert_special_characters
      self.contents.draw_text(0, 0, 504, lh, @text, @align)
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
  #--------------------------------------------------------------------------
  # * Convert Special Characters
  #--------------------------------------------------------------------------
  def convert_special_characters
    # @text.gsub!(/\\V\[([0-9]+)\]/i) { $game_variables[$1.to_i] }
    # @text.gsub!(/\\V\[([0-9]+)\]/i) { $game_variables[$1.to_i] }
    # @text.gsub!(/\\N\[([0-9]+)\]/i) { $game_actors[$1.to_i].name }
    @text.gsub!(/\\C\[([0-9]+)\]/i) { 
      self.contents.font.color = text_color($1.to_i)
      @text.sub!(/\\C\[([0-9]+)\]/, "")
    }
  end
end