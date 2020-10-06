require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
    #testing standard items
    it "decreases the sell_in of standard items by 1 each day" do
      items = [Item.new("foo", 5, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 4
    end

    it "decreases the sell_in of standard items by 1 each day" do
      items = [Item.new("foo", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq -1
    end

    it "decreases the quality of standard items by 1 each day while sell_in is > 0" do
      items = [Item.new("foo", 5, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 9
    end

    it "decreases the quality of standard items by 2 each day while sell_in is < 0" do
      items = [Item.new("foo", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 8
    end

    it "the quality of an item is never negative" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    #testing Sulfuras
    it "the quality of Sulfuras is always 80" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 80
    end

    it "the sell_in of Sulfuras is constant" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 10
    end

    #testing Aged Brie
    it "Aged Brie increases in quality with age" do
      items = [Item.new("Aged Brie", 10, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 1
    end

    it "Aged Brie increases in quality twice as fast after sell_in date" do
      items = [Item.new("Aged Brie", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 12
    end

    it "The quality of an item is never more than 50" do
      items = [Item.new("Aged Brie", 0, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    #testing backstage passes
    it "Backstage passes quality increases by 1 when sell_in > 10" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 11
    end

    it "Backstage passes quality increases by 2 when 5 < sell_in <= 10" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 12
    end

    it "Backstage passes quality increases by 3 when 0 <= sell_in <= 5" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 13
    end

    it "Backstage passes quality is 0 once sell_in passes" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    # testing conjured items
    it "Conjured items decrease in quality twice as fast as normal items (testing sell_in >= 0)" do
      items = [Item.new("Conjured Mana Potion", 10, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 8
    end

    it "Conjured items decrease in quality twice as fast as normal items (testing sell_in < 0)" do
      items = [Item.new("Conjured Mana Potion", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 6
    end
  end
end
