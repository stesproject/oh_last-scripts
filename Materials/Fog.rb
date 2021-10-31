#===============================================================================
#        .--** ADVANCED FOG SCRIPT **--.
#-------------------------------------------------------------------------------
#    di Shuuchan
#    versione 1.2
#    11-02-2009
#    RGSS2 / RPG Maker VX
#===============================================================================
#            .--** DESCRIZIONE **--.
#-------------------------------------------------------------------------------
#
#    Questo script permette di utilizzare delle immagini come Fog, in maniera
#    simile alla funzione "fog" di RPG Maker XP.
#    Lo script risolve alcuni problemi di altri "fog script" in circolazione,
#    in particolare l'impossibilità di salvare il gioco nelle mappe con fog
#    (cosa invece possibile con questo script).
#    
#===============================================================================
#            .--** ISTRUZIONI **--.
#-------------------------------------------------------------------------------
#
# 1) Copiare questo script nello Script Editor, sotto "Materials";
# 2) Importare/copiare le immagini da usare come fog nella cartella
#    "Graphics/Pictures" del proprio progetto;
# 3) Se si desidera che alcune mappe abbiano una fog già "pre-caricata",
#    modificare le IMPOSTAZIONI (al termine di queste Istruzioni);
# 4) Per mostrare una fog usare il seguente Call Script in un Evento:
#
#        Shuu_Fog.change(TEMPO,NOMEFILE,vel_x,vel_y,opacità,blend)
#
#    TEMPO    : il tempo impiegato (in frames, 60 frames = 1 secondo) per
#               mostrare la nuova fog. Lo stesso tempo viene impiegato anche per
#               cancellare una fog eventualmente già presente;
#    NOMEFILE : nome del file immagine da caricare (dev'essere nella cartella
#               "Graphics/Pictures"); il nome del file dev'essere scritto tra
#               virgolette (per esempio "immagine_02");
#
#    Le seguenti indicazioni possono anche venire omesse:
#
#    vel_x    : velocità di scorrimento orizzontale della fog. Se non viene
#               indicato, questo valore verrà impostato a 0 (fog con x fissa).
#               Numeri positivi indicano scorrimento verso sinistra, negativi
#               verso destra;
#    vel_y    : velocità di scorrimento verticale della fog. Se non viene
#               indicato, questo valore verrà impostato a 0 (fog con y fissa).
#               Numeri positivi indicano scorrimento verso l'alto, negativi
#               verso il basso;
#    opacità  : indica l'opacità (da 0 a 255) della fog. Se non viene indicato,
#               questo valore verrà impostato a 128;
#    blend    : indica il tipo di "blend" (sovrapposizione) per i colori della
#               fog (0 = normale / 1 = addizione, utile per gli effetti di luce
#               / 2 = sottrazione, utile per alcuni effetti di ombra). Se non
#               viene indicato, questo valore verrà impostato a 0 (normale).
#
#  5) Per cancellare una fog, inserire "" come nomefile nel Call Script.
#
#-------------------------------------------------------------------------------
#    ESEMPI
#-------------------------------------------------------------------------------
# ++ Questo Call Script:
#
#      Shuu_Fog.change(60,"img_01",0,5,64,1)
#
#    carica in 1 secondo una fog dall'immagine img_01, che si muove solo
#    verticalmente a velocità 5, con opacità 64 e blend type 1 (addizione).
#
# ++ Quest'altro invece:
#
#      Shuu_Fog.change(120, "")
#
#    cancella la fog presente nella mappa in 2 secondi.
#
# ++ Questo infine:
#
#      Shuu_Fog.change(30,"img_02",10)
#
#    carica in mezzo secondo la fog img_02 che si muove orizzontalmente a
#    velocità 10. La velocità verticale è 0 (non indicata), l'opacità è 128
#    (non indicata) e il blend type è 0 (normale, non indicato).
#===============================================================================
# ATTENZIONE! Script (non toccare! ^^)
class Scene_Title < Scene_Base
  alias shuu_fog_create_game_objects create_game_objects
  def create_game_objects
    shuu_fog_create_game_objects
#===============================================================================
#          .--** IMPOSTAZIONI **--.
#-------------------------------------------------------------------------------
#   Per pre-caricare una fog nelle mappe, inserire le impostazioni come da
#   esempio:
#
#   $fog_data = { Map_ID_A => [nomefile_A, vel_x, vel_y, opacità, blend],
#                 Map_ID_B => [nomefile_B, vel_x, vel_y, opacità, blend],
#                 ecc.
#                 ...
#                 Map_ID_? => [nomefile_?, vel_x, vel_y, opacità, blend]
#                 }
#
#   dove i Map_ID sono i vari ID delle mappe interessate.
#   In questo modo nelle mappe interessate verrà caricata automaticamente la fog
#   senza bisogno di utilizzare il Call Script.
#
#   Attenzione: qui tutti i dati da inserire sono obbligatori (anche vel_x, 
#   vel_y, ecc.).
#-------------------------------------------------------------------------------

    $fog_data = { 200 => ["001-Fog01", -5, -5, 128, 2]
                  }
                  
#-------------------------------------------------------------------------------
#       .--** FINE IMPOSTAZIONI **--.
#===============================================================================
    $fog_transition = 0
  end
  
end

