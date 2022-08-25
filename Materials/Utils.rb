class Utils
  @@location_picture_index = 7
  @@music_tracks = [
    RPG::BGM.new("title", 100, 125),
    RPG::BGM.new("fight-starts", 100, 110),
    RPG::BGM.new("memories", 100, 105),
    RPG::BGM.new("hard-times", 100, 100),
    RPG::BGM.new("castle", 100, 110),
    RPG::BGM.new("shelter", 85, 85),
    RPG::BGM.new("royal-gardens", 100, 100),
    RPG::BGM.new("lost-valley", 100, 100),
    RPG::BGM.new("desert", 100, 110),
    RPG::BGM.new("abandoned-area", 100, 105),
    RPG::BGM.new("seabed", 100, 70),
    RPG::BGM.new("jungle", 100, 100),
    RPG::BGM.new("fire-kingdom", 100, 115),
    RPG::BGM.new("secret-lab", 100, 105),
    RPG::BGM.new("final-act", 100, 125),
    RPG::BGM.new("battle", 100, 140),
    RPG::BGM.new("boss-fight", 100, 115),
    RPG::BGM.new("finalboss-battle-1", 100, 100),
    RPG::BGM.new("finalboss-battle-2", 100, 100),
    RPG::BGM.new("ending", 100, 110),
  ]
  $playing_track = ""

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
        $game_temp.common_event_id = 91 #Trofeo distributore esaurito
      end
    end
  end

  def self.check_variable(id)
    case id
    when 33 #Figurine
      if !$game_switches[493] && $game_switches[494] && $game_variables[33] == 60
        $game_temp.common_event_id = 89 #60 figurine?
      end
    when 36 #Gruppo
      if $game_switches[195] && $game_variables[36] == 3
        $game_temp.common_event_id = 35 #Spiega Grin
      end
    when 59 #Mission 2 (energies)
      $game_temp.common_event_id = 41 #Check mission 2
    when 71 #Mission 3 (torrette)
      $game_temp.common_event_id = 71 #Check mission 3
        if $game_switches[270] && !$game_switches[271] && $game_variables[71] == 3
          $game_temp.common_event_id = 45 #Check mission 3
        end
    when 101
      $game_temp.common_event_id = 72 #Check dispositivi (Secret Laboratory)
    end
  end

  def self.check_start()
    $game_temp.common_event_id = 8 #Set picture HUD Q sword
  end

  def self.get_missions_list()
    missions_switches1 = [70, 70, 350, 162, 189, 263]
    missions_switches2 = [334, 368, 389, 423, 445, 514]
    last_mission_switch = 495
    all_missions = missions_switches1.dup
    all_missions.concat(missions_switches2)

    @last_mission_index = $game_switches[last_mission_switch] ? 100 : 0
    all_missions.each_with_index do |id, index|
      if $game_switches[id]
        @last_mission_index += 1
      end
    end

    @missions_list = []
    @mission_index = 0

    def self.add_text(key)
      @mission_index += 1
      $local.set_common_msg(key)
      msg = $local.get_msg_vars
      msg[0] = @mission_index ==  @last_mission_index ? "\\c[0]#{msg[0]}" : "\\c[1]#{msg[0]}"
      msg.each {|t| @missions_list.push(t) if !t.empty? }
    end

    missions_switches1.each_with_index do |id, index|
      if $game_switches[id]
        key = "mission#{index + 1}"
        add_text(key)
      end
    end

    if $game_switches[316]
      if !$game_switches[334]
        key = "mission8" #Fire Kingdom
        add_text(key)
      end
    end

    missions_switches2.each_with_index do |id, index|
      if $game_switches[id]
        key = "mission#{index + missions_switches1.size + 1}"
        add_text(key)
      end
    end

    return @missions_list
  end

  def self.get_stats()
    stats_list = []

    color = $game_switches[495] ? "\\c[1]" : "\\c[0]"

    text = $local.get_text("stat_1")
    stats_list.push("#{color}#{text} \\v[54]%")

    text = $local.get_text("stat_2")
    stats_list.push("#{color}#{text} \\v[33]/60")

    text = $local.get_text("stat_3")
    stats_list.push("#{color}#{text} \\v[67]/8")

    text = $local.get_text("stat_4")
    stats_list.push("\\c[0]#{text} \\v[1]")

    text = $local.get_text("stat_5")
    stats_list.push("#{text} \\v[35]")

    text = $local.get_text("stat_6")
    stats_list.push("#{text} \\v[34]")

    return stats_list
  end

  def self.play_track(id)
    track = @@music_tracks[id]
    if $playing_track != track.name
      track.play
      $playing_track = track.name
    else
      RPG::BGM.stop
      $playing_track = ""
    end
  end

end