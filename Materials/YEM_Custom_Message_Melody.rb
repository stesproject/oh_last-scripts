#===============================================================================
# 
# Yanfly Engine Melody - Custom Message Melody
# Last Date Updated: 2010.05.22
# Level: Easy, Normal, Hard, Lunatic
# 
# The message system by itself is fine and easy to accept as it is. However, it
# wouldn't hurt to have it do a few more features. This script will allow your
# message boxes to perform extra functions such as drawing icons, using an
# external choice window, and using Lunatic shortcuts.
# 
# Custom Message Melody will also separate the in-game font from the message
# window font. This way, fancier-looking fonts can be used for dialogue while
# more systematically appropriate fonts can be used for in-game material.
# 
# This is by no means a complex message system like Modern Algebra's ATS or
# Woratana's Neo Message System. If you want a message system with a lot of
# features, I highly recommend that you take a look at those. This message
# system here will supply the most basic functions and needs without adding
# too many extra features.
#===============================================================================
# Updates
# -----------------------------------------------------------------------------
# o 2010.05.22 - Converted to Yanfly Engine Melody.
#===============================================================================
# Instructions
# -----------------------------------------------------------------------------
# To install this script, open up your script editor and copy/paste this script
# to an open slot below ▼ Materials but above ▼ Main. Remember to save.
# 
# -----------------------------------------------------------------------------
# Message Window REGEXP Codes - These go inside of your message window.
# -----------------------------------------------------------------------------
#  Code:       Effect:
#    \v[x]       Writes variable x's value.
#    \n[x]       Writes actor x's name.
#    \c[x]       Changes the colour of the text to x.
#    \g          Displays the gold window.
#    \.          Waits 15 frames (quarter second).
#    \|          Waits 60 frames (a full second).
#    \!          Waits until key is pressed.
#    \>          Following text is instant.
#    \<          Following text is no longer instant.
#    \^          Skips to the next message.
#    \\          Writes a "\" in the window.
# 
#    \f[x]       Draws actor ID x's face in the window.
#    \w[x]       Waits x frames (60 frames = 1 second).
# 
#    \nb[x]      Creates a name window with x. Left side.
#    \nbl[x]     Creates a name window with x. Locks the namebox. Left side.
#    \nbu[x]     Creates a name window with x. Unlocks the namebox. Left side.
#    \rnb[x]     Creates a name window with x. Right side.
#    \rnbl[x]    Creates a name window with x. Locks the namebox. Right side.
#    \rnbu[x]    Creates a name window with x. Unlocks the namebox. Right side.
#    \nbu        Closes name window. Unlocks the namebox.
# 
#    \fn[x]      Changes the font name to x. Set to 0 to reset font name.
#    \fs[x]      Changes the font size to x. Set to 0 to reset font size.
#    \fb         Changes the font to bold and back.
#    \fi         Changes the font to italic
#    \fh         Changes the font to shadowed and back.
# 
#    \ac[x]      Writes actor x's class name.
#    \as[x]      Writes actor x's subclass name. Requires JP Classes.
#    \ax[x]      Writes actor x's combination class name. Requires JP Classes.
#    \af[x]      Replaces face with actor x's face.
#    \af[x:y]    Replaces face with actor x's face name but uses expression y.
# 
#    \pn[x]      Writes ally's name in party slot x.
#    \pc[x]      Writes ally's class name in party slot x.
#    \ps[x]      Writes ally's subclass name in party slot x.
#    \px[x]      Writes ally's combination class name in party slot x.
#    \pf[x]      Replaces face with ally's face in party slot x.
#    \pf[x:y]    Replaces face with ally's face name but uses expression y.
# 
#    \nc[x]      Writes class ID x's name.
#    \ni[x]      Writes item ID x's name.
#    \nw[x]      Writes weapon ID x's name.
#    \na[x]      Writes armour ID x's name.
#    \ns[x]      Writes skill ID x's name.
#    \nt[x]      Writes state ID x's name.
#
#    \i[x]       Draws icon ID x into the message window.
#    \ii[x]      Writes item ID x's name with icon included.
#    \iw[x]      Writes weapon ID x's name with icon included.
#    \ia[x]      Writes armour ID x's name with icon included.
#    \is[x]      Writes skill ID x's name with icon included.
#    \it[x]      Writes state ID x's name with icon included.
# 
#===============================================================================

$imported = {} if $imported == nil
$imported["CustomMessageMelody"] = true

