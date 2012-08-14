class Base < OpenStruct

  def initialize(*args)
    super(*args)
  end

  def format(key, value, depth=nil)
    if (value == true || value == false)
      value = value.to_s.upcase
    elsif value.is_a?(Float)
      value = "%0.6f" % value
    elsif value.is_a?(Hash)
      if value.key?(:x) && value.key?(:y)
        value = "[ #{value[:x].to_i} , #{value[:y].to_i} ]"
      elsif !depth.nil?
        z = ""
        value.each do |k,v|
          z += "\n#{("\t" * depth)}#{format(k, v, depth+1)}"
        end
        value = z
      end
    elsif value.is_a?(String)
      value = "\"#{value}\""
    end

    "#{key} #{value}"
  end

  def dump(depth=0)
    @table.reject{ |k,v| k == :id }.each do |k,v|
      puts("#{("\t" * (depth))}#{format(k, v, depth+1)}")
    end
  end

  def _pos(x, y)
    { :x => x, :y => y }
  end

  def circumference_point(cx, cy, radius, angle)
    x = (cx + (radius * Math.cos(angle * Math::PI / 180.0)))
    y = (cy + (radius * Math.sin(angle * Math::PI / 180.0)))
    { :x => x, :y => y }
  end

end
