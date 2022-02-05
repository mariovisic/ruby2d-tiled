require 'json'

module Ruby2d
  module Tiled
    class LDTK
      def self.load(ldtk_json_string)
        json = JSON.parse(ldtk_json_string)
        levels = json.delete('levels').map { |level_data| Level.new(level_data) }

        World.new(json, levels)
      end
    end
  end
end