module YEM
  module MESSAGE
    
    #===========================================================================
    # Sectio I. Basic Settings
    # --------------------------------------------------------------------------
    # The following below will adjust the basic settings and that will affect
    # the majority of the script.
    #===========================================================================
    
    # This adjusts the pixel width given to your icons so they won't throw
    # certain monospaced fonts out of alignment.
    ICON_WIDTH = 24
    
    # This adjusts how many rows are shown on screen. If it's 0 or under, a
    # maximum of 4 rows will be shown. If it's above, it will show that many
    # rows and texts following it immediately after will also display that many
    # extra rows.
    ROW_VARIABLE = 82
    
    # This adjusts how wide the message window will be in pixels. The window
    # will automatically center itself to the new width.
    WIDTH_VARIABLE = 83
    
    # This button is the button used to make message windows instantly skip
    # forward. Hold down for the effect. Note that when held down, this will
    # speed up the messages, but still wait for the pauses. However, it will
    # automatically go to the next page when prompted.
    TEXT_SKIP = Input::B     # Input::A is the shift button on keyboard.
    
    #===========================================================================
    # Section II. Name Window Settings
    # --------------------------------------------------------------------------
    # The name window is a window that appears outside of the main message
    # window box to display whatever text is placed inside of it like a name.
    #===========================================================================
    
    # This determines where you would like the namebox window to appear relative
    # to the message window. Adjust the following accordingly.
    NAME_WINDOW_X = -20      # Adjusts X position offset from Message Window.
    NAME_WINDOW_Y = 40       # Adjusts Y position offset from Message Window.
    NAME_WINDOW_W = 20       # Adjusts extra width added to the Name Window.
    NAME_WINDOW_H = 40       # Adjusts the height of the Name Window.
    NAME_COLOUR   = 0        # Default colour used for name box.
    
    # The following lets you adjust whether or not you would like to see the
    # back of the name window.
    NAME_WINDOW_SHOW_BACK = true
    
    #===========================================================================
    # Section III. Choice Settings
    # --------------------------------------------------------------------------
    # There are now different ways to display choices now. One is the default
    # method, another is through a choice window. Adjust the settings properly.
    # To change the type of choice window shown, adjust the choice variable 
    # during the game.
    # Var:    Type:
    #  0       Normal
    #  1       Outside window without a face. In the center of the screen.
    #  2       Outside window without a face. Right side of the screen.
    #  3       Outside window without a face. Left side of the screen.
    #  4       Outside window with a face. In the center of the screen.
    #  5       Outside window with a face. Right side of the screen.
    #  6       Outside window with a face. Left side of the screen.
    #===========================================================================
    
    # This is the indent used for choices when used through the regular method.
    # Otherwise, inside of the choice window, there will be no indent.
    CHOICE_INDENT = "\x06    \x07"
    
    # These variables adjust the type of choice window displayed and which
    # actor's face graphic to be displayed inside of the choice variable.
    CHOICE_VARIABLE = 84
    FACE_VARIABLE   = 85
    
    CHOICE_WINDOW_X = 100  # The X offset for the choice window.
    CHOICE_WINDOW_Y =   0  # The Y offset for the choice window.
    CHOICE_WINDOW_W =  60  # Minimum size for the choice width.
    CHOICE_WINDOW_E =  20  # Extra width added to each side of an option.
    
    #===========================================================================
    # Section IV. Sound Settings
    # --------------------------------------------------------------------------
    # When text is being played out on the screen by a message. This can be
    # changed in game through the following script calls:
    #   $game_message.text_sound = "name"     Filename of sound to be played.
    #   $game_message.text_volume = 60        Volume of sound to be played.
    #   $game_message.text_pitch  = 100       Pitch of sound to be played.
    #===========================================================================
    
    # This adjusts the default sound that's played when text appears. If you
    # don't want to use this feature, just set this value to nil.
    SOUND_DEFAULT = "Cursor"
    
    # The sound pitch varies each time it's played by this amount. This is so
    # that the sound doesn't become monotonous and actually offers variability.
    # Set this value to 0 if you don't want any changes.
    SOUND_PITCH_OFFSET = 3
    
    #===========================================================================
    # Section V. Message Window-Only Font
    # --------------------------------------------------------------------------
    # Custom Message Melody will also separate the in-game font from the message
    # window font. This way, fancier-looking fonts can be used for dialogue
    # while more systematically appropriate fonts can be used for game material.
    #===========================================================================
    
    # This array constant determines the fonts used. If the first font does not
    # exist on the player's computer, the next font in question will be used
    # in place instead and so on.
    MESSAGE_WINDOW_FONT = ["Verdana", "Arial", "Courier New"]

    MSG_BACKGROUND = {
      "normal"      => 0,
      "dark"        => 1,
      "transparent" => 2
    }
    MSG_POSITION = {
      "bottom"   => 2,
      "middle"   => 1,
      "top"      => 0
    }
    
  end # MESSAGE
end # YEM

#===============================================================================
# Lunatic Mode - Custom Message System
#===============================================================================
# 
# This portion is for those who know how to script and would like to use various
# tags to produce easy Lunatic Mode shortcuts.
# 
# \X[x] or \X[x:y] or \X[x:y:z]
# These let you create your own custom tags. If you use the first tag, there is
# one case for the "custom_convert" definition to return. If you use the second
# tag, there will be two cases for you to select from. And likewise, if there's
# three tags, then the z case will also be taken into account of.
# 
#===============================================================================

class Window_Message < Window_Selectable
  
  #--------------------------------------------------------------------------
  # new method: self.custom_convert
  #--------------------------------------------------------------------------
  def self.custom_convert(x_case, y_case = 0, z_case = 0)
    text = ""
    case x_case
    #----------------------------------------------------------------------
    # Start editting here.
    #----------------------------------------------------------------------
    when 1 # Show the full name of the actor.
      case y_case # This is the extra case for the actor.
      when 1
        text = "\\n[1] von Xiguel"
      when 2
        text = "Michelle \\n[2]"
      when 3
        text = "\\n[3] Manfred"
      when 4
        text = "\\n[4] Fernaeus"
      end
      
    when 2 # Show how much gold the party has.
      text = $game_party.gold
      
    when 3 # Show party's max level
      text = $game_party.max_level
      
    #----------------------------------------------------------------------
    # Stop editting past this point.
    #----------------------------------------------------------------------
    end
    return text
  end
  
end # Window_Message

#===============================================================================
# Editting anything past this point may potentially result in causing computer
# damage, incontinence, explosion of user's head, coma, death, and/or halitosis.
# Therefore, edit at your own risk.
#===============================================================================

#===============================================================================
# Game_Message
#===============================================================================

class Game_Message
  
  #--------------------------------------------------------------------------
  # public instance variables
  #--------------------------------------------------------------------------
  attr_accessor :text_sound
  attr_accessor :text_volume
  attr_accessor :text_pitch
  attr_accessor :choice_text
  
  #--------------------------------------------------------------------------
  # alias method: initialize
  #--------------------------------------------------------------------------
  alias initialize_cms initialize unless $@
  def initialize
    @text_sound  = YEM::MESSAGE::SOUND_DEFAULT
    @text_volume = 60
    @text_pitch  = 100
    initialize_cms
  end
  
  #--------------------------------------------------------------------------
  # alias method: clear
  #--------------------------------------------------------------------------
  alias clear_cms clear unless $@
  def clear
    @choice_text = []
    clear_cms
  end
  
