class Connection < Base

  CONNECTION_TEMPLATE = {
    :planetIndexA => 0,
    :planetIndexB => 0,
    :spawnProbability => 1.0,
    :type => "PhaseLane"
  }

  def initialize(options={})
    super(CONNECTION_TEMPLATE.merge(options))
  end

  def dump(depth=4)
    puts("#{("\t" * depth)}connection")
    super(depth+1)
  end

end
