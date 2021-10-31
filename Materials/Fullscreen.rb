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
    self.contents.clear
    self.contents.draw_text(0, 0, 544, 32, ADDON::TEXT)
  end
end

class Scene_Title
  $lang = $default_language
  $fullscreen = $TEST
  
  alias main_fullscreen? main
  def main
    $locale.load_language
    if $fullscreen == false
      auto
    end

    if ADDON::ASK_LANGUAGE && $lang == ""
      unless $game_started 
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
        @window = Window_Command.new(96, choices)
        #@window.windowskin = Cache.system("Window2")
        @window.x = 92
        @window.y = 240 - @window.height / 2
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
        @text_window.dispose
        Graphics.transition
        Graphics.freeze
      end
    else
      $game_started = true
    end
    main_fullscreen?
  end
  
  def update_window
    if Input.trigger?(Input::C)
      Sound.play_decision
      $lang = Localization::LANG[@window.index]

      $locale.save_language
      $game_started = true
    end
  end

  def auto
    keybd = Win32API.new 'user32.dll', 'keybd_event', ['i', 'i', 'l', 'l'], 'v'
    keybd.call(0xA4, 0, 0, 0)
    keybd.call(13, 0, 0, 0)
    keybd.call(13, 0, 2, 0)
    keybd.call(0xA4, 0, 2, 0)
    $fullscreen = true
    # $game_started = true
  end
end