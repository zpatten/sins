class PlanetItem < Base
  attr_accessor :item_groups

  PLANET_ITEM_TEMPLATE = {
    :templateName => "",
    :subTemplates => 0
  }

  def initialize(options={})
    super(PLANET_ITEM_TEMPLATE.merge(options))
    @item_groups = Array.new
  end

  def dump(depth=2)
    group_count = @item_groups.count

    puts("#{("\t" * depth)}planetItems")

    super(depth+1)

    puts("#{("\t" * (depth+1))}groups #{group_count}")
    self.item_groups.each do |item_group|
      item_group.dump(depth+1)
    end
  end

end
