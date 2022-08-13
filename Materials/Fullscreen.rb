module ADDON
  ASK_LANGUAGE = $default_language == ""
  TEXT = "Select your language:"
end

class Window_Text < Window_Base
  def initialize(x, y)
    super(x, y, 544, 64)
    refresh
  end
  def refresh
    if !$ask_fullscreen
      self.contents.clear
      self.contents.draw_text(0, 0, 544, 32, ADDON::TEXT)
    end
  end
end

class Scene_Title
  $lang = $default_language
  
  alias main_fullscreen? main
  def main
    $locale.load_language
    $ask_fullscreen = $lang != ""

    if ADDON::ASK_LANGUAGE && $lang == ""
      unless $ask_fullscreen
        Graphics.freeze
        $data_system = load_data('Data/System.rvdata')
        $game_system = Game_System.new
        @text_window = Window_Text.new(92, 128)
        @text_window.back_opacity = 0
        @text_window.opacity = 0
        choices = []
        Localization::LANG.each do |lang|
          choices.push(Localization::LANGUAGES[lang])
        end
        @window = Window_Command.new(106, choices)
        @window.x = 92
        @window.y = 220 - @window.height / 2
        @window.opacity = 0
        Graphics.transition
        loop do
          Graphics.update
          Input.update
          @window.update
          update_window
          break if $ask_fullscreen
        end
        Graphics.freeze
        @window.dispose
        @window = nil
        @text_window.dispose
        Graphics.transition
        Graphics.freeze
      end
    elsif $ask_fullscreen
      unless $game_started
        Graphics.freeze
        if $lang != ""
          $data_system = load_data('Data/System.rvdata')
          $game_system = Game_System.new
        end
        c1 = $local.get_text("fullscreen")
        c2 = $local.get_text("windowed")
        choices = [c1, c2]
        @window = Window_Command.new(136, choices)
        @window.x = 202
        @window.y = 208 - @window.height / 2
        @window.opacity = 0
        Graphics.transition
        loop do
          Graphics.update
          Input.update
          @window.update
          update_window
          break if $game_started
        end
        Graphics.freeze
        @window.dispose
        @window = nil
        Graphics.transition
        Graphics.freeze
      end
    else
      $game_started = true
    end
    main_fullscreen? if $game_started
  end
  
  def update_window
    if Input.trigger?(Input::C)
      Sound.play_decision

      if !$ask_fullscreen
        $lang = Localization::LANG[@window.index]
        $locale.save_language
        $ask_fullscreen = true
      elsif $ask_fullscreen
        if @window.index == 0
          auto
        end
        $game_started = true
      end

    end
  end

  def auto
    keybd = Win32API.new 'user32.dll', 'keybd_event', ['i', 'i', 'l', 'l'], 'v'
    keybd.call(0xA4, 0, 0, 0)
    keybd.call(13, 0, 0, 0)
    keybd.call(13, 0, 2, 0)
    keybd.call(0xA4, 0, 2, 0)
    $fullscreen = true
  end
end