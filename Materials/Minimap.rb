#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
#_/   ◆                        MiniMap - KGC_MiniMap                     ◆ VX ◆
#_/   ◇                       Last Update: 2009/09/13                         ◇
#_/   ◆            Translation by Mr. Anonymous and Mr. Bubble                ◆
#_/   ◆ KGC Site:                                                             ◆
#_/   ◆ http://ytomy.sakura.ne.jp/                                            ◆
#_/----------------------------------------------------------------------------
#_/  This script creates a "minimap" of the current area and displays it on the
#_/ screen. Note that you may disable the MiniMap on a given map by tagging the
#_/ map's name with [NOMAP].
#_/============================================================================
#_/ Install: Insert above KGC_SetAttackElement, if applicable.
#_/============================================================================
#_/                   + How to make the minimap show up +
#_/   Activating/deactivating the map is determined by the game switch 
#_/you define for MINIMAP_SWITCH_ID in the customization section below. 
#_/
#_/         + Temporarily hiding and showing the minimap for scenes +
#_/   If you wish to temporarily hide the minimap for specific scenes 
#_/ without tampering with the game switch, use the following Script command 
#_/ in an event:
#_/         hide_minimap
#_/ To reveal the minimap again, use the following Script command in an event:
#_/         show_minimap
#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

#==============================================================================#
#                             ★ Customization ★                                #
#==============================================================================#

module KGC
module MiniMap
  #                          ◆ MiniMap Switch ◆
  # Here you may assign an in-game switch number to activate/deactivate the map.
  MINIMAP_SWITCH_ID = 5

  #                          ◆ Excluded Maps ◆
  EXCLUDED_MAPS = [15, 26, 33, 125, 152, 153, 154, 156, 157, 159, 160]

  #                   ◆ MiniMap Display Properties ◆
  # Here you may specify the X and Y coordinates as well as the width and height
  # of the MiniMap. 
  # Format:             X Coordinate    Y Coordinate     Width      Height
  MAP_RECT = Rect.new(          382,            2,       160,       120)
  
  #                         ◆ Map Z Coordinate ◆
  # Here you my specify the map's Z coordinate (depth).
  MAP_Z = 0
  
  #                      ◆ MiniMap Block Grid Size ◆
  # Here you may specify the grid size of the minimap. 3 or more is recommended.
  GRID_SIZE = 4

  #             ◆ MiniMap Foreground Color (Passable Space) ◆
  # Format:                     Red,   Green,   Blue,   Grey
  FOREGROUND_COLOR = Color.new( 224,     224,    255,    160)
  
  #              ◆ MiniMap Background Color (Not Passable) ◆
  # Format:                     Red,   Green,   Blue,   Grey
  BACKGROUND_COLOR = Color.new(   0,        0,   0,    150)

  #                   ◆ Current Position Marker Color ◆
  # Format:                     Red,   Green,   Blue,   Grey
  POSITION_COLOR   = Color.new( 250,       50,       0,   150)
  #                  ◆ Destination Event Marker Color ◆
  
  # To start this effect, the event must have [MOVE] in its name.
  #   Events with the tag [MOVE] will not have their position on the
  # minimap refresh until the player moves.
  # Format:                     Red,   Green,   Blue,   Grey
  MOVE_EVENT_COLOR = Color.new( 255,     160,      0,    192)

  #                      ◆ Custom Objects Colors ◆
  # Here you may specify different colors for different types of object markers.
  # For example, you may have NPCs labeled [OBJ 1] in the event's name, while 
  # monsters labeled at [OBJ 2] and so forth.
  # Please note that it's possible to add more, after OBJ 3. Just stick with
  # the format: Color.new(0, 0, 0, 192),  # [OBJ 4]
  OBJECT_COLOR = [
  # Format:   Red,   Green,   Blue,   Grey
    Color.new(  0,     160,      0,   192),  # [OBJ 1]
    Color.new(  0,     160,    160,   192),  # [OBJ 2]
    Color.new(160,       0,    160,   192),  # [OBJ 3]
    # Insert additional objects here.
    
  ]  # <- Do not remove!

  # ◆ Position Marker Blinking Strength ◆
  # Here you may specify how frequently the positional market blinks.
  # A range of 5 to 8 is recommended.
  BLINK_LEVEL = 7
  
  # ◆ Map Cache
  # When the number of maps in the cache exceeds this number, older
  # and unused maps in the cache gets removed.
  CACHE_NUM = 10
  
