class Planet < Base
  attr_accessor :planet_items

  PLANET_TEMPLATE = {
    :id => 0,
    :designName => "",
    :inGameName => "",
    :type => "",
    :pos => { :x => 0, :y => 0 },
    :moveAreaRadius => 40000.000000,
    :hyperspaceExitRadius => 30000.000000,
    :owner => "",
    :isHomePlanet => false,
    :normalStartUpgradeLevelForPopulation => 3,
    :normalStartUpgradeLevelForCivilianModules => 1,
    :normalStartUpgradeLevelForTacticalModules => 0,
    :normalStartUpgradeLevelForArtifacts => 10,
    :normalStartUpgradeLevelForInfrastructure => 2,
    :quickStartUpgradeLevelForPopulation => 4,
    :quickStartUpgradeLevelForCivilianModules => 1,
    :quickStartUpgradeLevelForTacticalModules => 0,
    :quickStartUpgradeLevelForArtifacts => 10,
    :quickStartUpgradeLevelForInfrastructure => 2,
    :spawnProbability => 1.000000,
    :useDefaultTemplate => true,
    :entityCount => 0,
    :asteroidCount => 0
  }

  def initialize(options={})
    super(PLANET_TEMPLATE.merge(options))
    @planet_items = Array.new

    @@id ||= 0
    self.id = @@id
    self.designName = "Planet#{@@id}"
    @@id += 1
  end

  def dump(depth=1)
    puts("#{("\t" * depth)}planet")

    super(depth+1)

    self.planet_items.each do |planet_item|
      planet_item.dump(depth+1)
    end
  end

end