end # Game_Message

#===============================================================================
# Game_Interpreter
#===============================================================================

class Game_Interpreter
  
  #--------------------------------------------------------------------------
  # overwrite method: command_101 (Show Text)
  #--------------------------------------------------------------------------
  def command_101
    unless $game_message.busy
      $game_message.face_name = @params[0]
      $game_message.face_index = @params[1]
      $game_message.background = $msg_params ? YEM::MESSAGE::MSG_BACKGROUND[$msg_params[0]] : @params[2]
      $game_message.position = $msg_params ? YEM::MESSAGE::MSG_POSITION[$msg_params[1]] : @params[3]
      flow = true
      loop {
        if @list[@index].code == 101 and meet_stringing_conditions and flow
          @index += 1
        else
          break
        end
        flow = @row_check
        while @list[@index].code == 401 and meet_stringing_conditions
          $game_message.texts.push(@list[@index].parameters[0])
          @index += 1
        end }
      if @list[@index].code == 102 # Show choices
        setup_choices(@list[@index].parameters)
      elsif @list[@index].code == 103 # Number input processing
        setup_num_input(@list[@index].parameters)
      end
      set_message_waiting # Set to message wait state
    end
    return false
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: setup_choices
  #--------------------------------------------------------------------------
  def setup_choices(params)
    var = $game_variables[YEM::MESSAGE::ROW_VARIABLE]
    rows = (var <= 0) ? 4 : var
    return unless $game_message.texts.size <= rows - params[0].size or
      $game_variables[YEM::MESSAGE::CHOICE_VARIABLE] > 0
    $game_message.choice_start = $game_message.texts.size
    $game_message.choice_max = params[0].size
    for s in params[0]
      $game_message.texts.push(s)
    end
    $game_message.choice_cancel_type = params[1]
    $game_message.choice_proc = Proc.new { |n| @branch[@indent] = n }
    @index += 1
  end
  
  #--------------------------------------------------------------------------
  # new method: meet_stringing_conditions
  #--------------------------------------------------------------------------
  def meet_stringing_conditions
    var = $game_variables[YEM::MESSAGE::ROW_VARIABLE]
    rows = (var <= 0) ? 4 : var
    @row_check = (rows > 4) ? true : false
    return true if rows > $game_message.texts.size
    return false
  end
  
end # Game_Interpreter

#===============================================================================
# Window_Message
#===============================================================================

