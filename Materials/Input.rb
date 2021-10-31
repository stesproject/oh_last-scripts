#===============================================================================
#** VX Input Module
#===============================================================================

module Input
    @keys = []
    @pressed = []
    Mouse_Left = 1
    Mouse_Right = 2
    Mouse_Middle = 4
    Back= 8
    Tab = 9
    Enter = 13
    Shift = 16
    Ctrl = 17
    Alt = 18
    Esc = 0x1B
    LT = 0x25
    UPs = 0x26  
    RT = 0x27 
    DN = 0x28
    Space = 32
    Numberkeys = {}
    Numberkeys[0] = 48
    Numberkeys[1] = 49
    Numberkeys[2] = 50
    Numberkeys[3] = 51
    Numberkeys[4] = 52
    Numberkeys[5] = 53
    Numberkeys[6] = 54
    Numberkeys[7] = 55
    Numberkeys[8] = 56
    Numberkeys[9] = 57
    Numberpad = {}
    Numberpad[0] = 45
    Numberpad[1] = 35
    Numberpad[2] = 40
    Numberpad[3] = 34
    Numberpad[4] = 37
    Numberpad[5] = 12
    Numberpad[6] = 39
    Numberpad[7] = 36
    Numberpad[8] = 38
    Numberpad[9] = 33
    Letters = {}
    Letters["A"] = 65
    Letters["B"] = 66
    Letters["C"] = 67
    Letters["D"] = 68
    Letters["E"] = 69
    Letters["F"] = 70
    Letters["G"] = 71
    Letters["H"] = 72
    Letters["I"] = 73
    Letters["J"] = 74
    Letters["K"] = 75
    Letters["L"] = 76
    Letters["M"] = 77
    Letters["N"] = 78
    Letters["O"] = 79
    Letters["P"] = 80
    Letters["Q"] = 81
    Letters["R"] = 82
    Letters["S"] = 83
    Letters["T"] = 84
    Letters["U"] = 85
    Letters["V"] = 86
    Letters["W"] = 87
    Letters["X"] = 88
    Letters["Y"] = 89
    Letters["Z"] = 90
    Fkeys = {}
    Fkeys[1] = 112
    Fkeys[2] = 113
    Fkeys[3] = 114
    Fkeys[4] = 115
    Fkeys[5] = 116
    Fkeys[6] = 117
    Fkeys[7] = 118
    Fkeys[8] = 119
    Fkeys[9] = 120
    Fkeys[10] = 121
    Fkeys[11] = 122
    Fkeys[12] = 123
    Collon = 186
    Equal = 187
    Comma = 188
    Underscore = 189
    Dot = 190
    Backslash = 191
    Lb = 219
    Rb = 221
    Quote = 222
    State = Win32API.new('user32','GetKeyState',['i'],'i')
    Key = Win32API.new('user32','GetAsyncKeyState',['i'],'i')
#-------------------------------------------------------------------------------
    USED_KEYS = [Mouse_Left, Mouse_Right, Mouse_Middle] 
