#!/bin/env ruby

require File.join(File.dirname(__FILE__), "galaxy")
require File.join(File.dirname(__FILE__), "star")
require File.join(File.dirname(__FILE__), "planet")

class Sins

  def initialize
  end

  def run
    puts("Sins Galaxy Generator")
    g = Galaxy.new
    puts g.inspect
    o = OpenStruct.new
    o.test = 4
    puts o
  end

end

Sins.run