end
end

#=============================================================================#
#                          ★ End Customization ★                              #
#=============================================================================#


#=================================================#
#                    IMPORT                       #
#=================================================#

#★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★

$imported = {} if $imported == nil
$imported["MiniMap"] = true

if $data_mapinfos == nil
  $data_mapinfos = load_data("Data/MapInfos.rvdata")
end

#==============================================================================
# □ KGC::MiniMap::Regexp
#==============================================================================
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #
#                           Name Box Tag Strings                              #
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #
#  Whatever word(s) are after the separator ( | ) in the following lines are 
#   what are used to determine what is searched for in the name box of an event. 

module KGC::MiniMap
  module Regexp
    # ミニマップ非表示
    # NO_MINIMAP = /\[NOMAP\]/i
    NO_MINIMAP = KGC::MiniMap::EXCLUDED_MAPS.include?($game_map.map_id)
    # 障害物
    WALL_EVENT = /\[WALL\]/i
    # 移動イベント
    MOVE_EVENT = /\[MOVE\]/i
    # オブジェクト
    OBJECT = /\[OBJ(?:ECT)?\s*(\d)\]/i
  end
end

#★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★

#==============================================================================
# □ KGC::Commands
#==============================================================================

module KGC
module Commands
  module_function
  #--------------------------------------------------------------------------
  # ○ ミニマップを表示
  #--------------------------------------------------------------------------
  def show_minimap
    $game_system.minimap_show = true
  end
  #--------------------------------------------------------------------------
  # ○ ミニマップを隠す
  #--------------------------------------------------------------------------
  def hide_minimap
    $game_system.minimap_show = false
  end
  #--------------------------------------------------------------------------
  # ○ ミニマップをリフレッシュ
  #--------------------------------------------------------------------------
  def refresh_minimap
    return unless $scene.is_a?(Scene_Map)

    $game_map.refresh if $game_map.need_refresh
    $scene.refresh_minimap
  end
  #--------------------------------------------------------------------------
  # ○ ミニマップのオブジェクトを更新
  #--------------------------------------------------------------------------
  def update_minimap_object
    return unless $scene.is_a?(Scene_Map)

    $game_map.refresh if $game_map.need_refresh
    $scene.update_minimap_object
  end
end
end

class Game_Interpreter
  include KGC::Commands
end

#★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★

#==============================================================================
# ■ RPG::MapInfo
#==============================================================================

class RPG::MapInfo
  #--------------------------------------------------------------------------
  # ● マップ名取得
  #--------------------------------------------------------------------------
  def name
    return @name.gsub(/\[.*\]/) { "" }
  end
  #--------------------------------------------------------------------------
  # ○ オリジナルマップ名取得
  #--------------------------------------------------------------------------
  def original_name
    return @name
  end
  #--------------------------------------------------------------------------
  # ○ ミニマップのキャッシュ生成
  #--------------------------------------------------------------------------
  def create_minimap_cache
    @__minimap_show = !(@name =~ KGC::MiniMap::Regexp::NO_MINIMAP)
  end
  #--------------------------------------------------------------------------
  # ○ ミニマップ表示
  #--------------------------------------------------------------------------
  def minimap_show?
    create_minimap_cache if @__minimap_show == nil
    return @__minimap_show
  end
end

#★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★

#==============================================================================
# ■ Game_System
#==============================================================================

class Game_System
  #--------------------------------------------------------------------------
  # ○ ミニマップ表示フラグ取得
  #--------------------------------------------------------------------------
  def minimap_show
    return $game_switches[KGC::MiniMap::MINIMAP_SWITCH_ID]
  end
  #--------------------------------------------------------------------------
  # ○ ミニマップ表示フラグ変更
  #--------------------------------------------------------------------------
  def minimap_show=(value)
    $game_switches[KGC::MiniMap::MINIMAP_SWITCH_ID] = value
    $game_map.need_refresh = true
  end
end

#★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★

#==============================================================================
# ■ Game_Map
#==============================================================================