#-------------------------------------------------------------------------------
  module_function
    #--------------------------------------------------------------------------  
    def Input.getstate(key)
      return true unless State.call(key).between?(0, 1)
      return false
    end
    #--------------------------------------------------------------------------
    def Input.testkey(key)
      Key.call(key) & 0x01 == 1
    end
    #--------------------------------------------------------------------------
    def Input.update
      @keys = []
      @keys.push(Input::Mouse_Left) if Input.testkey(Input::Mouse_Left)
      @keys.push(Input::Mouse_Right) if Input.testkey(Input::Mouse_Right)
      @keys.push(Input::Back) if Input.testkey(Input::Back)
      @keys.push(Input::Tab) if Input.testkey(Input::Tab)
      @keys.push(Input::Enter) if Input.testkey(Input::Enter)
      @keys.push(Input::Shift) if Input.testkey(Input::Shift)
      @keys.push(Input::Ctrl) if Input.testkey(Input::Ctrl)
      @keys.push(Input::Alt) if Input.testkey(Input::Alt)
      @keys.push(Input::Esc) if Input.testkey(Input::Esc)
      for key in Input::Letters.values
        @keys.push(key) if Input.testkey(key)
      end
      for key in Input::Numberkeys.values
        @keys.push(key) if Input.testkey(key)
      end
      for key in Input::Numberpad.values
        @keys.push(key) if Input.testkey(key)
      end
      for key in Input::Fkeys.values
        @keys.push(key) if Input.testkey(key)
      end
      @keys.push(Input::Collon) if Input.testkey(Input::Collon)
      @keys.push(Input::Equal) if Input.testkey(Input::Equal)
      @keys.push(Input::Comma) if Input.testkey(Input::Comma)
      @keys.push(Input::Underscore) if Input.testkey(Input::Underscore)
      @keys.push(Input::Dot) if Input.testkey(Input::Dot)
      @keys.push(Input::Backslash) if Input.testkey(Input::Backslash)
      @keys.push(Input::Lb) if Input.testkey(Input::Lb)
      @keys.push(Input::Rb) if Input.testkey(Input::Rb)
      @keys.push(Input::Quote) if Input.testkey(Input::Quote)
      @keys.push(Input::Space) if Input.testkey(Input::Space)
      @keys.push(Input::LT) if Input.testkey(Input::LT)
      @keys.push(Input::UPs) if Input.testkey(Input::UPs)
      @keys.push(Input::RT) if Input.testkey(Input::RT)
      @keys.push(Input::DN) if Input.testkey(Input::DN)
      @pressed = []
      @pressed.push(Input::Space) if Input.getstate(Input::Space)
      @pressed.push(Input::Mouse_Left) if Input.getstate(Input::Mouse_Left)
      @pressed.push(Input::Mouse_Right) if Input.getstate(Input::Mouse_Right)
      @pressed.push(Input::Back) if Input.getstate(Input::Back)
      @pressed.push(Input::Tab) if Input.getstate(Input::Tab)
      @pressed.push(Input::Enter) if Input.getstate(Input::Enter)
      @pressed.push(Input::Shift) if Input.getstate(Input::Shift)
      @pressed.push(Input::Ctrl) if Input.getstate(Input::Ctrl)
      @pressed.push(Input::Alt) if Input.getstate(Input::Alt)
      @pressed.push(Input::Esc) if Input.getstate(Input::Esc)
      @pressed.push(Input::LT) if Input.getstate(Input::LT)
      @pressed.push(Input::UPs) if Input.getstate(Input::UPs)
      @pressed.push(Input::RT) if Input.getstate(Input::RT)
      @pressed.push(Input::DN) if Input.getstate(Input::DN)
      for key in Input::Numberkeys.values
        @pressed.push(key) if Input.getstate(key)
      end
      for key in Input::Numberpad.values
        @pressed.push(key) if Input.getstate(key)
      end
      for key in Input::Letters.values
        @pressed.push(key) if Input.getstate(key)
      end
      for key in Input::Fkeys.values
        @pressed.push(key) if Input.getstate(key)
      end
      @pressed.push(Input::Collon) if Input.getstate(Input::Collon)
      @pressed.push(Input::Equal) if Input.getstate(Input::Equal)
      @pressed.push(Input::Comma) if Input.getstate(Input::Comma)
      @pressed.push(Input::Underscore) if Input.getstate(Input::Underscore)
      @pressed.push(Input::Dot) if Input.getstate(Input::Dot)
      @pressed.push(Input::Backslash) if Input.getstate(Input::Backslash)
      @pressed.push(Input::Lb) if Input.getstate(Input::Lb)
      @pressed.push(Input::Rb) if Input.getstate(Input::Rb)
      @pressed.push(Input::Quote) if Input.getstate(Input::Quote)  
    end
    #--------------------------------------------------------------------------
    def Input.triggerd?(key)
      return true if @keys.include?(key)
      return false
    end
    #--------------------------------------------------------------------------
    def Input.pressed?(key)
      return true if @pressed.include?(key)
      return false
    end
  #--------------------------------------------------------------------------
  # * 4 Diraction
  #--------------------------------------------------------------------------
  def Input.dir4
    return 2 if Input.pressed?(Input::DN)
    return 4 if Input.pressed?(Input::LT)
    return 6 if Input.pressed?(Input::RT)
    return 8 if Input.pressed?(Input::UPs)
    return 0
  end
  #--------------------------------------------------------------------------
  # * Trigger (key)
  #-------------------------------------------------------------------------- 
  def trigger?(key)
    keys = []
    case key
    when Input::DOWN
      keys.push(Input::DN)
    when Input::UP
      keys.push(Input::UPs)
    when Input::LEFT
      keys.push(Input::LT)
    when Input::RIGHT
      keys.push(Input::RT)
    when Input::A
      keys.push(Input::Shift)
    when Input::B
      keys.push(Input::Esc, Input::Numberpad[0], Input::Letters["X"])
    when Input::C
      keys.push(Input::Space, Input::Enter)
    when Input::L
      keys.push(Input::Letters["Q"])
    when Input::R
      keys.push(Input::Letters["W"])
    when Input::X
      keys.push(Input::Letters["A"])
    when Input::Y
      keys.push(Input::Letters["S"])
    when Input::Z
      keys.push(Input::Letters["D"]) 
    when Input::F5
      keys.push(Input::Fkeys[5])
    when Input::F6
      keys.push(Input::Fkeys[6])
    when Input::F7
      keys.push(Input::Fkeys[7])
    when Input::F8
      keys.push(Input::Fkeys[8])
    when Input::F9
      keys.push(Input::Fkeys[9])
    when Input::CTRL
      keys.push(Input::Ctrl)
    when Input::ALT
      keys.push(Input::Alt)
    else
      keys.push(key)
    end
    for k in keys
     if Input.triggerd?(k)
       return true
     end
   end
   return false
 end
  #--------------------------------------------------------------------------
  # * Repeat (key)
  #-------------------------------------------------------------------------- 
  def repeat?(key)
    keys = []
    case key
    when Input::DOWN
      keys.push(Input::DN)
    when Input::UP
      keys.push(Input::UPs)
    when Input::LEFT
      keys.push(Input::LT)
    when Input::RIGHT
      keys.push(Input::RT)
    when Input::A
      keys.push(Input::Shift)
    when Input::B
      keys.push(Input::Esc, Input::Numberpad[0], Input::Letters["X"])
    when Input::C
      keys.push(Input::Space, Input::Enter)
    when Input::L
      keys.push(Input::Letters["Q"])
    when Input::R
      keys.push(Input::Letters["W"])
    when Input::X
      keys.push(Input::Letters["A"])
    when Input::Y
      keys.push(Input::Letters["S"])
    when Input::Z
      keys.push(Input::Letters["D"]) 
    when Input::F5
      keys.push(Input::Fkeys[5])
    when Input::F6
      keys.push(Input::Fkeys[6])
    when Input::F7
      keys.push(Input::Fkeys[7])
    when Input::F8
      keys.push(Input::Fkeys[8])
    when Input::F9
      keys.push(Input::Fkeys[9])
    when Input::CTRL
      keys.push(Input::Ctrl)
    when Input::ALT
      keys.push(Input::Alt)
    else
      keys.push(key)
    end
    for k in keys
     if Input.triggerd?(k)
       return true
     end
   end
   return false
  end     
  #--------------------------------------------------------------------------
  # * Press (key)
  #-------------------------------------------------------------------------- 
  def press?(key)
    keys = []
    case key
    when Input::DOWN
      keys.push(Input::DN)
    when Input::UP
      keys.push(Input::UPs)
    when Input::LEFT
      keys.push(Input::LT)
    when Input::RIGHT
      keys.push(Input::RT)
    when Input::A
      keys.push(Input::Shift)
    when Input::B
      keys.push(Input::Esc, Input::Numberpad[0], Input::Letters["X"])
    when Input::C
      keys.push(Input::Space, Input::Enter)
    when Input::L
      keys.push(Input::Letters["Q"])
    when Input::R
      keys.push(Input::Letters["W"])
    when Input::X
      keys.push(Input::Letters["A"])
    when Input::Y
      keys.push(Input::Letters["S"])
    when Input::Z
      keys.push(Input::Letters["D"])  
    when Input::F5
      keys.push(Input::Fkeys[5])
    when Input::F6
      keys.push(Input::Fkeys[6])
    when Input::F7
      keys.push(Input::Fkeys[7])
    when Input::F8
      keys.push(Input::Fkeys[8])
    when Input::F9
      keys.push(Input::Fkeys[9])
    when Input::CTRL
      keys.push(Input::Ctrl)
    when Input::ALT
      keys.push(Input::Alt)
    else
      keys.push(key)
    end
    for k in keys
     if Input.pressed?(k)
       return true
     end
   end
   return false
  end     
  #--------------------------------------------------------------------------
  # * Check (key)
  #-------------------------------------------------------------------------- 
  def check(key)
    Win32API.new("user32","GetAsyncKeyState",['i'],'i').call(key) & 0x01 == 1  # key 0
  end
  #--------------------------------------------------------------------------
  # * Mouse Update
  #-------------------------------------------------------------------------- 
  def mouse_update
    @used_i = []
    for i in USED_KEYS
      x = check(i)
      if x == true
        @used_i.push(i)
      end
    end
  end
  #--------------------------------------------------------------------------
  # * Short Write C
  #-------------------------------------------------------------------------- 
  def Input.C
    Input.trigger?(C)
  end
  #--------------------------------------------------------------------------
  # * Short Write B
  #-------------------------------------------------------------------------- 
  def Input.B
    Input.trigger?(B)
  end
  #--------------------------------------------------------------------------
  # * Short Write A
  #-------------------------------------------------------------------------- 
  def Input.A
    Input.trigger?(A)
  end
  #--------------------------------------------------------------------------
  # * Short Write Down
  #-------------------------------------------------------------------------- 
  def Input.Down
    Input.trigger?(DOWN)
  end
  #--------------------------------------------------------------------------
  # * Short Write Up
  #-------------------------------------------------------------------------- 
  def Input.Up
    Input.trigger?(UP)
  end
  #--------------------------------------------------------------------------
  # * Short Write Right
  #-------------------------------------------------------------------------- 
  def Input.Right
    Input.trigger?(RIGHT)
  end
  #--------------------------------------------------------------------------
  # * Short Write Left
  #-------------------------------------------------------------------------- 
  def Input.Left
    Input.trigger?(LEFT)
  end
  #--------------------------------------------------------------------------
  # * Anykey pressed?  ( A or B or C or Down or Up or Right or Left )
  #-------------------------------------------------------------------------- 
  def Input.Anykey
    if A or B or C or Down or Up or Right or Left
      return true
    else
      return false
    end
  end
  def Input.name?(num)
    return "MOUSE PRIMARY" if num==1
    return "MOUSE SECONDARY" if num==2
    return "MOUSE MIDDLE" if num==4
    return "MOUSE 4TH" if num==5
    return "MOUSE 5TH" if num==6
    return "BACKSPACE" if num==8
    return "TAB" if num==9
    return "RETURN" if num==13
    return "SHIFT" if num==16
    return "CTLR" if num==17
    return "ALT" if num==18
    return "CAPS LOCK" if num==20
    return "ESCAPE" if num==27
    return "SPACE" if num==32
    return "PGUP" if num==33
    return "PGDN" if num==34
    return "END" if num==35
    return "HOME" if num==36
    return "LEFT" if num==37
    return "UP" if num==38
    return "RIGHT" if num==39
    return "DOWN" if num==40
    return "SNAPSHOT" if num==44
    return "INSERT" if num==45
    return "DELETE" if num==46
    return "0" if num==48
    return "1" if num==49
    return "2" if num==50
    return "3" if num==51
    return "4" if num==52
    return "5" if num==53
    return "6" if num==54
    return "7" if num==55
    return "8" if num==56
    return "9" if num==57
    return "A" if num==65
    return "B" if num==66
    return "C" if num==67
    return "D" if num==68
    return "E" if num==69
    return "F" if num==70
    return "G" if num==71
    return "H" if num==72
    return "I" if num==73
    return "J" if num==74
    return "K" if num==75
    return "L" if num==76
    return "M" if num==77
    return "N" if num==78
    return "O" if num==79
    return "P" if num==80
    return "Q" if num==81
    return "R" if num==82
    return "S" if num==83
    return "T" if num==84
    return "U" if num==85
    return "V" if num==86
    return "W" if num==87
    return "X" if num==88
    return "Y" if num==89
    return "Z" if num==90
    return "LWIN" if num==91
    return "RWIN" if num==92
    return "APPS" if num==93
    return "0" if num==96
    return "1" if num==97
    return "2" if num==98
    return "3" if num==99
    return "4" if num==100
    return "5" if num==101
    return "6" if num==102
    return "7" if num==103
    return "8" if num==104
    return "9" if num==105
    return "*" if num==106
    return "+" if num==107
    return "-" if num==109
    return "." if num==110
    return "/" if num==111
    return "F1" if num==112
    return "F2" if num==113
    return "F3" if num==114
    return "F4" if num==115
    return "F5" if num==116
    return "F6" if num==117
    return "F7" if num==118
    return "F8" if num==119
    return "F9" if num==120
    return "F10" if num==121
    return "F11" if num==122
    return "F12" if num==123
    return "NUM LOCK" if num==144
    return "SCROLL LOCK" if num==145
    return "LEFT SHIFT" if num==160
    return "RIGHT SHIFT" if num==161
    return "LEFT CTRL" if num==162
    return "RIGHT CTRL" if num==163
    return "LEFT ALT" if num==164
    return "RIGHT ALT" if num==165
    return ";" if num==186
    return "=" if num==187
    return "," if num==188
    return "_" if num==189
    return "." if num==190
    return "/" if num==191
    return "`" if num==192
    return "[" if num==219
    return " \\ " if num==220
    return "]" if num==221
    return "'" if num==222
    return "??? - " + "#{num}"
  end
end