class Window_Message < Window_Selectable
  
  #--------------------------------------------------------------------------
  # public instance variables
  #--------------------------------------------------------------------------
  attr_accessor :position
  
  #--------------------------------------------------------------------------
  # alias method: initialize
  #--------------------------------------------------------------------------
  alias initialize_cms initialize unless $@
  def initialize
    initialize_cms
    var = $game_variables[YEM::MESSAGE::ROW_VARIABLE]
    @max_rows = (var <= 0) ? 4 : var
    nheight = YEM::MESSAGE::NAME_WINDOW_H
    @choice_window = Window_MessageChoice.new(self)
    @name_window = Window_Base.new(YEM::MESSAGE::NAME_WINDOW_X, 0, 100, nheight)
    @name_text = Window_Base.new(YEM::MESSAGE::NAME_WINDOW_X, 0, 100, 56)
    @name_window.openness = 0
    @name_text.openness = 0
    @name_text.opacity = 0
    @name_window.z = self.z + 1
    @name_text.z = @name_window.z + 1
    @name_window_lock = false
  end
  
  #--------------------------------------------------------------------------
  # alias method: dispose
  #--------------------------------------------------------------------------
  alias dispose_cms dispose unless $@
  def dispose
    dispose_cms
    @name_window.dispose if @name_window != nil
    @name_text.dispose if @name_text != nil
    @choice_window.dispose if @choice_window != nil
  end
  
  #--------------------------------------------------------------------------
  # new method: close
  #--------------------------------------------------------------------------
  def close
    super
    @choice_window.close
    @name_window.close
    @name_text.close
    @name_window_lock = false
  end
  
  #--------------------------------------------------------------------------
  # alias method: update
  #--------------------------------------------------------------------------
  alias update_cms update unless $@
  def update
    @name_window.update
    @name_text.update
    @choice_window.update
    update_cms
  end
  
  #--------------------------------------------------------------------------
  # new method: refresh_size
  #--------------------------------------------------------------------------
  def refresh_size
    var = $game_variables[YEM::MESSAGE::ROW_VARIABLE]
    $game_variables[YEM::MESSAGE::ROW_VARIABLE] = 4 if var <= 0
    @max_rows = (var <= 0) ? 4 : var
    calc_height = @max_rows * 24 + 32
    $game_variables[YEM::MESSAGE::WIDTH_VARIABLE] = Graphics.width if
      $game_variables[YEM::MESSAGE::WIDTH_VARIABLE] <= 0
    widthvar = [$game_variables[YEM::MESSAGE::WIDTH_VARIABLE], 32].max
    $game_variables[YEM::MESSAGE::WIDTH_VARIABLE] = [widthvar, 32].max
    if (self.height != calc_height) or (widthvar != self.width)
      self.height = calc_height
      self.width = [widthvar, Graphics.width].min
      self.x = (Graphics.width - self.width) / 2
      create_contents
    end
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: reset_window
  #--------------------------------------------------------------------------
  def reset_window
    var = $game_variables[YEM::MESSAGE::ROW_VARIABLE]
    wheight = var <= 0 ? 4 * 24 + 32 : var * 24 + 32
    @background = $game_message.background
    @position = $game_message.position
    self.opacity = (@background == 0) ? 255 : 0
    case @position
    when 0  # Top
      self.y = 0
      @gold_window.y = 360
    when 1  # Middle
      self.y = (Graphics.height - wheight) / 2
      @gold_window.y = 0
    when 2  # Bottom
      self.y = (Graphics.height - wheight)
      @gold_window.y = 0
    end
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: input_pause
  #--------------------------------------------------------------------------
  def input_pause
    if Input.trigger?(Input::B) or Input.trigger?(Input::C) or
    Input.press?(YEM::MESSAGE::TEXT_SKIP)
      self.pause = false
      if @text != nil and not @text.empty?
        new_page if @line_count >= MAX_LINE
      else
        terminate_message
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # called method: actor_face_art
  #--------------------------------------------------------------------------
  def self.actor_face_art(value)
    if value == 0 and $game_party.members[0] != nil
      $game_message.face_name  = $game_party.members[0].face_name
      $game_message.face_index = $game_party.members[0].face_index
    elsif $game_actors[value] != nil
      $game_message.face_name  = $game_actors[value].face_name
      $game_message.face_index = $game_actors[value].face_index
    end
    return ""
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: start_message
  #--------------------------------------------------------------------------
  def start_message
    refresh_size
    @text = ""
    choice_type = $game_variables[YEM::MESSAGE::CHOICE_VARIABLE]
    for i in 0...$game_message.texts.size
      if choice_type > 0 and i >= $game_message.choice_start
        $game_message.choice_text += [$game_message.texts[i].clone]
      else
        @text += YEM::MESSAGE::CHOICE_INDENT if i >= $game_message.choice_start
        @text += $game_message.texts[i].clone + "\x00"
      end
    end
    @item_max = $game_message.choice_max
    convert_special_characters
    reset_window
    new_page
  end
  
  #--------------------------------------------------------------------------
  # alias method: new_page
  #--------------------------------------------------------------------------
  alias new_page_cms new_page unless $@
  def new_page
    new_page_cms
    @name_window.update_windowskin if $imported["SystemGameOptions"]
    self.contents.font.name = YEM::MESSAGE::MESSAGE_WINDOW_FONT
    self.contents.font.size = Font.default_size
    self.contents.font.bold = Font.default_bold
    self.contents.font.italic = Font.default_italic
    self.contents.font.shadow = Font.default_shadow
  end
  
  #--------------------------------------------------------------------------
  # combination_class
  #--------------------------------------------------------------------------
  def combination_class(actor)
    return "" if actor == nil
    class1 = actor.class.name
    return class1 unless $imported["JobSystemClasses"]
    return class1 if actor.subclass == nil
    class2 = actor.subclass.name
    text = sprintf("%s/%s", class1, class2)
    text = YEM::JOB::COMBINATION_NAMES[text]
    return text
  end
  
  #--------------------------------------------------------------------------
  # refresh_name_box
  #--------------------------------------------------------------------------
  def refresh_name_box(name, side = 0)
    return if $game_temp.in_battle
    font_colour = YEM::MESSAGE::NAME_COLOUR
    font_name = Font.default_name
    font_size = Font.default_size
    font_bold = Font.default_bold
    font_italic = Font.default_italic
    font_shadow = Font.default_shadow
    icon = 0
    name_width = 0
    #---Convert Special Characters
    name = name.gsub(/\x01\{(\d+)\}/i) { 
      font_colour = $1.to_i; ""}
    name = name.gsub(/\x09\{(\d+)\}/i) {""}
    name = name.gsub(/\x10\{(\d+)\}/i) { 
      icon = $1.to_i; name_width += YEM::MESSAGE::ICON_WIDTH; ""}
    name = name.gsub(/\x11\{(\d+)\}/i) {
      font_size = $1.to_i; ""}
    name = name.gsub(/\x12\{(.*?)\}/i) {
      font_name = $1.to_s; ""}
    name = name.gsub(/\x13/i) {
      font_bold = true; ""}
    name = name.gsub(/\x14/i) {
      font_italic = true; ""}
    name = name.gsub(/\x15/i) {
      font_shadow = true; ""}
    #---Convert Special Characters
    @name_text.contents.font.name = YEM::MESSAGE::MESSAGE_WINDOW_FONT
    @name_text.contents.font.size = font_size
    @name_text.contents.font.bold = font_bold
    @name_text.contents.font.italic = font_italic
    @name_text.contents.font.shadow = font_shadow
    name_width += @name_text.contents.text_size(name).width
    name_width += YEM::MESSAGE::NAME_WINDOW_W
    @name_window.width = [name_width + 40, Graphics.width].min
    @name_text.width = @name_window.width
    var = $game_variables[YEM::MESSAGE::ROW_VARIABLE]
    wheight = var <= 0 ? 4 * 24 + 32 : var * 24 + 32
    position = $game_message.position
    case position
    when 0
      @name_window.y = self.height - YEM::MESSAGE::NAME_WINDOW_H
      @name_window.y += YEM::MESSAGE::NAME_WINDOW_Y
    when 1
      @name_window.y = (Graphics.height - wheight) / 2
      @name_window.y -= YEM::MESSAGE::NAME_WINDOW_Y
    when 2
      @name_window.y = (Graphics.height - wheight)
      @name_window.y -= YEM::MESSAGE::NAME_WINDOW_Y
    end
    offset = (@name_text.height - @name_window.height) / 2
    @name_text.y = @name_window.y - offset
    if YEM::MESSAGE::NAME_WINDOW_SHOW_BACK and $game_message.background == 0
      @name_window.opacity = 255
    else
      @name_window.opacity = 0
    end
    if side == 0
      @name_window.x = [YEM::MESSAGE::NAME_WINDOW_X + self.x, 0].max
    else
      @name_window.x = self.x + self.width - @name_window.width
      @name_window.x -= YEM::MESSAGE::NAME_WINDOW_X
      @name_window.x = self.x + self.width - @name_window.width if
        (@name_window.x + @name_window.width) > Graphics.width
    end
    @name_text.x = @name_window.x
    @name_window.create_contents
    @name_text.create_contents
    txh = [font_size + (font_size / 5), WLH].max
    @name_text.contents.font.color = text_color(font_colour)
    @name_text.contents.font.name = YEM::MESSAGE::MESSAGE_WINDOW_FONT
    @name_text.contents.font.size = font_size
    @name_text.contents.font.bold = font_bold
    @name_text.contents.font.italic = font_italic
    @name_text.contents.font.shadow = font_shadow
    if icon > 0
      iw = YEM::MESSAGE::ICON_WIDTH
      @name_text.draw_icon(icon, YEM::MESSAGE::NAME_WINDOW_W / 2, 0)
      @name_text.contents.draw_text(iw, 0, name_width + 8 - iw, txh, name, 1)
    else
      @name_text.contents.draw_text(0, 0, name_width + 8, txh, name, 1)
    end
    @name_window.open
    @name_text.open
    @name_window_open = true
  end
  
  #--------------------------------------------------------------------------
  # alias method: start_choice
  #--------------------------------------------------------------------------
  alias start_choice_cms start_choice unless $@
  def start_choice
    self.active = true
    if $game_variables[YEM::MESSAGE::CHOICE_VARIABLE] > 0
      @choice_window.appear
      self.index = -1
    else
      self.active = true
      self.index = 0
    end
  end
  
  #--------------------------------------------------------------------------
  # alias method: input_choice
  #--------------------------------------------------------------------------
  alias input_choice_cms input_choice unless $@
  def input_choice
    if Input.trigger?(Input::C) and @choice_window.active
      Sound.play_decision
      $game_message.choice_proc.call(@choice_window.index)
      @choice_window.disappear
      terminate_message
    elsif Input.trigger?(Input::B) and @choice_window.active
      if $game_message.choice_cancel_type > 0
        Sound.play_cancel
        $game_message.choice_proc.call($game_message.choice_cancel_type - 1)
        @choice_window.disappear
        terminate_message
      end
    else
      input_choice_cms
    end
  end
  
  #--------------------------------------------------------------------------
  # new method: play_text_sound
  #--------------------------------------------------------------------------
  def play_text_sound
    return if $game_message.text_sound == nil
    return if @line_show_fast or @show_fast
    name  = $game_message.text_sound
    $game_message.text_volume = 60 if $game_message.text_volume == nil
    vol   = $game_message.text_volume
    $game_message.text_pitch = 100 if $game_message.text_pitch == nil
    pitch = $game_message.text_pitch
    pitch += rand(YEM::MESSAGE::SOUND_PITCH_OFFSET)
    pitch -= rand(YEM::MESSAGE::SOUND_PITCH_OFFSET)
    RPG::SE.new(name, vol, pitch).play
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: convert_special_characters
  #--------------------------------------------------------------------------
  def convert_special_characters
    @name_window_open = false
    @text = Window_Message.convert_regexp(@text)
    #-------------------------------------------------------------
    # Name box REGEXP Conversions
    #-------------------------------------------------------------
    @text.gsub!(/\\NB\[(.*?)\]/i) { 
      if $1.to_s != nil
        refresh_name_box($1.to_s)
      end; "" }
    @text.gsub!(/\\NBL\[(.*?)\]/i) { 
      if $1.to_s != nil
        refresh_name_box($1.to_s)
        @name_window_lock = true
      end; "" }
    @text.gsub!(/\\NBU\[(.*?)\]/i) { 
      if $1.to_s != nil
        refresh_name_box($1.to_s)
        @name_window_lock = false
      end; "" }
    @text.gsub!(/\\NBU/i) { 
      @name_window.close
      @name_text.close
      @name_window_lock = false
      "" }
    @text.gsub!(/\\RNB\[(.*?)\]/i) { 
      if $1.to_s != nil
        refresh_name_box($1.to_s, 1)
      end; "" }
    @text.gsub!(/\\RNBL\[(.*?)\]/i) { 
      if $1.to_s != nil
        refresh_name_box($1.to_s, 1)
        @name_window_lock = true
      end; "" }
    @text.gsub!(/\\RNBU\[(.*?)\]/i) { 
      if $1.to_s != nil
        refresh_name_box($1.to_s, 1)
        @name_window_lock = false
      end; "" }
    # Close the Name Window
    unless @name_window_lock
      @name_window.close if !@name_window_open
      @name_text.close if !@name_window_open
    end
  end
  