class Game_Map
  #--------------------------------------------------------------------------
  # ○ ミニマップを表示するか
  #--------------------------------------------------------------------------
  def minimap_show?
    return $data_mapinfos[map_id].minimap_show?
  end
end

#★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★

#==============================================================================
# ■ Game_Event
#==============================================================================

class Game_Event < Game_Character
  #--------------------------------------------------------------------------
  # ○ グラフィックがあるか
  #--------------------------------------------------------------------------
  def graphic_exist?
    return (character_name != "" || tile_id > 0)
  end
  #--------------------------------------------------------------------------
  # ○ 障害物か
  #--------------------------------------------------------------------------
  def is_minimap_wall_event?
    return (@event.name =~ KGC::MiniMap::Regexp::WALL_EVENT)
  end
  #--------------------------------------------------------------------------
  # ○ 移動イベントか
  #--------------------------------------------------------------------------
  def is_minimap_move_event?
    return (@event.name =~ KGC::MiniMap::Regexp::MOVE_EVENT)
  end
  #--------------------------------------------------------------------------
  # ○ ミニマップオブジェクトか
  #--------------------------------------------------------------------------
  def is_minimap_object?
    return (@event.name =~ KGC::MiniMap::Regexp::OBJECT)
  end
  #--------------------------------------------------------------------------
  # ○ ミニマップオブジェクトタイプ
  #--------------------------------------------------------------------------
  def minimap_object_type
    if @event.name =~ KGC::MiniMap::Regexp::OBJECT
      return $1.to_i
    else
      return 0
    end
  end
end

#★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★

#==============================================================================
# □ Game_MiniMap
#------------------------------------------------------------------------------
#   ミニマップを扱うクラスです。
#==============================================================================

