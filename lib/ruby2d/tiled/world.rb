require 'json'

module Ruby2d
  module Tiled
    class World
      attr_reader :levels

      def initialize(data, levels)
        @data = data
        @levels = levels
      end

      def show
        @levels.first.show
      end
    end
  end
end