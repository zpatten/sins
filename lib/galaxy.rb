class Galaxy < Base
  attr_accessor :stars
  attr_accessor :players

  GALAXY_TEMPLATE = {
    :versionNumber => 4,
    :isBrowsable => true,
    :browsePictureName => "",
    :browseName => "",
    :browseDescription => "TODO - Add Description Here.",
    :isFirstCapitalShipIsFlagship => true,
    :randomizeStartingPositions => false,
    :planetArtifactDensity => 0.150000,
    :planetBonusDensity => 0.800000,
    "normalStartHomePlanetUpgradeLevel:Population" => 10,
    "normalStartHomePlanetUpgradeLevel:CivilianModules" => 10,
    "normalStartHomePlanetUpgradeLevel:TacticalModules" => 10,
    "normalStartHomePlanetUpgradeLevel:Home" => 1,
    "normalStartHomePlanetUpgradeLevel:ArtifactLevel" => 10,
    "normalStartHomePlanetUpgradeLevel:Infrastructure" => 10,
    "quickStartHomePlanetUpgradeLevel:Population" => 3,
    "quickStartHomePlanetUpgradeLevel:CivilianModules" => 3,
    "quickStartHomePlanetUpgradeLevel:TacticalModules" => 3,
    "quickStartHomePlanetUpgradeLevel:Home" => 1,
    "quickStartHomePlanetUpgradeLevel:ArtifactLevel" => 10,
    "quickStartHomePlanetUpgradeLevel:Infrastructure" => 3,
    :recommendedGameTypeCount => 0,
    :metersPerGalaxyUnit => 25000.000000,
    :pixelsPerGalaxyUnit => 3.560000,
    :useRandomGenerator => false,
    :galaxyWidth => 1920.000000,
    :galaxyHeight => 1114.000000,
    :nextStarNameUniqueId => 0,
    :nextPlanetNameUniqueId => 0,
    :triggerCount => 0
  }

  def initialize(options={})
    super(GALAXY_TEMPLATE.merge(options))
    @stars = Array.new
    @players = Array.new
  end

  def dump
    star_count = @stars.count
    planet_count = @stars.collect{ |s| s.planets.count }.reduce(:+)
    player_count = @players.count

    self.nextStarNameUniqueId = star_count
    self.nextPlanetNameUniqueId = planet_count

    puts("TXT")

    super(0)

    puts("starCount #{star_count}")
    @stars.each do |star|
      star.dump
    end
    puts("interStarConnectionCount 0")

    puts("playerCount #{player_count}")
    @players.each do |player|
      player.dump
    end

    puts "templates 0"
  end

end