class Game_MiniMap
  #--------------------------------------------------------------------------
  # ○ 構造体
  #--------------------------------------------------------------------------
  Point = Struct.new(:x, :y)
  Size  = Struct.new(:width, :height)
  PassageCache = Struct.new(:map_id, :table, :scan_table)
  #--------------------------------------------------------------------------
  # ○ クラス変数
  #--------------------------------------------------------------------------
  @@passage_cache = []  # 通行フラグテーブルキャッシュ
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize(tilemap)
    @map_rect  = KGC::MiniMap::MAP_RECT
    @grid_size = [KGC::MiniMap::GRID_SIZE, 1].max

    @x = 0
    @y = 0
    @grid_num = Point.new(
      (@map_rect.width  + @grid_size - 1) / @grid_size,
      (@map_rect.height + @grid_size - 1) / @grid_size
    )
    @draw_grid_num    = Point.new(@grid_num.x + 2, @grid_num.y + 2)
    @draw_range_begin = Point.new(0, 0)
    @draw_range_end   = Point.new(0, 0)
    @tilemap = tilemap

    @last_x = $game_player.x
    @last_y = $game_player.y

    create_sprites
    refresh
  end
  #--------------------------------------------------------------------------
  # ○ スプライト作成
  #--------------------------------------------------------------------------
  def create_sprites
    @viewport   = Viewport.new(@map_rect)
    @viewport.z = KGC::MiniMap::MAP_Z

    # ビットマップサイズ計算
    @bmp_size = Size.new(
      (@grid_num.x + 2) * @grid_size,
      (@grid_num.y + 2) * @grid_size
    )
    @buf_bitmap = Bitmap.new(@bmp_size.width, @bmp_size.height)

    # マップ用スプライト作成
    @map_sprite   = Sprite.new(@viewport)
    @map_sprite.x = -@grid_size
    @map_sprite.y = -@grid_size
    @map_sprite.z = 0
    @map_sprite.bitmap = Bitmap.new(@bmp_size.width, @bmp_size.height)

    # オブジェクト用スプライト作成
    @object_sprite   = Sprite_MiniMapIcon.new(@viewport)
    @object_sprite.x = -@grid_size
    @object_sprite.y = -@grid_size
    @object_sprite.z = 1
    @object_sprite.bitmap = Bitmap.new(@bmp_size.width, @bmp_size.height)

    # 現在位置スプライト作成
    @position_sprite   = Sprite_MiniMapIcon.new
    @position_sprite.x = @map_rect.x + @grid_num.x / 2 * @grid_size
    @position_sprite.y = @map_rect.y + @grid_num.y / 2 * @grid_size
    @position_sprite.z = @viewport.z + 2
    bitmap = Bitmap.new(@grid_size, @grid_size)
    bitmap.fill_rect(bitmap.rect, KGC::MiniMap::POSITION_COLOR)
    @position_sprite.bitmap = bitmap
  end
  #--------------------------------------------------------------------------
  # ● 解放
  #--------------------------------------------------------------------------
  def dispose
    @buf_bitmap.dispose
    @map_sprite.bitmap.dispose
    @map_sprite.dispose
    @object_sprite.bitmap.dispose
    @object_sprite.dispose
    @position_sprite.bitmap.dispose
    @position_sprite.dispose
    @viewport.dispose
  end
  #--------------------------------------------------------------------------
  # ○ 可視状態取得
  #--------------------------------------------------------------------------
  def visible
    return @map_sprite.visible
  end
  #--------------------------------------------------------------------------
  # ○ 可視状態設定
  #--------------------------------------------------------------------------
  def visible=(value)
    @viewport.visible        = value
    @map_sprite.visible      = value
    @object_sprite.visible   = value
    @position_sprite.visible = value
  end
  #--------------------------------------------------------------------------
  # ○ リフレッシュ
  #--------------------------------------------------------------------------
  def refresh
    update_draw_range
    update_passage_table
    update_object_list
    update_position
    draw_map
    draw_object
    Graphics.frame_reset
  end
  #--------------------------------------------------------------------------
  # ○ 描画範囲更新
  #--------------------------------------------------------------------------
  def update_draw_range
    range = []
    (2).times { |i| range[i] = @draw_grid_num[i] / 2 }

    @draw_range_begin.x = $game_player.x - range[0]
    @draw_range_begin.y = $game_player.y - range[1]
    @draw_range_end.x   = $game_player.x + range[0]
    @draw_range_end.y   = $game_player.y + range[1]
  end
  #--------------------------------------------------------------------------
  # ○ 通行可否テーブル更新
  #--------------------------------------------------------------------------
  def update_passage_table
    cache = get_passage_table_cache
    @passage_table      = cache.table
    @passage_scan_table = cache.scan_table

    update_around_passage
  end
  #--------------------------------------------------------------------------
  # ○ 通行可否テーブルのキャッシュを取得
  #--------------------------------------------------------------------------
  def get_passage_table_cache
    map_id = $game_map.map_id
    cache  = @@passage_cache.find { |c| c.map_id == map_id }
    if cache == nil
      # キャッシュミス
      cache = PassageCache.new(map_id)
      cache.table      = Table.new($game_map.width, $game_map.height)
      cache.scan_table = Table.new(
        ($game_map.width  + @draw_grid_num.x - 1) / @draw_grid_num.x,
        ($game_map.height + @draw_grid_num.y - 1) / @draw_grid_num.y
      )
    end

    # 直近のキャッシュは先頭、古いキャッシュは削除
    @@passage_cache.unshift(cache)
    @@passage_cache.delete_at(KGC::MiniMap::CACHE_NUM)

    return cache
  end
  #--------------------------------------------------------------------------
  # ○ 通行可否テーブルのキャッシュをクリア
  #--------------------------------------------------------------------------
  def clear_passage_table_cache
    return if @passage_scan_table == nil

    table = @passage_scan_table
    @passage_scan_table = Table.new(table.xsize, table.ysize)
  end
  #--------------------------------------------------------------------------
  # ○ 通行可否テーブルの探索
  #     x, y : 探索位置
  #--------------------------------------------------------------------------
  def scan_passage(x, y)
    dx = x / @draw_grid_num.x
    dy = y / @draw_grid_num.y

    return if @passage_scan_table[dx, dy] == 1
    return unless dx.between?(0, @passage_scan_table.xsize - 1)
    return unless dy.between?(0, @passage_scan_table.ysize - 1)

    rx = (dx * @draw_grid_num.x)...((dx + 1) * @draw_grid_num.x)
    ry = (dy * @draw_grid_num.y)...((dy + 1) * @draw_grid_num.y)
    mw = $game_map.width  - 1
    mh = $game_map.height - 1
    rx.each { |x|
      next unless x.between?(0, mw)
      ry.each { |y|
        next unless y.between?(0, mh)
        @passage_table[x, y] = ($game_map.passable?(x, y) ? 1 : 0)
      }
    }
    @passage_scan_table[dx, dy] = 1
  end
  #--------------------------------------------------------------------------
  # ○ 周辺の通行可否テーブル更新
  #--------------------------------------------------------------------------
  def update_around_passage
    gx = @draw_grid_num.x
    gy = @draw_grid_num.y
    dx = $game_player.x - gx / 2
    dy = $game_player.y - gy / 2
    scan_passage(dx,      dy)
    scan_passage(dx + gx, dy)
    scan_passage(dx,      dy + gy)
    scan_passage(dx + gx, dy + gy)
  end
  #--------------------------------------------------------------------------
  # ○ オブジェクト一覧更新
  #--------------------------------------------------------------------------
  def update_object_list
    events = $game_map.events.values

    # WALL
    @wall_events = events.find_all { |e|
      e.graphic_exist? && e.is_minimap_wall_event?
    }

    # MOVE
    @move_events = events.find_all { |e|
      e.graphic_exist? && e.is_minimap_move_event?
    }

    # OBJ
    @object_list = []
    events.each { |e|
      next unless e.graphic_exist?
      next unless e.is_minimap_object?

      type = e.minimap_object_type
      if @object_list[type] == nil
        @object_list[type] = []
      end
      @object_list[type] << e
    }
  end
  #--------------------------------------------------------------------------
  # ○ 位置更新
  #--------------------------------------------------------------------------
  def update_position
    pt = Point.new($game_player.x, $game_player.y)
    dx = ($game_player.real_x - pt.x * 256) * @grid_size / 256
    dy = ($game_player.real_y - pt.y * 256) * @grid_size / 256
    ox = dx % @grid_size
    oy = dy % @grid_size
    ox = -(@grid_size - ox) if dx < 0
    oy = -(@grid_size - oy) if dy < 0
    @viewport.ox = ox
    @viewport.oy = oy
    if pt.x != @last_x || pt.y != @last_y
      draw_map
      @last_x = pt.x
      @last_y = pt.y
    end
  end
  #--------------------------------------------------------------------------
  # ○ 描画範囲内判定
  #--------------------------------------------------------------------------
  def in_draw_range?(x, y)
    rb = @draw_range_begin
    re = @draw_range_end
    return (x.between?(rb.x, re.x) && y.between?(rb.y, re.y))
  end
  #--------------------------------------------------------------------------
  # ○ マップ範囲内判定
  #--------------------------------------------------------------------------
  def in_map_range?(x, y)
    mw = $game_map.width
    mh = $game_map.height
    return (x.between?(0, mw - 1) && y.between?(0, mh - 1))
  end
  #--------------------------------------------------------------------------
  # ○ マップ描画
  #     dir : 追加位置 (0 で全体)
  #--------------------------------------------------------------------------
  def draw_map(dir = 0)
    bitmap  = @map_sprite.bitmap
    bitmap.fill_rect(bitmap.rect, KGC::MiniMap::BACKGROUND_COLOR)

    rect = Rect.new(0, 0, @grid_size, @grid_size)

    range_x = (@draw_range_begin.x)..(@draw_range_end.x)
    range_y = (@draw_range_begin.y)..(@draw_range_end.y)
    mw = $game_map.width  - 1
    mh = $game_map.height - 1
    update_around_passage

    # 通行可能領域描画
    range_x.each { |x|
      next unless x.between?(0, mw)
      range_y.each { |y|
        next unless y.between?(0, mh)
        next if @passage_table[x, y] == 0
        next if @wall_events.find { |e| e.x == x && e.y == y }  # 壁

        rect.x = (x - @draw_range_begin.x) * @grid_size
        rect.y = (y - @draw_range_begin.y) * @grid_size
        bitmap.fill_rect(rect, KGC::MiniMap::FOREGROUND_COLOR)
      }
    }

    # MOVE
    @move_events.each { |e|
      rect.x = (e.x - @draw_range_begin.x) * @grid_size
      rect.y = (e.y - @draw_range_begin.y) * @grid_size
      bitmap.fill_rect(rect, KGC::MiniMap::MOVE_EVENT_COLOR)
    }
  end
  #--------------------------------------------------------------------------
  # ○ オブジェクト描画
  #--------------------------------------------------------------------------
  def draw_object
    # 下準備
    bitmap = @object_sprite.bitmap
    bitmap.clear
    rect = Rect.new(0, 0, @grid_size, @grid_size)

    # オブジェクト描画
    @object_list.each_with_index { |list, i|
      color = KGC::MiniMap::OBJECT_COLOR[i - 1]
      next if list.nil? || color.nil?

      list.each { |obj|
        next unless in_draw_range?(obj.x, obj.y)

        rect.x = (obj.real_x - @draw_range_begin.x * 256) * @grid_size / 256
        rect.y = (obj.real_y - @draw_range_begin.y * 256) * @grid_size / 256
        bitmap.fill_rect(rect, color)
      }
    }
  end
  #--------------------------------------------------------------------------
  # ○ 更新
  #--------------------------------------------------------------------------
  def update
    return unless @map_sprite.visible

    update_draw_range
    update_position
    draw_object
    @map_sprite.update
    @object_sprite.update
    @position_sprite.update
  end
