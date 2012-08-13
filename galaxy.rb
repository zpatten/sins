require 'ostruct'

class Galaxy
  attr_accessor :attributes

  def initialize
    @attributes = OpenStruct.new
    @attributes.version_number = 4
  end

  def inspect
    @attributes.to_s
  end

end
