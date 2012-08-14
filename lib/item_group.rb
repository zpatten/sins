class ItemGroup < Base
  attr_accessor :items

  ITEM_GROUP_TEMPLATE = {
    :condition => { :type => "Always", :param => "" },
    :owner => "",
    :colonizeChance => 0.000000
  }

  def initialize(options={})
    super(ITEM_GROUP_TEMPLATE.merge(options))
    @items = Array.new
  end

  def dump(depth=3)
    puts("#{("\t" * depth)}group")

    super(depth+1)

    puts("#{("\t" * (depth+1))}items #{@items.count}")
    self.items.each do |item|
      item.dump(depth)
    end
  end

end
