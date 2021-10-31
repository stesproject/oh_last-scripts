#==============================================================================
# Locale Loader script
# Author: Ste
#==============================================================================
module LOCSETT
  PATH = "Data/Locale/"
  LAST_MAP = 117
  SETTINGS_FILENAME = "Settings.rvdata"
  LOADER_ENABLED = true
end

class Locale_Loader
  $maps_data = []
  $common_data = []
  $vocabs_data = []
  $map_names_data = []
  $db_data = []

  def initialize
    if LOCSETT::LOADER_ENABLED
      load_language

      load_maps_data
      load_common_data
      load_vocabs_data
      load_map_names_data
      load_db_data
    end
  end

  def load_maps_data
    for i in 0..LOCSETT::LAST_MAP
      map_data = []
      data_path = "#{LOCSETT::PATH}map#{i}.csv"
      begin
        data = load_data(data_path)
      rescue
        # File does not exist, skip to next map.
      else
        data.split(/\r?\n/).each do |line|
          map_data.push(line)
        end
      end

      $maps_data.push(map_data)
    end
  end

  def load_common_data
    data_path = "#{LOCSETT::PATH}common.csv"

    data = load_data(data_path)
    data.split(/\r?\n/).each do |line|
      $common_data.push(line)
    end
  end

  def load_vocabs_data
    data_path = "#{LOCSETT::PATH}vocabs.csv"

    data = load_data(data_path)
    data.split(/\r?\n/).each do |line|
      $vocabs_data.push(line)
    end
  end

  def load_map_names_data
    data_path = "#{LOCSETT::PATH}maps.csv"

    data = load_data(data_path)
    data.split(/\r?\n/).each do |line|
      $map_names_data.push(line)
    end
  end

  def load_db_data
    data_path = "#{LOCSETT::PATH}db.csv"

    data = load_data(data_path)
    data.split(/\r?\n/).each do |line|
      $db_data.push(line)
    end
  end

  def load_language
    if File.file?(LOCSETT::SETTINGS_FILENAME)
      file = File.open(LOCSETT::SETTINGS_FILENAME, "r")
      $lang = Marshal.load(file)
      file.close
    end
  end

  def save_language
    begin
      file = File.open(LOCSETT::SETTINGS_FILENAME, "w")
      Marshal.dump($lang, file)
    rescue
      # Do nothing, file is still open
    ensure
      file.close
    end
  end

end

class << Marshal
  alias_method(:th_core_load, :load)
  def load(port, proc = nil)
    th_core_load(port, proc)  # usual loading
  rescue TypeError
    if port.kind_of?(File)    # didn't work, so we read it as a raw file
      port.rewind 
      port.read
    else
      port
    end
  end
end unless Marshal.respond_to?(:th_core_load)

$locale = Locale_Loader.new()