class ItemData
  attr_accessor :item
  attr_accessor :value
  attr_accessor :show_icon

  def initialize(item, value, show_icon = true)
    @item = item
    @value = value
    @show_icon = show_icon
  end
end