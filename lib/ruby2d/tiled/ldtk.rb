require 'json'

module Ruby2d
  module Tiled
    class LDTK
      def self.load(ldtk_file)

        ldtk_file_path = File.expand_path(File.dirname(ldtk_file))
        json = JSON.parse(File.read(ldtk_file))
        levels = json.delete('levels').map { |level_data| Level.new(level_data, ldtk_file_path) }

        World.new(json, levels)
      end
    end
  end
end