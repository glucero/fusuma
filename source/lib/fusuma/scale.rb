module Fusuma

  class Scale

    include Properties

    attr_reader :x, :y, :w, :h

    def initialize(x, y, w, h)
      @x, @y = x, y
      @w, @h = w, h
    end

    def self.from_rect(rect)
      # Conversion of an NSRect to a fusuma Scale
      Scale.new *rect.to_a.map { |coord| coord.to_a }.flatten
    end

    def rescale(value, from_range, to_range)
      # rescale the value to a new min/max range based on the value's current
      # min/max range
      a = value - from_range.min
      b = to_range.max - to_range.min
      c = from_range.max - from_range.min

      a.to_f * b.to_f / c.to_f + to_range.min
    end

    def flip_rect
      @y = (@y > 0) ? @y : (@y * -1) + Workspace.desktops.first.origin.y

      Area(x, y, w, h)
    end

    def scaler(scale)
      # an NSRect for a new layout scaler
      @scale = Scale.from_rect(scale)
    end

    def convert(layout)
      layout = layout.values.map do |a, b|
        [rescale(a, (x..w), (@scale.x..@scale.w)),
         rescale(b, (y..h), (@scale.y..@scale.h))]
      end

      Area(*layout.flatten)
    end

  end
end
