class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      modifier = set_modifier(item.name, item.sell_in)

      case
      when item.name.include?("Sulfuras")
        next
      when item.name.include?("Backstage passes")
        item.quality = adjust_quality(item.quality, 1, modifier)
        item.quality = 0 if item.sell_in <= 0
      when item.name == "Aged Brie"
        item.quality = adjust_quality(item.quality, 1, modifier)
      else
        item.quality = adjust_quality(item.quality, -1, modifier)
      end
      item.sell_in -= 1
    end
  end

  def adjust_quality(quality, increment, modifier)
    new_quality = quality + increment*modifier
    if new_quality > 50
      return 50
    elsif new_quality < 0
      return 0
    else
      return new_quality
    end
  end

  def set_modifier(name, sell_in)
    modifier = 1
    if name.include?("Backstage passes")
      modifier = 2 if sell_in <= 10
      modifier = 3 if sell_in <= 5
    elsif name.start_with?("Conjured")
      modifier = 2
    end
    modifier *= 2 if sell_in <= 0
    modifier
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
