require 'json'

module Ruby2d
  module Tiled
    class World
      attr_reader :levels, :scale, :x_offset, :y_offset

      def initialize(data, levels)
        @data = data
        @levels = levels
        @scale = 1
        @x_offset = 0
        @y_offset = 0
      end

      def show
        @levels.first.show # FIXME: the dev should be able to select the level (rather than just the first)
      end

      def scale=(scale)
        @scale = scale
        @levels.first.clear
        @levels.first.scale = @scale
        @levels.first.show
      end

      def x_offset=(x_offset)
        @x_offset = x_offset
        @levels.first.clear
        @levels.first.x_offset = @x_offset
        @levels.first.show
      end

      def y_offset=(y_offset)
        @y_offset = y_offset
        @levels.first.clear
        @levels.first.y_offset = @y_offset
        @levels.first.show
      end
    end
  end
end