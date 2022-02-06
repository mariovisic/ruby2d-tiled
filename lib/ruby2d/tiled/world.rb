require 'json'

module Ruby2d
  module Tiled
    class World
      attr_reader :levels, :scale, :x_offset, :y_offset

      def initialize(data, levels)
        @data = data
        @levels = levels
        @current_level = 0
        @scale = 1
        @x_offset = 0
        @y_offset = 0
        @angle = 0
      end

      def show
        clear
        @levels[@current_level].scale = @scale
        @levels[@current_level].x_offset = @x_offset
        @levels[@current_level].y_offset = @y_offset
        @levels[@current_level].show
      end

      def clear
        @levels[@current_level].clear
      end

      def next_level
        if @levels.size > @current_level + 1
          clear
          @current_level += 1
          show
        end
      end

      def prev_level
        if @current_level > 0
          clear
          @current_level -= 1
          show
        end
      end

      def scale=(scale)
        @scale = scale
        show
      end

      def x_offset=(x_offset)
        @x_offset = x_offset
        show
      end

      def y_offset=(y_offset)
        @y_offset = y_offset
        show
      end
    end
  end
end