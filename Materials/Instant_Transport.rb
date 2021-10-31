#==============================================================================
# Instant Transfer by Morhudiego, Member of rpg2s.net
# Date: 11th january of 2010
# Version: 1.1
# Permission required: no
# Credit required: yes
#------------------------------------------------------------------------------
# UPDATE BUG (italian)
# 1.0 : Uscita dello script
# 1.1 : Corretti errori di sintassi.
#
# UPDATE BUG (english)
# 1.0 : Script published
# 1.1 : Sintax errors corrected.
#------------------------------------------------------------------------------
# CONFIGURATION (italian)
# Cambiate l'id della variabile qui sotto (Se necessario) usata per impostare
# il tipo di dissolvenza.
# Poi in un evento usate il comando "Controllo Variabili" e assegnatene uno
# dei seguenti valori.
# Valore 0 = Dissolvenza normale (nera)
# Valore 1 = Dissolvenza immediata
# Altri valori = Messaggio di errore
#
# CONFIGURATION (english)
# Change the number of the variable (if necessary) used to set the kind of
# fadeout/fadein.
# Then use in an event the command "Variables" and assign it one of this
# values.
# Value 0 = Normal fade (black)
# Value 1 = Instant fade
# Other values = Error Message
#==============================================================================
class Scene_Map < Scene_Base
  #Cambia il numero con l'id della variabile.
  #Change this number with the variable id.
  TIPO_DI_FADE = 62
  attr_accessor :transfer_kind
  def update_transfer_player
    return unless $game_player.transfer?
    transfer_kind = $game_variables[TIPO_DI_FADE]
    if transfer_kind == 0
      $game_switches[527] = true
      fade = (Graphics.brightness > 0)
      fadeout(30) if fade
      @spriteset.dispose              # Dispose of sprite set
      $game_player.perform_transfer   # Execute player transfer
      $game_map.autoplay              # Automatically switch BGM and BGS
      $game_map.update
      Graphics.wait(15)
      @spriteset = Spriteset_Map.new  # Recreate sprite set
      fadein(30) if fade
      $game_switches[527] = false
      Input.update
    elsif transfer_kind == 1
      @spriteset.dispose              # Dispose of sprite set
      $game_player.perform_transfer   # Execute player transfer
      $game_map.autoplay              # Automatically switch BGM and BGS
      $game_map.update
      @spriteset = Spriteset_Map.new  # Recreate sprite set
      Input.update
    elsif transfer_kind == 2
      fade = (Graphics.brightness > 0)
      fadeout(10) if fade
      @spriteset.dispose              # Dispose of sprite set
      $game_player.perform_transfer   # Execute player transfer
      $game_map.autoplay              # Automatically switch BGM and BGS
      $game_map.update
      Graphics.wait(15)
      @spriteset = Spriteset_Map.new  # Recreate sprite set
      fadein(10) if fade
      Input.update
    else
      p 'id variabile invalido.'
      $game_variables[TIPO_DI_FADE] = 0
    end
  end
end