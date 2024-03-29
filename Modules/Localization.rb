#==============================================================================
# Localization script
# Author: Ste
# Version: 2.2
# Date: 01-07-2022
# Change Log:
#     - Can change globally row max length
#     - Add possibility to change row max length
#     - Improved set_action method, now it takes an array of items.
#==============================================================================
class Localization
  attr_accessor :msg_block
  attr_accessor :words
  attr_accessor :message_row
  attr_accessor :row_max_length

  NEW_LINE_CHAR = "§"
  MESSAGES_MAX = 4
  SPECIAL_SYMBOLS = /\\nb\[(.*?)\]|\\\||\\\.|\\\^|\\g|\\c\[([0-9]+)\]|#{NEW_LINE_CHAR}/i
  SPECIAL_CHARS = /([àèìòùéÈ])+/

  $default_language = ""
  $msg_var = [161,162,163,164]
  $param_var = 165
  @messages = nil

  LANG = ["en", "it"]
  LANGUAGES = {
    "en" => "English",
    "it" => "Italiano"
  }
  ROW_MAX_LENGTH = {
    "en" => 50,
    "it" => 52,
  }
  FACE_ROW_LENGTH_OFFSET = 10

  COMMON_INDEXES = {
    "help1" => 1,
    "help2" => 2,
    "help3" => 3,
    "help4" => 4,
    "help5" => 5,
    "help6" => 6,
    "help7" => 7,
    "help8" => 8,
    "help9" => 9,
    "help10" => 10,
    "help11" => 11,
    "help12" => 12,
    "help13" => 13,
    "help14" => 14,
    "help15" => 15,
    "help16" => 16,
    "help17" => 17,
    "help18" => 18,
    "help19" => 19,
    "to_shelter" => 20,
    "to_shelter_ok" => 21,
    "to_shelter_ko" => 22,
    "unlock_mission" => 23,
    "not_enough" => 24,
    "mission1_a" => 25,
    "mission1_b" => 26,
    "mission1_c" => 27,
    "mission2_a" => 28,
    "mission2_b" => 29,
    "mission2_c" => 30,
    "mission3_a" => 31,
    "mission3_b" => 32,
    "mission3_c" => 33,
    "mission4_a" => 34,
    "mission4_b" => 35,
    "mission4_c" => 36,
    "mission5_a" => 37,
    "mission5_b" => 38,
    "mission5_c" => 39,
    "mission6_a" => 40,
    "mission6_b" => 41,
    "mission6_c" => 42,
    "mission7_a" => 43,
    "mission7_b" => 44,
    "mission7_c" => 45,
    "mission8_a" => 46,
    "mission8_b" => 47,
    "mission8_c" => 48,
    "underwater" => 49,
    "unlock_cards" => 50,
    "unlock_card" => 51,
    "locked_chest" => 52,
    "dispenser_out" => 53,
    "torrette_ok" => 54,
    "game100" => 55,
    "cannot_save" => 56,
    "locked_door" => 57,
    "buy-cancel" => 58,
    "mission1" => 59,
    "mission2" => 60,
    "mission3" => 61,
    "mission4" => 62,
    "mission5" => 63,
    "mission6" => 64,
    "mission7" => 65,
    "mission8" => 66,
    "mission9" => 67,
    "mission10" => 68,
    "mission11" => 69,
    "mission12" => 70,
    "e_mission_ok" => 71,
    "e_mission_ko" => 72,
  }

  VOCABS_INDEXES = {
    "cannot_save" => 1,
    "empty" => 2,
    "playtime" => 3,
    "location" => 4,
    "currency" => 5,
    "ask_overwrite" => 6,
    "cancel" => 7,
    "save_message" => 8,
    "load_message" => 9,
    "possession" => 10,
    "shop_buy" => 11,
    "shop_sell" => 12,
    "shop_cancel" => 13,
    "accept" => 14,
    "refuse" => 15,
    "shutdown" => 16,
    "wave" => 17,
    "to_title" => 18,
    "save" => 19,
    "item" => 20,
    "equipment" => 21,
    "attack" => 22,
    "shop_m" => 23,
    "shop_f" => 24,
    "teleport_to" => 25,
    "obtain" => 26,
    "stat_1" => 27,
    "stat_2" => 28,
    "stat_3" => 29,
    "stat_4" => 30,
    "stat_5" => 31,
    "stat_6" => 32,
    "dispenser_of" => 33,
    "quit" => 34,
    "hold_to_upgrade" => 35,
    "shop_owned" => 36,
    "fullscreen" => 37,
    "windowed" => 38,
    "lose" => 39,
    "yes" => 40,
    "no" => 41,
    "item-assigned" => 42,
    "skill-assigned" => 43,
    "find" => 44,
    "gave" => 45,
    "got" => 46,
    "act" => 47,
    "finalboss" => 48,
    "the-m" => 49,
    "the-f" => 50,
    "the-m-pl" => 51,
    "the-f-pl" => 52,
    "ourhero" => 53,
    "tay" => 54,
    "fury" => 55,
    "king" => 56,
    "sage" => 57,
    "grin" => 58,
    "enable" => 59,
    "disable" => 60
  }

  MAPS_INDEXES = {
    "Royal Gardens" => 1,
    "Lost Valley" => 2,
    "Deserted Lands" => 3,
    "Abandoned Area" => 4,
    "Seabed" => 5,
    "Forbidden Jungle" => 6,
    "Fire Kingdom" => 7,
    "Secret Laboratory" => 8,
    "Final Act" => 9,
    "Dead Valley" => 10,
    "Shelter" => 11,
    "The Great Cluster" => 12,
    "Castle Grounds" => 13,
    "Kings Castle" => 14,
    "Throne Room" => 15,
    "Arena" => 16,
    "Finalboss" => 17,
    "Laboratory" => 18,
  }

  DB_INDEXES = {
    "Meat" => 1,
    "Diamond" => 2,
    "Chest Key" => 3,
    "Laboratory Key" => 4,
    "Invulnerability" => 5,
    "Destroyer" => 6,
    "Potion" => 7,
    "Rifle Burst" => 8,
    "Fury's Armor" => 9,
    "Medallion" => 10,
    "Laser Rifle" => 11,
    "Sea Key" => 12,
    "Accelerator Vial" => 13,
    "Water Barrier" => 14,
    "Plasma Rifle" => 15,
    "Dragon Egg" => 16,
    "Card" => 17,
    "Skill: Barrier" => 18,
    "Skill: Frost" => 19,
    "Skill: Rage" => 20,
    "Sages Water" => 21,
    # "" => 22,
    "Iron Suit Burst" => 23,
    "Rampage PlasmaGen" => 24,
    "Rifle Burst" => 25,
    "Saver" => 26,
    "King's Sword" => 27,
    "Mechanical Sword" => 28,
    "Iron Suit Cannon" => 29,
    "Futuristic Hyper Sword" => 30,
    "Scabbard" => 31,
    "Cyborg Sword" => 32,
    "Energy Sword" => 33,
    "Sword TC" => 34,
    "Rifle TC" => 35,
    "ESP" => 36,
    "Dindini" => 37,
  }

  class ItemText
    attr_accessor :name
    attr_accessor :desc
  end

  def initialize
    @row_max_length = ROW_MAX_LENGTH[$lang]
  end

  def switch_language(value = 1)
    new_lang_index = LANG.index($lang) + value
    if new_lang_index < 0
      $lang = LANG.last
    elsif new_lang_index == LANG.size
      $lang = LANG.first
    else
      $lang = LANG[new_lang_index]
    end

    $locale.save_language
  end

  def reset_msg_vars
    @messages = []

    for i in 0..3
      $game_variables[$msg_var[i]] = ""
    end
  end

  def set_msg_vars
    if (@messages == nil)
      return
    end

    for i in 0..@messages.size - 1
      @messages[i] = @messages[i] == nil ? "" : @messages[i]
      $game_variables[$msg_var[i]] = @messages[i]
    end
  end

  def get_msg_vars
    return [
      $game_variables[$msg_var[0]],
      $game_variables[$msg_var[1]],
      $game_variables[$msg_var[2]],
      $game_variables[$msg_var[3]],
    ]
  end

  def get_db_object(name)
    text = ItemText.new()

    index = DB_INDEXES[name]
    line_data = index != nil ? $db_data[index] : name
    reset_msg_vars
    split_data(line_data)

    text.name = @messages.size > 0 ? @messages[0] : line_data
    text.desc = @messages.size > 1 ? @messages[1] : ""

    return text
  end

  def get_map_name(name)
    index = MAPS_INDEXES[name]
    line_data = index != nil ? $map_names_data[index] : name
    split_data(line_data, false)

    return @msg_block
  end

  def get_map_name_by_index(index)
    line_data = index != nil ? $map_names_data[index + 1] : name
    split_data(line_data, false)

    return @msg_block
  end

  def get_text(name)
    index = VOCABS_INDEXES[name]
    line_data = index != nil ? $vocabs_data[index] : name
    split_data(line_data, false)

    return @msg_block
  end

  def get_plural(item_data)
    plurals = []
    item_data.note.split(/\r?\n/).each do |text|
      plurals.push(text)
    end

    return plurals[LANG.index($lang)]
  end

  def set_msg(map_id, index)
    reset_msg_vars
    
    map_id = map_id == nil ? $game_map.map_id : map_id
    line_data = $maps_data[map_id][index]
    set_row_max_length(line_data.include?('\f[') ? -FACE_ROW_LENGTH_OFFSET : 0)
    split_data(line_data)
    set_row_max_length(line_data.include?('\f[') ? FACE_ROW_LENGTH_OFFSET : 0)
    
    if messages_exceed_max?
      p "Messages are over the limit! (#{@messages.size}/#{MESSAGES_MAX})"
    else
      set_msg_vars
    end
  end

  def set_common_msg(name)
    reset_msg_vars

    index = COMMON_INDEXES[name]
    line_data = $common_data[index]
    set_row_max_length(line_data.include?('\f[') ? -FACE_ROW_LENGTH_OFFSET : 0)
    split_data(line_data)
    set_row_max_length(line_data.include?('\f[') ? FACE_ROW_LENGTH_OFFSET : 0)

    if messages_exceed_max?
      p "Messages are over the limit! (#{@messages.size}/#{MESSAGES_MAX})"
    else
      set_msg_vars
    end
  end

  def set_action(action, items, code = "")
    reset_msg_vars
    
    text = get_text(action)
    @messages.push(text)

    for item_data in items
      item = item_data.item
      value = item_data.value
      show_icon = item_data.show_icon

      name = item.name
      if (item.note != "" && value > 1)
        name = get_plural(item)
      end

      icon = ""
      if show_icon
        icon = "\\i[#{item.icon_index}] "
      end

      amount = value > 0 ? value.to_s + " " : value < 0 ? "#{get_text("a-lot")} " : ""

      @messages.push("#{icon}#{code}#{amount}#{name}!")
    end

    $msg_params = ["normal", "bottom"]
    set_msg_vars
  end

  def set_rewards(items)
    reset_msg_vars
    
    for item_data in items
      item = item_data.item
      value = item_data.value
      show_icon = true

      name = item.name
      if (item.note != "" && value > 1)
        name = get_plural(item)
      end

      icon = ""
      if show_icon
        icon = "\\i[#{item.icon_index}]"
      end

      amount = value > 0 ? value.to_s + " " : ""

      @messages.push("\\>                              +#{amount} #{name} #{icon}")
    end

    @messages.push("\\g")
    $msg_params = ["transparent", "middle"]
    set_msg_vars
  end

  def set_teleport_to(index)
    reset_msg_vars

    text = get_text("teleport_to")
    @messages.push(text)

    text = get_text("act")
    @messages.push("\\>\\c[1]#{text} #{index}:\\c[0] #{get_map_name_by_index(index - 1)}?")

    text = get_text("yes")
    @messages.push(text)

    text = get_text("no")
    @messages.push(text)

    set_msg_vars
  end

  def set_weapon_stats(index)
    reset_msg_vars

    weapon = $data_weapons[index]
    name = weapon.name
    atk = weapon.atk.to_s
    attack_text = get_text("attack")

    @messages.push("\\>            #{name} | #{attack_text}: \\c[3]#{atk}\\c[0].")

    $msg_params = ["transparent", "bottom"]
    set_msg_vars
  end

  def set_shop_stats(index, var_id, genre)
    reset_msg_vars

    colors = {
      "1" => "2",
      "5" => "12",
      "6" => "10",
      "7" => "28",
      "27" => "0",
    }

    item = $data_items[index]
    name = item.name
    name_plural = get_plural(item) ? get_plural(item) : name
    $game_variables[165] = name_plural
    possession_text = get_text("possession")
    shop_text = get_text("shop_#{genre}")
    dispenser_of_text = get_text("dispenser_of")
    value = $game_variables[var_id]
    color = "\\c[#{colors[index.to_s]}]"

    @messages.push("\\>\\fi#{color}#{dispenser_of_text}")
    @messages.push("\\>\\G\\c[18]#{name_plural}:\\c[0] #{value} #{possession_text}\\fb")
    @messages.push(shop_text)

    $msg_params = ["transparent", "middle"]
    set_msg_vars
  end

  def split_data(data, split_in_rows = true)
    cells = []
    reset_row

    if (data == nil)
      return []
    end

    data.split(";").each do |cell|
      cells.push(cell)
    end

    lang_id = LANG.index($lang)
    @msg_block = cells[lang_id]

    if @msg_block != nil && split_in_rows == true
      convert_special_characters
      split_msg_block_in_rows
    end
  end

  def convert_special_characters
    # Character Name
    @msg_block = @msg_block.gsub(/\\N\[([0-9]+)\]/i) { get_text($game_actors[$1.to_i].name) }
    # Ste's :: Map Name
    @msg_block = @msg_block.gsub(/\\MAP\[(.*?)\]/i) { get_map_name($1) }
  end
  
  def split_msg_block_in_rows
    @words = @msg_block.split(" ")

    @words.each do |word|
      row = @message_row + word
      if !row_length_max_reached?(row)
        add_word_to_row(word)
      end

      if row_length_max_reached?(row) || is_last_word?(word)
        @message_row = remove_n_chars_from(@message_row, 1)
        add_row_to_messages
        reset_row
        add_word_to_row(word)
      end

      if row_length_max_reached?(row) && is_last_word?(word)
        @message_row = remove_n_chars_from(@message_row, 1)
        add_row_to_messages
        reset_row
      end
      
      if word.include? NEW_LINE_CHAR
        @message_row = remove_n_chars_from(@message_row, 3)
        add_row_to_messages
        reset_row
      end

    end
  end

  def set_row_max_length(row_max_length = 0)
    new_length = @row_max_length + row_max_length
    @row_max_length = new_length
  end

  def row_length_max_reached?(row)
    row_cleaned = row.gsub(SPECIAL_SYMBOLS) {}
    row_cleaned = row_cleaned.gsub(SPECIAL_CHARS) {"a"}
    if @row_max_length == nil
      initialize
    end
    return row_cleaned.size >= @row_max_length
  end

  def add_word_to_row(word)
    @message_row += "#{word} "
  end

  def is_last_word?(word)
    return @words.last == word
  end

  def remove_n_chars_from(item, n = 1)
    size = item.size
    return item[0..size-(n+1)]
  end

  def add_row_to_messages
    @messages.push(@message_row)
  end

  def reset_row
    @message_row = ""
  end

  def messages_exceed_max?
    return @messages.size > MESSAGES_MAX
  end

end

$local = Localization.new()