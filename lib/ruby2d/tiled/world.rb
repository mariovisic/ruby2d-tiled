require 'json'

module Ruby2d
  module Tiled
    class World
      attr_reader :levels

      def initialize(data, levels)
        @data = data.slice('bgColor')
        @levels = levels
      end

      def bg_color
        @data['bgColor']
      end

      def show
        Window.set background: bg_color
      end
    end
  end
end