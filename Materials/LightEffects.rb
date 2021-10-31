#==============================================================================
# Light Effects VX
#==============================================================================
class Spriteset_Map
  alias les_spriteset_map_initalize initialize
  alias les_spriteset_map_dispose dispose
  alias les_spriteset_map_update update
  def initialize
    @light_effects = []
    setup_lights
    les_spriteset_map_initalize
    update
  end
  def dispose
    les_spriteset_map_dispose
    for effect in @light_effects
      effect.light.dispose
    end
    @light_effects = []
  end
  def update
    les_spriteset_map_update
    update_light_effects
  end
  def setup_lights
    for event in $game_map.events.values
      next if event.list == nil
      for i in 0...event.list.size
        if event.list[i].code == 108 and event.list[i].parameters == ["REFLEX"]
          type = "REFLEX"
          light_effects = Light_Effect.new(event,type)
          light_effects.light.zoom_x = 2
          light_effects.light.zoom_y = 2
          light_effects.light.opacity = 100
          @light_effects.push(light_effects)
        end
        if event.list[i].code == 108 and event.list[i].parameters == ["CANDLE"]
          type = "CANDLE"
          light_effects = Light_Effect.new(event,type)
          light_effects.light.zoom_x = 2
          light_effects.light.zoom_y = 2
          light_effects.light.opacity = 150
          @light_effects.push(light_effects)
        end
        if event.list[i].code == 108 and event.list[i].parameters == ["GROUND"]
          type = "GROUND"
          light_effects = Light_Effect.new(event,type)
          light_effects.light.zoom_x = 2
          light_effects.light.zoom_y = 2
          light_effects.light.opacity = 100
          @light_effects.push(light_effects)
        end
        if event.list[i].code == 108 and event.list[i].parameters == ["FIRE"]
          type = "FIRE"
          light_effects = Light_Effect.new(event,type)
          light_effects.light.zoom_x = 300 / 100.0
          light_effects.light.zoom_y = 300 / 100.0
          light_effects.light.opacity = 100
          @light_effects.push(light_effects)
        end
        if event.list[i].code == 108 and event.list[i].parameters == ["LIGHT"]
          type = "LIGHT"
          light_effects = Light_Effect.new(event,type)
          light_effects.light.zoom_x = 1
          light_effects.light.zoom_y = 1
          light_effects.light.opacity = 150
          @light_effects.push(light_effects)
        end
        if event.list[i].code == 108 and event.list[i].parameters == ["TORCH"]
          type = "TORCH"
          light_effects = Light_Effect.new(event,type)
          light_effects.light.zoom_x = 6
          light_effects.light.zoom_y = 6
          light_effects.light.opacity = 150
          @light_effects.push(light_effects)
        end
      end
    end
    for effect in @light_effects
      case effect.type
      when "REFLEX"
        effect.light.x = (effect.event.real_x - 400 - $game_map.display_x) / 8
        effect.light.y = (effect.event.real_y - 400 - $game_map.display_y) / 8
        effect.light.tone = Tone.new(255,255,255,0)
        effect.light.blend_type = 1
      when "CANDLE"
        effect.light.x = (effect.event.real_x - 400 - $game_map.display_x) / 8
        effect.light.y = (effect.event.real_y - 400 - $game_map.display_y) / 8
        effect.light.blend_type = 1
      when "GROUND"
        effect.light.x = (effect.event.real_x - 400 - $game_map.display_x) / 8
        effect.light.y = (effect.event.real_y - 400 - $game_map.display_y) / 8
        effect.light.blend_type = 1
      when "FIRE"
        effect.light.x = (effect.event.real_x - 600 - $game_map.display_x) / 8 + rand(6) - 3
        effect.light.y = (effect.event.real_y - 600 - $game_map.display_y) / 8 + rand(6) - 3
        effect.light.tone = Tone.new(255,-100,-255,   0)
        effect.light.blend_type = 1
      when "LIGHT"
        effect.light.x = (-0.25 / 2 * $game_map.display_x) + (effect.event.x * 32) - 15
        effect.light.y = (-0.25 / 2 * $game_map.display_y) + (effect.event.y * 32) - 15
        effect.light.blend_type = 1
      when "TORCH"
        effect.light.x = (effect.event.real_x - 1200 - $game_map.display_x) / 8 - 20
        effect.light.y = (effect.event.real_y - 1200 - $game_map.display_y) / 8
        effect.light.tone = Tone.new(255,-100,-255,   0)
        effect.light.blend_type = 1
      end
    end
  end
  def update_light_effects
    if $game_switches[1]
      for effect in @light_effects
        next if effect.type == "FIRE" || effect.type == "TORCH"
        effect.light.visible = false
      end
    else
      for effect in @light_effects
        next if effect.type == "FIRE" || effect.type == "TORCH"
        effect.light.visible = true
      end
    end
    for effect in @light_effects
      case effect.type
      when "REFLEX"
        effect.light.x = (effect.event.real_x - 400 - $game_map.display_x) / 8
        effect.light.y = (effect.event.real_y - 400 - $game_map.display_y) / 8
        effect.light.opacity = 150
      when "CANDLE"
        effect.light.x = (effect.event.real_x - 400 - $game_map.display_x) / 8
        effect.light.y = (effect.event.real_y - 400 - $game_map.display_y) / 8
        effect.light.opacity = rand(30) + 70
      when "GROUND"
        effect.light.x = (effect.event.real_x - 400 - $game_map.display_x) / 8
        effect.light.y = (effect.event.real_y - 400 - $game_map.display_y) / 8
      when "FIRE"
        effect.light.x = (effect.event.real_x - 600 - $game_map.display_x) / 8 + rand(6) - 3
        effect.light.y = (effect.event.real_y - 600 - $game_map.display_y) / 8 + rand(6) - 3
        effect.light.opacity = rand(10) + 90
      when "LIGHT"
        effect.light.x = (-0.25 / 2 * $game_map.display_x) + (effect.event.x * 32) - 15
        effect.light.y = (-0.25 / 2 * $game_map.display_y) + (effect.event.y * 32) - 15
      when "TORCH"
        effect.light.x = (effect.event.real_x - 1200 - $game_map.display_x) / 8 - 20 + rand(20) - 10
        effect.light.y = (effect.event.real_y - 1200 - $game_map.display_y) / 8 + rand(20) - 10
        effect.light.opacity = rand(30) + 70
      end
    end
  end
end
#------------------------------------------------------------------------------
class Light_Effect
  attr_accessor :light
  attr_accessor :event
  attr_accessor :type
  def initialize(event, type)
    @light = Sprite.new
    @light.bitmap = Cache.system("Light.png")
    @light.visible = true
    @light.z = 1000
    @event = event
    @type = type
  end
end