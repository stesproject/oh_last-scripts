class Vars_Initialization
  def initialize
    # Disable default menu
    $game_system.menu_disabled = true

    # Initialize
    $game_switches[11] = true #save mappa
    $game_switches[12] = true #save vittoria
    $game_switches[13] = true #save menu

    # Debug
    $game_switches[556] = $TEST && true #attack-up
    $game_switches[557] = $TEST && true #speed-up
    $game_switches[558] = $TEST && false #skip-wait
  end
end