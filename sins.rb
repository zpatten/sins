require 'ostruct'
Dir[File.join(File.dirname(__FILE__), "lib", "*.rb")].sort.each{ |lib| require lib }

class Sins < Base

  SUN_POS = { :x => 200, :y => 200 }
  P1_POS = { :x => 200, :y => 300 }
  P2_POS = { :x => 300, :y => 200 }
  P3_POS = { :x => 100, :y => 200 }
  P4_POS = { :x => 200, :y => 100 }
  P1 = "Player1"
  P2 = "Player2"
  P3 = "Player3"
  P4 = "Player4"

  PLANET_TYPES = %w( DesertHome TerranHome Ice Volcanic )

  def run
    g = Galaxy.new

    g.players << (p1 = Player.new(:startingCredits => 300000, :startingMetal => 150000, :startingCrystal => 150000, :teamIndex => 0))
    g.players << (p2 = Player.new(:startingCredits => 300000, :startingMetal => 150000, :startingCrystal => 150000, :teamIndex => 0))
    g.players << (p3 = Player.new(:startingCredits => 30000, :startingMetal => 15000, :startingCrystal => 15000, :teamIndex => 1))
    g.players << (p4 = Player.new(:startingCredits => 30000, :startingMetal => 15000, :startingCrystal => 15000, :teamIndex => 1))

    g.stars << (s = Star.new(:pos => SUN_POS, :radius => 200.0, :type => "RedStar"))

    s.planets << (p1_home = Planet.new(:pos => P1_POS, :type => "TerranHome", :isHomePlanet => true, :owner => p1.designName))
    s.planets << (p2_home = Planet.new(:pos => P2_POS, :type => "TerranHome", :isHomePlanet => true, :owner => p2.designName))
    s.planets << (p3_home = Planet.new(:pos => P3_POS, :type => "TerranHome", :isHomePlanet => true, :owner => p3.designName))
    s.planets << (p4_home = Planet.new(:pos => P4_POS, :type => "TerranHome", :isHomePlanet => true, :owner => p4.designName))

    slice = 360.div(8)
    p1_sun_link, p2_sun_link, p3_sun_link, p4_sun_link = nil
    pfp, pp, p = nil
    8.times do |z|
      angle = (z * slice)
      s.planets << (p = Planet.new(:pos => circumference_point(SUN_POS[:x], SUN_POS[:y], 25, angle), :type => PLANET_TYPES[z.modulo(PLANET_TYPES.size)]))
      (angle == 45) and p1_sun_link = p
      (angle == 315) and p2_sun_link = p
      (angle == 135) and p3_sun_link = p
      (angle == 225) and p4_sun_link = p

      pfp.nil? and pfp = p
      s.connections << Connection.new(:planetIndexA => -1, :planetIndexB => p.id)
      pp and p and s.connections << Connection.new(:planetIndexA => pp.id, :planetIndexB => p.id)
      pp = p
    end
    s.connections << Connection.new(:planetIndexA => pp.id, :planetIndexB => pfp.id)

    slice = 360.div(12)
    p1_choke_link, p2_choke_link, p3_choke_link, p4_choke_link = nil
    p1fp, p2fp, p3fp, p4fp, p1pp, p2pp, p3pp, p4pp = nil
    12.times do |z|
      s.planets << (p1p = Planet.new(:pos => circumference_point(P1_POS[:x], P1_POS[:y], 50, (z * slice)), :type => PLANET_TYPES[z.modulo(PLANET_TYPES.size)], :useDefaultTemplate => false))
      ((z * slice) == 0) and p1_choke_link = p1p
      s.planets << (p2p = Planet.new(:pos => circumference_point(P2_POS[:x], P2_POS[:y], 50, (z * slice)), :type => PLANET_TYPES[z.modulo(PLANET_TYPES.size)], :useDefaultTemplate => false))
      ((z * slice) == 270) and p2_choke_link = p2p
      s.planets << (p3p = Planet.new(:pos => circumference_point(P3_POS[:x], P3_POS[:y], 50, (z * slice)), :type => PLANET_TYPES[z.modulo(PLANET_TYPES.size)], :useDefaultTemplate => false))
      ((z * slice) == 90) and p3_choke_link = p3p
      s.planets << (p4p = Planet.new(:pos => circumference_point(P4_POS[:x], P4_POS[:y], 50, (z * slice)), :type => PLANET_TYPES[z.modulo(PLANET_TYPES.size)], :useDefaultTemplate => false))
      ((z * slice) == 180) and p4_choke_link = p4p
      s.connections << Connection.new(:planetIndexA => p1_home.id, :planetIndexB => p1p.id)
      s.connections << Connection.new(:planetIndexA => p2_home.id, :planetIndexB => p2p.id)
      s.connections << Connection.new(:planetIndexA => p3_home.id, :planetIndexB => p3p.id)
      s.connections << Connection.new(:planetIndexA => p4_home.id, :planetIndexB => p4p.id)

      p1fp.nil? and p1fp = p1p
      p2fp.nil? and p2fp = p2p
      p3fp.nil? and p3fp = p3p
      p4fp.nil? and p4fp = p4p

      p1pp and p1p and s.connections << Connection.new(:planetIndexA => p1pp.id, :planetIndexB => p1p.id)
      p2pp and p2p and s.connections << Connection.new(:planetIndexA => p2pp.id, :planetIndexB => p2p.id)
      p3pp and p3p and s.connections << Connection.new(:planetIndexA => p3pp.id, :planetIndexB => p3p.id)
      p4pp and p4p and s.connections << Connection.new(:planetIndexA => p4pp.id, :planetIndexB => p4p.id)

      p1pp, p2pp, p3pp, p4pp = p1p, p2p, p3p, p4p
    end
    s.connections << Connection.new(:planetIndexA => p1pp.id, :planetIndexB => p1fp.id)
    s.connections << Connection.new(:planetIndexA => p2pp.id, :planetIndexB => p2fp.id)
    s.connections << Connection.new(:planetIndexA => p3pp.id, :planetIndexB => p3fp.id)
    s.connections << Connection.new(:planetIndexA => p4pp.id, :planetIndexB => p4fp.id)

    s.planets << (p1_choke1 = Planet.new(:pos => _pos(P1_POS[:x]+100, P1_POS[:y]), :type => "DesertHome", :useDefaultTemplate => false))
    s.planets << (p1_choke2 = Planet.new(:pos => circumference_point(P1_POS[:x]+100, P1_POS[:y], 30, 225), :type => "DesertHome", :useDefaultTemplate => false))
    s.planets << (p1_choke3 = Planet.new(:pos => circumference_point(p1_choke2.pos[:x], p1_choke2.pos[:y], 30, 225), :type => "DesertHome", :useDefaultTemplate => false))
    s.planets << (p1_choke4 = Planet.new(:pos => circumference_point(p1_choke3.pos[:x], p1_choke3.pos[:y], 30, 225), :type => "DesertHome", :useDefaultTemplate => false))
    s.connections << Connection.new(:planetIndexA => p1_choke_link.id, :planetIndexB => p1_choke1.id)
    s.connections << Connection.new(:planetIndexA => p1_choke1.id, :planetIndexB => p1_choke2.id)
    s.connections << Connection.new(:planetIndexA => p1_choke2.id, :planetIndexB => p1_choke3.id)
    s.connections << Connection.new(:planetIndexA => p1_choke3.id, :planetIndexB => p1_choke4.id)
    s.connections << Connection.new(:planetIndexA => p1_choke4.id, :planetIndexB => p1_sun_link.id)

    s.planets << (p2_choke1 = Planet.new(:pos => _pos(P2_POS[:x], P2_POS[:y]-100), :type => "DesertHome", :useDefaultTemplate => false))
    s.planets << (p2_choke2 = Planet.new(:pos => circumference_point(P2_POS[:x], P2_POS[:y]-100, 30, 135), :type => "DesertHome", :useDefaultTemplate => false))
    s.planets << (p2_choke3 = Planet.new(:pos => circumference_point(p2_choke2.pos[:x], p2_choke2.pos[:y], 30, 135), :type => "DesertHome", :useDefaultTemplate => false))
    s.planets << (p2_choke4 = Planet.new(:pos => circumference_point(p2_choke3.pos[:x], p2_choke3.pos[:y], 30, 135), :type => "DesertHome", :useDefaultTemplate => false))
    s.connections << Connection.new(:planetIndexA => p2_choke_link.id, :planetIndexB => p2_choke1.id)
    s.connections << Connection.new(:planetIndexA => p2_choke1.id, :planetIndexB => p2_choke2.id)
    s.connections << Connection.new(:planetIndexA => p2_choke2.id, :planetIndexB => p2_choke3.id)
    s.connections << Connection.new(:planetIndexA => p2_choke3.id, :planetIndexB => p2_choke4.id)
    s.connections << Connection.new(:planetIndexA => p2_choke4.id, :planetIndexB => p2_sun_link.id)

    s.planets << (p3_choke1 = Planet.new(:pos => _pos(P3_POS[:x], P3_POS[:y]+100), :type => "DesertHome", :useDefaultTemplate => false))
    s.planets << (p3_choke2 = Planet.new(:pos => circumference_point(P3_POS[:x], P3_POS[:y]+100, 30, 315), :type => "DesertHome", :useDefaultTemplate => false))
    s.planets << (p3_choke3 = Planet.new(:pos => circumference_point(p3_choke2.pos[:x], p3_choke2.pos[:y], 30, 315), :type => "DesertHome", :useDefaultTemplate => false))
    s.planets << (p3_choke4 = Planet.new(:pos => circumference_point(p3_choke3.pos[:x], p3_choke3.pos[:y], 30, 315), :type => "DesertHome", :useDefaultTemplate => false))
    s.connections << Connection.new(:planetIndexA => p3_choke_link.id, :planetIndexB => p3_choke1.id)
    s.connections << Connection.new(:planetIndexA => p3_choke1.id, :planetIndexB => p3_choke2.id)
    s.connections << Connection.new(:planetIndexA => p3_choke2.id, :planetIndexB => p3_choke3.id)
    s.connections << Connection.new(:planetIndexA => p3_choke3.id, :planetIndexB => p3_choke4.id)
    s.connections << Connection.new(:planetIndexA => p3_choke4.id, :planetIndexB => p3_sun_link.id)

    s.planets << (p4_choke1 = Planet.new(:pos => _pos(P4_POS[:x]-100, P4_POS[:y]), :type => "DesertHome", :useDefaultTemplate => false))
    s.planets << (p4_choke2 = Planet.new(:pos => circumference_point(P4_POS[:x]-100, P4_POS[:y], 30, 45), :type => "DesertHome", :useDefaultTemplate => false))
    s.planets << (p4_choke3 = Planet.new(:pos => circumference_point(p4_choke2.pos[:x], p4_choke2.pos[:y], 30, 45), :type => "DesertHome", :useDefaultTemplate => false))
    s.planets << (p4_choke4 = Planet.new(:pos => circumference_point(p4_choke3.pos[:x], p4_choke3.pos[:y], 30, 45), :type => "DesertHome", :useDefaultTemplate => false))
    s.connections << Connection.new(:planetIndexA => p4_choke_link.id, :planetIndexB => p4_choke1.id)
    s.connections << Connection.new(:planetIndexA => p4_choke1.id, :planetIndexB => p4_choke2.id)
    s.connections << Connection.new(:planetIndexA => p4_choke2.id, :planetIndexB => p4_choke3.id)
    s.connections << Connection.new(:planetIndexA => p4_choke3.id, :planetIndexB => p4_choke4.id)
    s.connections << Connection.new(:planetIndexA => p4_choke4.id, :planetIndexB => p4_sun_link.id)

    [p1_choke1, p1_choke2, p1_choke3, p1_choke4].each do |planet|
      planet.planet_items << (pi = PlanetItem.new)
      pi.item_groups << (ig = ItemGroup.new(:owner => p1.designName))
      ig.items << Item.new(:item => "Phase:StarBase")
    end

    [p2_choke1, p2_choke2, p2_choke3, p2_choke4].each do |planet|
      planet.planet_items << (pi = PlanetItem.new)
      pi.item_groups << (ig = ItemGroup.new(:owner => p2.designName))
      ig.items << Item.new(:item => "Phase:StarBase")
    end

=begin
    g.stars << (s = Star.new)
    s.planets << (p = Planet.new)
    p.planet_items << (pi = PlanetItem.new)
    pi.item_groups << (ig = ItemGroup.new)
    ig.items << (i = Item.new)
=end
    g.dump
  end

end

s = Sins.new
s.run
