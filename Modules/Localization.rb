#==============================================================================
# Localization script
# Author: Ste
# Version: 2.0
#==============================================================================
class Localization
  attr_accessor :msg_block
  attr_accessor :words
  attr_accessor :message_row
  attr_accessor :row_max_length

  NEW_LINE_CHAR = "§"
  ROW_LENGTH_MAX = $lang == "en" ? 50 : 52
  ROW_FACE_LENGTH_MAX = $lang == "en" ? 40 : 42
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

  COMMON_INDEXES = {
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
    
    "shutdown" => 16,
    
    "to_title" => 18,
    "save" => 19,
    "item" => 20,
    "equipment" => 21,
    
    "obtain" => 26,
    
    "quit" => 34,
    
    "lose" => 39,
    "use_item" => 40,
    
    "find" => 44,
    "gave" => 45,
    "got" => 46,
    
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
    "Castle Grounds" => 2,
    "Lost Valley" => 3,
    "Kings Castle" => 4,
    "Throne Room" => 5,
    "Deserted Lands" => 6,
    "Arena" => 7,
    "Laboratory" => 8,
    "Shelter" => 9,
    "Dead Valley" => 10,
    "Seabed" => 11,
    "The Great Cluster" => 12,
    "Fire Kingdom" => 13,
    "Forbidden Jungle" => 14,
    "Secret Laboratory" => 15,
    "Final Act" => 16,
    "Finalboss" => 17,
    "Abandoned Area" => 18
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
    # "" => 17,
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
    "Energy Sword" => 33
  }

  class ItemText
    attr_accessor :name
    attr_accessor :desc
  end

  def initialize
    @row_max_length = ROW_LENGTH_MAX
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

    text.name = @messages[0]
    text.desc = "#{@messages[1]}§#{@messages[2]}§#{@messages[3]}"

    return text
  end

  def get_map_name(name)
    index = MAPS_INDEXES[name]
    line_data = index != nil ? $map_names_data[index] : name
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
    set_row_max_length(line_data)
    split_data(line_data)
    
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
    set_row_max_length(line_data)
    split_data(line_data)

    if messages_exceed_max?
      p "Messages are over the limit! (#{@messages.size}/#{MESSAGES_MAX})"
    else
      set_msg_vars
    end
  end

  def set_action(action, item, value, item2 = nil, value2 = nil, item_data = nil, code = "")
    reset_msg_vars
    
    text = get_text(action)
    @messages.push(text)

    if (item_data != nil && item_data.note != "" && value > 1)
      item = get_plural(item_data)
    end

    amount = value > 0 ? value.to_s + " " : value < 0 ? "#{get_text("a-lot")} " : ""
    @messages.push("#{code}#{amount}#{item}!")

    if (item2 != nil && value2 != nil)
      amount = value2 > 0 ? value2.to_s + " " : ""
      @messages.push("#{code}#{amount}#{item2}!")
    end

    $msg_params = ["normal", "bottom"]

    set_msg_vars
  end

  #TODO: not used
  def set_act_completed(index)
    reset_msg_vars

    text = "\\delay[3]" # Set letter x letter delay
    text += get_text("act")
    text += "\\.\\."

    case index
    when 1
      text += " #{get_text("the-f")} "
      text += get_map_name("Green Forest")

    when 2
      text += " #{get_text("the-m-pl")} "
      text += get_map_name("Castle Dungeons")

    when 3
      text += " #{get_text("the-f-pl")} "
      text += get_map_name("Rocky Mountains")

    when 4
      text += " #{get_text("the-f")} "
      text += get_map_name("Dead Valley")

    when 5
      text += " #{get_text("the-f-pl")} "
      text += get_map_name("Abyssal Waterfalls")

    when 6
      text += " #{get_text("the-m")} "
      text += get_map_name("Cyberspace")

    when 7
      text += " #{get_text("the-f")} "
      text += get_map_name("Kingdom Outskirts")

    when 8
      text += " #{get_text("the-f-pl")} "
      text += get_map_name("Ancient Ruins")

    when 9
      text += " #{get_text("the-f")} "
      text += get_map_name("Final Battle")

    end

    text += "\\.\\."
    @messages.push(text)

    text = get_text("act-completed")
    text += "\\RED" # Reset letter x letter delay
    @messages.push(text)

    $msg_params = ["transparent", "middle"]

    set_msg_vars
  end

  #TODO: not used
  def set_weapon_stats(index)
    reset_msg_vars

    weapon = $data_weapons[index]
    @messages.push("")

    if Weapons::CAN_UPGRADE.include?(index)
      upgrade_data = weapon.note.split("\n")[0].split("/")

      $game_variables[87] = upgrade_data[0].to_i # Red Globes / Id of the item needed to upgrade the weapon
      if upgrade_data.size > 1
        $game_variables[98] = upgrade_data[1].to_i # Counter value (determines the process speed)
      else
        $game_variables[95] = $data_items[$game_variables[87]].name # Item name needed to upgrade the weapon
      end

      if Weapons::UPGRADE_TO_USE.include?(index)
        @messages.push(get_text("upgrade_to_use"))
      else
        @messages.push(get_text("equip"))
      end

      msg = "\\c[10]#{get_text("upgrade_weap")}\\c[15]"
      @messages.push(msg)
    else
      @messages.push(get_text("equip"))
    end

    @messages.push("#{get_text("cancel")}")

    set_msg_vars
  end

  #TODO: not used
  def set_item_details(item_name, n)
    reset_msg_vars

    msg = "\\lbl#{item_name.upcase}: #{n} #{get_text("possession")}.\\lbl"

    @messages.push(msg)
    @messages.push(get_text("use_item"))
    @messages.push(get_text("cancel"))

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
    # Woratana's :: Weapon Name
    # @msg_block = @msg_block.gsub(/\\NW\[([0-9]+)\]/i) { $data_weapons[$1.to_i].name }
    # Woratana's :: Item Name
    # @msg_block = @msg_block.gsub(/\\NI\[([0-9]+)\]/i) { $data_items[$1.to_i].name}
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

  def set_row_max_length(message)
    @row_max_length = message.include?('\f[') ? ROW_FACE_LENGTH_MAX : ROW_LENGTH_MAX
  end

  def row_length_max_reached?(row)
    row_cleaned = row.gsub(SPECIAL_SYMBOLS) {}
    row_cleaned = row_cleaned.gsub(SPECIAL_CHARS) {"a"}
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