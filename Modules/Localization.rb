#==============================================================================
# Localization script
# Author: Ste
# Version: 2.0
#==============================================================================
class Localization
  attr_accessor :msg_block
  attr_accessor :words
  attr_accessor :message_row

  NEW_LINE_CHAR = "§"
  ROW_LENGTH_MAX = $lang == "en" ? 50 : 52
  MESSAGES_MAX = 4
  SPECIAL_SYMBOLS = /\\nb\[(.*?)\]|\\\||\\\.|\\\^|\\g|\\c\[([0-9]+)\]|#{NEW_LINE_CHAR}/i
  SPECIAL_CHARS = /([àèìòùéÈ])+/

  $default_language = ""
  $msg_var = [561,562,563,564]
  $param_var = 49
  @messages = nil

  LANG = ["en", "it"]
  LANGUAGES = {
    "en" => "English",
    "it" => "Italiano"
  }

  COMMON_INDEXES = {
    "cant_control" => 1,
    "no_item" => 2,
    "tay_can_control" => 3,
    "swordcase" => 4,
    "already_equipped" => 5,
    "to_upgrade" => 6,
    "press_to_upgrade" => 7,
    "not_enough_globes" => 8,
    "door_closed" => 9,
    "not_now" => 10,
    "an_obelisk" => 11,
    "obelisk1" => 12,
    "obelisk2" => 13,
    "obelisk3" => 14,
    "obelisk4" => 15,
    "obelisk5" => 16,
    "not_enough_eggs" => 17,
    "to_upgrade_w_item" => 18,
    "not_1_item" => 19,
    "not_enough_d" => 20,
    "cant_upgrade_armor" => 21,
    "def_up" => 22
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
    "new_game" => 14,
    "continue" => 15,
    "shutdown" => 16,
    "game_end" => 17,
    "to_title" => 18,
    "save" => 19,
    "item" => 20,
    "equipment" => 21,
    "level" => 22,
    "remove" => 23,
    "upgrade_weap" => 24,
    "proceed" => 25,
    "obtain" => 26,
    "stats" => 27,
    "skins" => 28,
    "trophy-hall" => 29,
    "equip" => 30,
    "attack" => 31,
    "locked" => 32,
    "cheat_price" => 33,
    "quit" => 34,
    "unlock" => 35,
    "can_use" => 36,
    "website" => 37,
    "menu_language" => 38,
    "lose" => 39,
    "use_item" => 40,
    "a-lot" => 41,
    "using" => 42,
    "view" => 43,
    "find" => 44,
    "gave" => 45,
    "got" => 46,
    "act" => 47,
    "act-completed" => 48,
    "the-m" => 49,
    "the-f" => 50,
    "the-m-pl" => 51,
    "the-f-pl" => 52,
    "ourhero" => 53,
    "tay" => 54,
    "fury" => 55,
    "king" => 56,
    "sage" => 57,
    "general" => 58,
    "enable" => 59,
    "disable" => 60,
    "fiery" => 61,
    "icy" => 62,
    "electric" => 63,
    "upgrade_to_use" => 64,
    "defence" => 65,
    "upgrade_armor" => 66
  }

  MAPS_INDEXES = {
    "Green Forest" => 1,
    "Castle Grounds" => 2,
    "Castle Dungeons" => 3,
    "Kings Castle" => 4,
    "Throne Room" => 5,
    "Teorhemas Vault" => 6,
    "Arena" => 7,
    "Wild Valley" => 8,
    "Rocky Mountains" => 9,
    "Dead Valley" => 10,
    "Abyssal Waterfalls" => 11,
    "Forest of the All-Eye Monster" => 12,
    "Cyberspace" => 13,
    "Kingdom Outskirts" => 14,
    "Race" => 15,
    "Ancient Ruins" => 16,
    "Final Battle" => 17,
    "Water City" => 18,
    "Sky" => 19,
  }

  DB_INDEXES = {
    "Meat" => 1,
    "Egg" => 2,
    "Health Potion" => 3,
    "Red Globes" => 4,
    "Pebbles" => 5,
    "Ingots" => 6,
    "King's Key" => 7,
    "Silver Key" => 8,
    "Controller Crystal" => 9,
    "Obelisk Key" => 10,
    "Regenerator" => 11,
    "Controls" => 12,
    "Spada Dorata" => 13,
    "Spada Antica" => 14,
    "Spada di Pietra" => 15,
    "Spada del Soldato" => 16,
    "AmmazzaZombie" => 17,
    "Spada della Rivolta" => 18,
    "Spada della Rivolta 2" => 19,
    "Gladiator" => 20,
    "Gladius" => 21,
    "Gladius Perfezionato" => 22,
    "Spada di Fuoco" => 23,
    "Spada di Carbone" => 24,
    "Spada Lucente" => 25,
    "Spada di Platino" => 26,
    "Spada della Rivolta Finale" => 27,
    "Spada Spirituale" => 28,
    "Gelizedor" => 29,
    "Spada Cannone" => 30,
    "Spada di Ghiaccio" => 31,
    "Spada Infernale" => 32,
    "Spada d'Argento" => 33,
    "Elettrogen" => 34,
    "Spada del Drago" => 35,
    "Ultimate Sword" => 36,
    "King's Crown" => 37,
    "Perla Fuoco" => 38,
    "Perla Ghiaccio" => 39,
    "Perla Luce" => 40,
    "Armor Powerup" => 41,
    "Power Glove" => 42,
    "cheat_1" => 43,
    "cheat_2" => 44,
    "cheat_3" => 45,
    "cheat_4" => 46,
    "cheat_5" => 47,
    "cheat_6" => 48,
    "Armor" => 49,
    "Munizioni" => 50,
    "currency" => 51,
    "Fodera" => 52,
    "Ultimate Armor" => 53
  }

  class ItemText
    attr_accessor :name
    attr_accessor :desc
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
    @msg_block = @msg_block.gsub(/\\NW\[([0-9]+)\]/i) { $data_weapons[$1.to_i].name }
    # Woratana's :: Item Name
    @msg_block = @msg_block.gsub(/\\NI\[([0-9]+)\]/i) { $data_items[$1.to_i].name}
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

  def row_length_max_reached?(row)
    row_cleaned = row.gsub(SPECIAL_SYMBOLS) {}
    row_cleaned = row_cleaned.gsub(SPECIAL_CHARS) {"a"}
    return row_cleaned.size >= ROW_LENGTH_MAX
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