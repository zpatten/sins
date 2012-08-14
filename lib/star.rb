class Star < Base
  attr_accessor :planets
  attr_accessor :connections

  STAR_TEMPLATE = {
    :designName => "",
    :inGameName => "",
    :type => "",
    :pos => { :x => 0, :y => 0 },
    :radius => 150.000000,
    :moveAreaRadius => 60000.000000,
    :hyperspaceExitRadius => 40000.000000
  }

  def initialize(options={})
    super(STAR_TEMPLATE.merge(options))
    @planets = Array.new
    @connections = Array.new

    @@id ||= 0
    self.designName = "Star#{@@id}"
    @@id += 1
  end

  def dump(depth=0)
    planet_count = @planets.count
    connection_count = @connections.count

    puts("#{("\t" * depth)}star")

    super(depth+1)

    puts("#{("\t" * (depth+1))}planetCount #{planet_count}")
    @planets.each do |planet|
      planet.dump(depth+1)
    end

    puts("#{("\t" * (depth+1))}connectionCount #{connection_count}")
    @connections.each do |connection|
      connection.dump(depth+1)
    end
  end

end
