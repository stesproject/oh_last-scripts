class Utils
  @@location_picture_index = 7

  def self.show_location(id)
    x_start = -300
    y_start = 350
    x_end = 0
    y_end = 370
    duration = 100
    locations = [
      "l1GI",
      "l2VS",
      "l3TD",
      "l4ZA",
      "l5FM",
      "l6GP",
      "l7RF",
      "l8LS",
      "l9AF",
    ]
    name = locations[id]
    $game_map.screen.pictures[@@location_picture_index].show(name, 0, x_start, y_start, 100, 100, 255, 0)
    $game_map.screen.pictures[@@location_picture_index].move(0, x_end, y_end, 100, 100, 255, 0, duration)
  end

  def self.hide_location()
    $game_map.screen.pictures[@@location_picture_index].erase
  end

  def self.check_switch(id)
    case id
    when 497 #distributore esaurito
      if !$game_switches[499]
        $data_common_events[91] #Trofeo distributore esaurito
      end
    end
  end

  def self.check_variable(id)
    case id
    when 33 #Figurine
      if !$game_switches[493] && $game_switches[494] $game_variables[33] == 60
        $data_common_events[89] #60 figurine?
      end
    when 36 #Gruppo
      if $game_switches[195] && $game_variables[36] == 3
        $data_common_events[35] #Spiega Grin
      end
    when 71 #tor totali
      if $game_switches[270] && !$game_switches[271] && $game_variables[71] == 3
        $data_common_events[45] #Torrette
      end
    end
  end
end