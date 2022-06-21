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
end