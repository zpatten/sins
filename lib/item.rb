class Item < Base
  attr_accessor :items

  ITEM_TEMPLATE = {
    :item => "Artifact:IonField"
  }

  def initialize(options={})
    super(ITEM_TEMPLATE.merge(options))
  end

  def dump(depth=4)
    super(depth+1)
  end

end
