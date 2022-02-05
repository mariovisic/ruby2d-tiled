require 'json'

module Ruby2d
  module Tiled
    class LDTK
      def self.load(ldtk_json_string)
        json = JSON.parse(ldtk_json_string)

        levels = json.fetch('levels')

        World.new(levels)
      end
    end
  end
end