end # Window_Message

#===============================================================================
# Window_MessageChoice
#===============================================================================

class Window_MessageChoice < Window_Selectable
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize(parent_window)
    @parent = parent_window
    dx = @parent.x; dy = @parent.y; dw = @parent.width; dh = @parent.height
    super(dx, dy-dh, dw, dh)
    self.openness = 0
    self.active = false
    self.z = @parent.z + 1
  end
  
  #--------------------------------------------------------------------------
  # appear
  #--------------------------------------------------------------------------
  def appear
    self.update_windowskin if $imported["SystemGameOptions"]
    self.open
    self.active = true
    self.index = 0
    refresh
  end
  
  #--------------------------------------------------------------------------
  # disappear
  #--------------------------------------------------------------------------
  def disappear
    self.update_windowskin if $imported["SystemGameOptions"]
    self.close
    self.active = false
    self.index = -1
  end
  
  #--------------------------------------------------------------------------
  # refresh
  #--------------------------------------------------------------------------
  def refresh
    self.contents.clear
    reset_content_settings
    @data = []
    for i in $game_message.choice_text
      @text = Window_Message.convert_regexp(i)
      @data += [@text]
    end
    @type = $game_variables[YEM::MESSAGE::CHOICE_VARIABLE]
    self.width = [calc_width, Graphics.width].min
    case @type
    when 1, 4
      centered_window
    when 2, 5
      self.x = @parent.width - self.width + @parent.x
      self.x -= YEM::MESSAGE::CHOICE_WINDOW_X unless @type == 5
      centered_window if Graphics.width - self.x - self.width > self.x
    when 3, 6
      self.width = calc_width
      self.x = @parent.x
      self.x += YEM::MESSAGE::CHOICE_WINDOW_X unless @type == 6
      centered_window if self.x > Graphics.width - self.x - self.width
    end
    self.x = [self.x, 0].max
    self.x = Graphics.width - self.width if self.x + self.width > Graphics.width
    self.height = 32 + @data.size * WLH
    case @parent.position
    when 0, 1
      self.y = @parent.height + @parent.y
      self.y -= YEM::MESSAGE::CHOICE_WINDOW_Y
    when 2
      self.y = @parent.y - self.height
      self.y += YEM::MESSAGE::CHOICE_WINDOW_Y
    end
    @item_max = @data.size
    create_contents
    draw_choice_face
    for i in 0..(@item_max.size-1); draw_item(i); end
  end
    
  #--------------------------------------------------------------------------
  # centered_window
  #--------------------------------------------------------------------------
  def centered_window; self.x = (Graphics.width - self.width)/2; end
  
  #--------------------------------------------------------------------------
  # face_types
  #--------------------------------------------------------------------------
  def face_types; return [4,5,6]; end
  
  #--------------------------------------------------------------------------
  # reset_content_settings
  #--------------------------------------------------------------------------
  def reset_content_settings
    self.contents.font.color = normal_color
    self.contents.font.name = YEM::MESSAGE::MESSAGE_WINDOW_FONT
    self.contents.font.size = Font.default_size
    self.contents.font.bold = Font.default_bold
    self.contents.font.italic = Font.default_italic
    self.contents.font.shadow = Font.default_shadow
  end
  
  #--------------------------------------------------------------------------
  # calc_width
  #--------------------------------------------------------------------------
  def calc_width
    max_size = YEM::MESSAGE::CHOICE_WINDOW_W
    for text in @data
      text_width = contents.text_size(text).width
      text_width += 32
      max_size = [text_width, max_size].max
    end
    max_size += YEM::MESSAGE::CHOICE_WINDOW_E
    max_size += 112 if face_types.include?(@type)
    return max_size
  end
  
  #--------------------------------------------------------------------------
  # draw_choice_face
  #--------------------------------------------------------------------------
  def draw_choice_face
    return unless face_types.include?(@type)
    if $game_variables[YEM::MESSAGE::FACE_VARIABLE] <= 0
      index = -1 * $game_variables[YEM::MESSAGE::FACE_VARIABLE]
      index = [$game_party.members.size-1, index].min
      actor = $game_party.members[index]
    else
      actor = $game_actors[$game_variables[YEM::MESSAGE::FACE_VARIABLE]]
      actor = $game_party.members[0] if actor == nil
    end
    draw_actor_face(actor, 0, 0)
  end
  
  #--------------------------------------------------------------------------
  # draw_item
  #--------------------------------------------------------------------------
  def draw_item(index)
    rect = item_rect(index)
    self.contents.clear_rect(rect)
    reset_content_settings
    text = @data[index]
    return if text == nil
    align = 0; icon = 0; rect.width -= 8; dx = rect.x
    text.gsub!(/\x01\{(\d+)\}/i) { 
      self.contents.font.color = text_color($1.to_i); ""}
    text.gsub!(/\x10\{(\d+)\}/i) { 
      icon = $1.to_i; dx += 24; ""}
    text.gsub!(/\x11\{(\d+)\}/i) {
      self.contents.font.size = $1.to_i; ""}
    text.gsub!(/\x12\{(.*?)\}/i) {
      self.contents.font.name = $1.to_s; ""}
    text.gsub!(/\x13/i) {
      self.contents.font.bold = !self.contents.font.bold; ""}
    text.gsub!(/\x14/i) {
      self.contents.font.italic = !self.contents.font.italic; ""}
    text.gsub!(/\x15/i) {
      self.contents.font.shadow = !self.contents.font.shadow; ""}
    text.gsub!(/\x16\{(\d+)\}/i) { 
      align = $1.to_i; ""}
    dx += 4 if icon == 0
    draw_icon(icon, rect.x, rect.y)
    self.contents.draw_text(dx, rect.y, rect.width, WLH, text, align)
  end
  
  #--------------------------------------------------------------------------
  # item_rect
  #--------------------------------------------------------------------------
  def item_rect(index)
    if face_types.include?(@type)
      rect = Rect.new(0, 0, 0, 0)
      rect.width = (contents.width + @spacing) / @column_max - @spacing - 112
      rect.height = WLH
      rect.x = 112 + index % @column_max * (rect.width + @spacing)
      rect.y = (index / @column_max * WLH)
      return rect
    else
      return super(index)
    end
  end
  
