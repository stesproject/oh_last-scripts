class Window_ScreenText < Window_Base
  attr_accessor :text
  def initialize(text)
    super(-12, 374, 544, 64)
    @text = text
    refresh
  end
  def refresh
    self.contents.clear
    self.contents.font.size = 13
    self.contents.font.italic = false
    self.contents.font.shadow = false
    self.contents.font.color.alpha = 164
    self.contents.draw_text(0, 0, 544, 32, @text)
  end
end