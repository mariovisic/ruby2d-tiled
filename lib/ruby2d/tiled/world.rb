require 'json'

module Ruby2d
  module Tiled
    class World
      attr_reader :levels

      def initialize(levels)
        @levels = levels
      end
    end
  end
end