end # Window_MessageChoice

#===============================================================================
# --- Window_Message ---
# This is another instance of Window_Message and placed down here for easier
# future editting and adding of more tags.
#===============================================================================

class Window_Message < Window_Selectable
  
  #--------------------------------------------------------------------------
  # called method: convert_regexp
  #--------------------------------------------------------------------------
  def self.convert_regexp(text)
    @text = text
    #-------------------------------------------------------------
    # Default REGEXP Conversions
    #-------------------------------------------------------------
    @text.gsub!(/\\V\[(\d+)\]/i)    { $game_variables[$1.to_i] }
    @text.gsub!(/\\V\[(\d+)\]/i)    { $game_variables[$1.to_i] }
    
    #-------------------------------------------------------------
    # Lunatic REGEXP Conversions
    #-------------------------------------------------------------
    @text.gsub!(/\\X\[(\d+)\]/i) {
      Window_Message.custom_convert($1.to_i) }
    @text.gsub!(/\\X\[(\d+):(\d+)\]/i) {
      Window_Message.custom_convert($1.to_i, $2.to_i) }
    @text.gsub!(/\\X\[(\d+):(\d+):(\d+)\]/i) {
      Window_Message.custom_convert($1.to_i, $2.to_i, $3.to_i) }
    
    #-------------------------------------------------------------
    # Default REGEXP Conversions
    #-------------------------------------------------------------
    # @text.gsub!(/\\N\[0\]/i)        { $game_party.members[0].name }
    @text.gsub!(/\\N\[0\]/i)        { $local.get_text($game_actors[$1.to_i].name) }
    @text.gsub!(/\\F\[(\d+)\]/i)    { Window_Message.actor_face_art($1.to_i) }
    @text.gsub!(/\\N\[(\d+)\]/i)    { $game_actors[$1.to_i].name }
    @text.gsub!(/\\C\[(\d+)\]/i)    { "\x01{#{$1}}" }
    @text.gsub!(/\\G/i)             { "\x02" }
    @text.gsub!(/\\\./)             { "\x03" }
    @text.gsub!(/\\\|/)             { "\x04" }
    @text.gsub!(/\\!/)              { "\x05" }
    @text.gsub!(/\\>/)              { "\x06" }
    @text.gsub!(/\\</)              { "\x07" }
    @text.gsub!(/\\\^/)             { "\x08" }
    @text.gsub!(/\\\\/)             { "\\" }
    
    #-------------------------------------------------------------
    # New REGEXP Conversions
    #-------------------------------------------------------------
    @text.gsub!(/\\W\[(\d+)\]/i)    { "\x09{#{$1}}" }
    @text.gsub!(/\\I\[(\d+)\]/i)    { "\x10{#{$1}}" }
    @text.gsub!(/\\FS\[(\d+)\]/i)   { "\x11{#{$1}}" }
    @text.gsub!(/\\FN\[(.*?)\]/i)   { "\x12{#{$1}}" }
    @text.gsub!(/\\FB/i)            { "\x13" }
    @text.gsub!(/\\FI/i)            { "\x14" }
    @text.gsub!(/\\FH/i)            { "\x15" }
    @text.gsub!(/\\AL\[(\d+)\]/i)   { "\x16{#{$1}}" }
    
    #-------------------------------------------------------------
    # Victory Aftermath Conversions
    #-------------------------------------------------------------
    if $imported["VictoryAftermath"]
      @text.gsub!(/\\VF/i) { victory_face_art }
      @text.gsub!(/\\VN/i) { victory_actor_name }
    end
    
    #-------------------------------------------------------------
    # Automatic Actor REGEXP Conversions
    #-------------------------------------------------------------
    @text.gsub!(/\\AN\[(\d+)\]/i) { 
      if $game_actors[$1.to_i] != nil
        $game_actors[$1.to_i].name
      else; ""; end }
    @text.gsub!(/\\AC\[(\d+)\]/i) { 
      if $game_actors[$1.to_i] != nil
        $game_actors[$1.to_i].class.name
      else; ""; end }
    @text.gsub!(/\\AS\[(\d+)\]/i) { 
      if $imported["JobSystemClasses"] and 
      $game_actors[$1.to_i] != nil and
      $game_actors[$1.to_i].subclass != nil
        $game_actors[$1.to_i].subclass.name
      else; ""; end }
    @text.gsub!(/\\AX\[(\d+)\]/i) { 
      combination_class($game_actors[$1.to_i]) }
    @text.gsub!(/\\AF\[(\d+)\]/i) { 
      if $game_actors[$1.to_i] != nil
        $game_message.face_name = $game_actors[$1.to_i].face_name
        $game_message.face_index = $game_actors[$1.to_i].face_index
      end; "" }
    @text.gsub!(/\\AF\[(\d+):(\d+)\]/i) { 
      if $game_actors[$1.to_i] != nil
        $game_message.face_name = $game_actors[$1.to_i].face_name
        $game_message.face_index = $2.to_i
      end; "" }
    
    #-------------------------------------------------------------
    # Automatic Party REGEXP Conversions
    #-------------------------------------------------------------
    @text.gsub!(/\\PN\[(\d+)\]/i) { 
      if $game_party.members[$1.to_i] != nil
        $game_party.members[$1.to_i].name
      else; ""; end }
    @text.gsub!(/\\PC\[(\d+)\]/i) { 
      if $game_party.members[$1.to_i] != nil
        $game_party.members[$1.to_i].class.name
      else; ""; end }
    @text.gsub!(/\\PS\[(\d+)\]/i) { 
      if $imported["JobSystemClasses"] and 
      $game_party.members[$1.to_i] != nil and
      $game_party.members[$1.to_i].subclass != nil
        $game_party.members[$1.to_i].subclass.name
      else; ""; end }
    @text.gsub!(/\\PX\[(\d+)\]/i) { 
      combination_class($game_party.members[$1.to_i]) }
    @text.gsub!(/\\PF\[(\d+)\]/i) { 
      if $game_party.members[$1.to_i] != nil
        $game_message.face_name = $game_party.members[$1.to_i].face_name
        $game_message.face_index = $game_party.members[$1.to_i].face_index
      end; "" }
    @text.gsub!(/\\PF\[(\d+):(\d+)\]/i) { 
      if $game_party.members[$1.to_i] != nil
        $game_message.face_name = $game_party.members[$1.to_i].face_name
        $game_message.face_index = $2.to_i
      end; "" }
    
    #-------------------------------------------------------------
    # Auto Class, Item, Weapon, and Armour REGEXP Conversions
    #-------------------------------------------------------------
    @text.gsub!(/\\NC\[(\d+)\]/i) { 
      $data_classes[$1.to_i].name }
    @text.gsub!(/\\NI\[(\d+)\]/i) { 
      $data_items[$1.to_i].name }
    @text.gsub!(/\\NW\[(\d+)\]/i) { 
      $data_weapons[$1.to_i].name }
    @text.gsub!(/\\NA\[(\d+)\]/i) { 
      $data_armors[$1.to_i].name }
    @text.gsub!(/\\NS\[(\d+)\]/i) { 
      $data_skills[$1.to_i].name }
    @text.gsub!(/\\NT\[(\d+)\]/i) { 
      $data_states[$1.to_i].name }
    @text.gsub!(/\\II\[(\d+)\]/i) { 
      "\x10{#{$data_items[$1.to_i].icon_index}}" +
      "#{$data_items[$1.to_i].name}"}
    @text.gsub!(/\\IW\[(\d+)\]/i) { 
      "\x10{#{$data_weapons[$1.to_i].icon_index}}" +
      "#{$data_weapons[$1.to_i].name}"}
    @text.gsub!(/\\IA\[(\d+)\]/i) { 
      "\x10{#{$data_armors[$1.to_i].icon_index}}" +
      "#{$data_armors[$1.to_i].name}"}
    @text.gsub!(/\\IS\[(\d+)\]/i) { 
      "\x10{#{$data_skills[$1.to_i].icon_index}}" +
      "#{$data_skills[$1.to_i].name}"}
    @text.gsub!(/\\IT\[(\d+)\]/i) { 
      "\x10{#{$data_states[$1.to_i].icon_index}}" +
      "#{$data_states[$1.to_i].name}"}
    @text.gsub!(/\\\?/)             { "\xff" }
    return @text
  end
  
  #--------------------------------------------------------------------------
  # overwrite update_message
  #--------------------------------------------------------------------------
  def update_message
    loop do
      @line_show_fast = true if Input.press?(YEM::MESSAGE::TEXT_SKIP)
      text_height = [contents.font.size + (contents.font.size / 5), WLH].max
      c = @text.slice!(/./m)            # Get next text character
      case c
      #----------------------------------------------------------------------
      # Default Cases
      #----------------------------------------------------------------------
      when nil    # There is no text that must be drawn
        finish_message                  # Finish update
        break
      when "\x00" # New line
        new_line
        if @line_count >= @max_rows     # If line count is maximum
          unless @text.empty?           # If there is more
            self.pause = true           # Insert number input
            break
          end
        end
      when "\x01" # \C[n]  (text character color change)
        @text.sub!(/\{(\d+)\}/, "")
        self.contents.font.color = text_color($1.to_i)
        next
      when "\x02" # \G  (gold display)
        @gold_window.refresh
        @gold_window.open
      when "\x03" # \.  (wait 1/4 second)
        @wait_count = $game_switches[557] ? 0 : 15
        break
      when "\x04" # \|  (wait 1 second)
        @wait_count = $game_switches[557] ? 0 : 60
        break
      when "\x05" # \!  (Wait for input)
        self.pause = true
        break
      when "\x06" # \>  (Fast display ON)
        @line_show_fast = true
      when "\x07" # \<  (Fast display OFF)
        @line_show_fast = false
      when "\x08" # \^  (No wait for input)
        @pause_skip = true
        
      #----------------------------------------------------------------------
      # New Cases
      #----------------------------------------------------------------------
      when "\x09" # \|  Wait x frames
        @text.sub!(/\{(\d+)\}/, "")
        @wait_count = $1.to_i
        break
      when "\x10" # \i  Draws icon ID x
        @text.sub!(/\{(\d+)\}/, "")
        icon = $1.to_i
        icon_width = (24 - YEM::MESSAGE::ICON_WIDTH) / 2
        draw_icon(icon, @contents_x - icon_width, @contents_y)
        @contents_x += YEM::MESSAGE::ICON_WIDTH
      when "\x11" # \fs Font Size Change
        @text.sub!(/\{(\d+)\}/, "")
        size = $1.to_i
        if size <= 0 # If 0, revert back to the default font size.
          size = Font.default_size
        end
        self.contents.font.size = size
        text_height = [size + (size / 5), WLH].max
      when "\x12" # \fs Font Name Change
        @text.sub!(/\{(.*?)\}/, "")
        name = $1.to_s
        if name == "0" # If 0, revert back to the default font.
          name = Font.default_name
        end
        self.contents.font.name = name
      when "\x13" # \fb Font bold
        self.contents.font.bold = self.contents.font.bold ? false : true
      when "\x14" # \fi Font italic
        self.contents.font.italic = self.contents.font.italic ? false : true
      when "\x15" # \fi Font shadowed
        self.contents.font.shadow = self.contents.font.shadow ? false : true
      when "\x16" # Alignment change, for special choice boxes only.
        @text.sub!(/\{(\d+)\}/, "")
      when "\xff"
        # Do nothing
        
      #----------------------------------------------------------------------
      # Finish Up
      #----------------------------------------------------------------------
      else # Normal text character
        self.contents.draw_text(@contents_x, @contents_y, 40, text_height, c)
        c_width = self.contents.text_size(c).width
        @contents_x += c_width
        play_text_sound unless c == " "
      end
      break unless @show_fast or @line_show_fast
    end
  end
  
end # Window_Message

#===============================================================================
#
# END OF FILE
#
#===============================================================================