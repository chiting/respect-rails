module Respect
  class RgbaSchema < CompositeSchema
    composed_by do |s|
      s.array do |s|
        s.items do |s|
          s.color_channel # red
          s.color_channel # green
          s.color_channel # blue
          s.color_channel # alpha
        end
      end
    end

    sanitize do |doc|
      Rgba.new(doc[0], doc[1], doc[2], doc[3])
    end
  end
end
