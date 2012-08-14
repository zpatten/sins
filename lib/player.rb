class Player < Base

  PLAYER_TEMPLATE = {
    :designName => "",
    :inGameName => "",
    :overrideRaceName => "",
    :teamIndex => 1,
    :startingCredits => 30000,
    :startingMetal => 15000,
    :startingCrystal => 15000,
    :isNormalPlayer => true,
    :isRaidingPlayer => false,
    :isInsurgentPlayer => false,
    :isOccupationPlayer => false,
    :themeGroup => "",
    :themeIndex => 0,
    :pictureGroup => "",
    :pictureIndex => 0
  }

  def initialize(options={})
    super(PLAYER_TEMPLATE.merge(options))
    @@id ||= 0
    self.designName = "NewPlayer#{@@id}"
    self.inGameName = "NewPlayer#{@@id}"
    @@id += 1
  end

  def dump(depth=0)
    puts("#{("\t" * depth)}player")

    super(depth+1)
  end

end