class Scene_File < Scene_Base
  alias shuu_fog_write write_save_data
  alias shuu_fog_read read_save_data
  def write_save_data(file)
    shuu_fog_write(file)
    Marshal.dump($fog_data, file)
    Marshal.dump($fog_transition, file)
  end
  def read_save_data(file)
    shuu_fog_read(file)
    $fog_data = Marshal.load(file)
    $fog_transition = Marshal.load(file)
  end
end

module Shuu_Fog
  def self.change(transition,nomefile,vel_x=0,vel_y=0,opacity=128,blend=0)
    if $game_map.map_id != nil
      $fog_data[$game_map.map_id] = [nomefile, vel_x, vel_y, opacity, blend]
      $fog_transition = transition
    end
  end
end

class Spriteset_Map
  alias shuu_fog_initialize initialize
  alias shuu_fog_update update
  alias shuu_fog_dispose dispose
  
  def initialize
    create_fog
    shuu_fog_initialize
  end
  
  def update
    update_fog
    shuu_fog_update
  end
  
  def dispose
    dispose_fog
    shuu_fog_dispose
  end
  
  def create_fog
    @sprite_fog = Plane.new
    @sprite_fog.opacity = 0
    @sprite_fog.z = 10
    @fog_creata = false
    @data_fog = []
    @fog_vel_counter_x = 0
    @fog_vel_counter_y = 0
    @vel_x_fog = 0
    @vel_y_fog = 0
    @bit_wid = 1
    @bit_hei = 1
    @change_transition = 0
    if $fog_data.keys.include?($game_map.map_id)
      if $fog_data[$game_map.map_id][0] != ""
        @fog_creata = true
        @data_fog = $fog_data[$game_map.map_id]
        bitmap_base = Cache.picture($fog_data[$game_map.map_id][0])
        @sprite_fog.opacity = $fog_data[$game_map.map_id][3]
        @starting_opacity = @sprite_fog.opacity 
        @sprite_fog.blend_type = $fog_data[$game_map.map_id][4]
        @vel_x_fog = $fog_data[$game_map.map_id][1]
        @vel_y_fog = $fog_data[$game_map.map_id][2]
        @bit_wid = bitmap_base.width
        @bit_hei = bitmap_base.height
        @sprite_fog.bitmap = bitmap_base
      end
    end
  end
  
  def change_fog
    dispose_fog
    @sprite_fog = Plane.new
    @sprite_fog.opacity = 0
    @sprite_fog.z = 10
    @fog_creata = false
    @data_fog = []
    @fog_vel_counter_x = 0
    @fog_vel_counter_y = 0
    if $fog_data.keys.include?($game_map.map_id)
      if $fog_data[$game_map.map_id][0] != ""
        @fog_creata = true
        bitmap_base = Cache.picture($fog_data[$game_map.map_id][0])
        @sprite_fog.blend_type = $fog_data[$game_map.map_id][4]
        @vel_x_fog = $fog_data[$game_map.map_id][1]
        @vel_y_fog = $fog_data[$game_map.map_id][2]
        @bit_wid = bitmap_base.width
        @bit_hei = bitmap_base.height
        @sprite_fog.bitmap = bitmap_base
      end
    end
  end
  
  def update_fog
    if @fog_creata
      if @data_fog == $fog_data[$game_map.map_id]
        normal_update_fog
      else
        update_change_fog
      end
    else
      if $fog_data[$game_map.map_id] != nil
        update_change_fog
      end
    end
  end
  
  def normal_update_fog
    @fog_vel_counter_x += @vel_x_fog
    @fog_vel_counter_y += @vel_y_fog
    @fog_vel_counter_x -= @bit_wid*8 if @fog_vel_counter_x >= @bit_wid*8
    @fog_vel_counter_y -= @bit_hei*8 if @fog_vel_counter_y >= @bit_hei*8
    @sprite_fog.ox = ($game_map.display_x + @fog_vel_counter_x) / 8
    @sprite_fog.oy = ($game_map.display_y + @fog_vel_counter_y) / 8
  end
  
  def update_change_fog
    if @change_transition == 0
      @change_transition = $fog_transition
      @change_transition = 1 if @change_transition == 0
      @starting_opacity = @sprite_fog.opacity
      @destination_opacity = $fog_data[$game_map.map_id][3]
      @scompare = @starting_opacity
      @appare = 0
      @rapp_change = (@starting_opacity.to_f/@change_transition)#.ceil
      @new_rapp_change = (@destination_opacity.to_f/@change_transition)#.ceil
    end
    if $fog_transition > 0
      $fog_transition -= 1
      $fog_transition = 0 if $fog_transition < 0 or not @fog_creata
      @scompare -= @rapp_change
      @sprite_fog.opacity = @scompare.floor
      @sprite_fog.opacity = 0 if @sprite_fog.opacity < 0
      change_fog if $fog_transition == 0
    else
      @change_transition -= 1
      @change_transition = 0 if @change_transition < 0
      @appare += @new_rapp_change
      @sprite_fog.opacity = @appare.ceil
      @sprite_fog.opacity = @destination_opacity if @sprite_fog.opacity > @destination_opacity
      @data_fog = $fog_data[$game_map.map_id] if @change_transition == 0
    end
    normal_update_fog
  end
  
  def dispose_fog
    @sprite_fog.dispose
  end
  
end