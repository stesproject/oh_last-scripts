#==============================================================================
# ** Window_CardStatus
#------------------------------------------------------------------------------
#  This window displays cards name and description.
#==============================================================================

class Window_CardStatus < Window_Base
  TEXT_X = 32
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x : window X coordinate
  #     y : window Y coordinate
  #--------------------------------------------------------------------------
  def initialize(x = 0, y = 288, w = 544, h = 128, fs = 20, lh = 24, dark = false)
    super(x, y, w, h)
    self.z = 200
    self.opacity = 0
    # self.active = false
    self.contents.font.color = normal_color
    self.contents.font.size = fs
    self.contents.font.bold = Font.default_bold
    self.contents.font.italic = false
    @line_height = lh
    @width = w
    @align = 0
    @texts = nil                 # Remaining text to be displayed
    @contents_x = 0             # X coordinate for drawing next character
    @contents_y = 0             # Y coordinate for drawing next character
  end
  #--------------------------------------------------------------------------
  # * Dispose
  #--------------------------------------------------------------------------
  def dispose
    super
  end
  #--------------------------------------------------------------------------
  # * Set Item
  #--------------------------------------------------------------------------
  def set(text)
    clear
    @texts = text
    show_text
  end
  #--------------------------------------------------------------------------
  # * Start Message
  #--------------------------------------------------------------------------
  def show_text
    for t in @texts
      @text = t
      convert_special_characters
      contents.draw_text(@contents_x, @contents_y, @width, @line_height, @text, @align)
      @contents_y += @line_height
    end
  end
  #--------------------------------------------------------------------------
  # * Convert Special Characters
  #--------------------------------------------------------------------------
  def convert_special_characters
    @text.gsub!(/\\V\[([0-9]+)\]/i) { $game_variables[$1.to_i] }
    # @texts.gsub!(/\\N\[([0-9]+)\]/i) { $game_actors[$1.to_i].name }
    @text.gsub!(/\\C\[([0-9]+)\]/i) { 
      self.contents.font.color = text_color($1.to_i)
      @text.sub!(/\\C\[([0-9]+)\]/, "")
    }
  end

  def clear
    self.contents.clear
    @contents_x = 0
    @contents_y = 0
  end
end