end

#★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★

#==============================================================================
# □ Sprite_MiniMapIcon
#------------------------------------------------------------------------------
#   ミニマップ用アイコンのクラスです。
#==============================================================================

class Sprite_MiniMapIcon < Sprite
  DURATION_MAX = 60
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #     viewport : ビューポート
  #--------------------------------------------------------------------------
  def initialize(viewport = nil)
    super(viewport)
    @duration = DURATION_MAX / 2
  end
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  def update
    super
    @duration += 1
    if @duration == DURATION_MAX
      @duration = 0
    end
    update_effect
  end
  #--------------------------------------------------------------------------
  # ○ エフェクトの更新
  #--------------------------------------------------------------------------
  def update_effect
    self.color.set(255, 255, 255,
      (@duration - DURATION_MAX / 2).abs * KGC::MiniMap::BLINK_LEVEL
    )
  end
end

#★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★

#==============================================================================
# ■ Spriteset_Map
#==============================================================================

class Spriteset_Map
  attr_reader :minimap
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  alias initialize_KGC_MiniMap initialize
  def initialize
    initialize_KGC_MiniMap

    create_minimap
  end
  #--------------------------------------------------------------------------
  # ○ ミニマップ作成
  #--------------------------------------------------------------------------
  def create_minimap
    return unless $game_map.minimap_show?

    @minimap = Game_MiniMap.new(@tilemap)
    @minimap.visible = $game_system.minimap_show
  end
  #--------------------------------------------------------------------------
  # ● 解放
  #--------------------------------------------------------------------------
  alias dispose_KGC_MiniMap dispose
  def dispose
    dispose_KGC_MiniMap

    dispose_minimap
  end
  #--------------------------------------------------------------------------
  # ○ ミニマップ解放
  #--------------------------------------------------------------------------
  def dispose_minimap
    @minimap.dispose unless @minimap.nil?
  end
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  alias update_KGC_MiniMap update
  def update
    update_KGC_MiniMap

    update_minimap
  end
  #--------------------------------------------------------------------------
  # ○ ミニマップ更新
  #--------------------------------------------------------------------------
  def update_minimap
    return if @minimap.nil?

    if $game_system.minimap_show
      @minimap.visible = true
      @minimap.update
    else
      @minimap.visible = false
    end
  end
  #--------------------------------------------------------------------------
  # ○ ミニマップ全体をリフレッシュ
  #--------------------------------------------------------------------------
  def refresh_minimap
    return if @minimap.nil?

    @minimap.clear_passage_table_cache
    @minimap.refresh
  end
  #--------------------------------------------------------------------------
  # ○ ミニマップのオブジェクトを更新
  #--------------------------------------------------------------------------
  def update_minimap_object
    @minimap.update_object_list unless @minimap.nil?
  end
end

#★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★

#==============================================================================
# ■ Scene_Map
#==============================================================================

class Scene_Map
  #--------------------------------------------------------------------------
  # ○ ミニマップ全体をリフレッシュ
  #--------------------------------------------------------------------------
  def refresh_minimap
    @spriteset.refresh_minimap
  end
  #--------------------------------------------------------------------------
  # ○ ミニマップのオブジェクトを更新
  #--------------------------------------------------------------------------
  def update_minimap_object
    @spriteset.update_minimap_object
  end
end
