require 'json'

module Ruby2d
  module Tiled
    class World
      attr_reader :levels, :scale

      def initialize(data, levels)
        @data = data
        @levels = levels
        @scale = 1
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
    end
  end
end