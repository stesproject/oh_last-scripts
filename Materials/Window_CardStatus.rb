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
    self.active = false
    self.contents.font.color = normal_color
    self.contents.font.size = fs
    self.contents.font.bold = Font.default_bold
    self.contents.font.italic = false
    @line_height = lh
    @width = w
    @align = 0
    @text = nil                 # Remaining text to be displayed
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
    refresh
    @text = text
    show_text
  end
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh
    self.contents.clear
    @contents_x = 0
    @contents_y = 0
  end
  #--------------------------------------------------------------------------
  # * Start Message
  #--------------------------------------------------------------------------
  def show_text
    for t in @text
      contents.draw_text(@contents_x, @contents_y, @width, @line_height, t, @align)
      @contents_y += @line_height
    end
  end

  def clear
    self.contents.clear
  end
end
