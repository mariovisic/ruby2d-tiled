require 'securerandom'

module Ruby2d
  module Tiled
    class Level
      def initialize(data, tileset_relative_path)
        @data = data
        @tileset_relative_path = tileset_relative_path
        @tile_data = @data['layerInstances'].detect do |layer|
          layer['__type'] == 'Tiles'
        end
      end

      def show
        if @tile_data
          @tileset = Ruby2D::Tileset.new(
            File.expand_path(File.join(@tileset_relative_path, @tile_data['__tilesetRelPath'])),
            tile_width: @tile_data['__cWid'],
            tile_height: @tile_data['__cHei'],
            padding: 0, # FIXME: implement padding
            spacing: 0, # FIXME: implement spacing
          )

          # FIXME: This needs tweaking, it does not render correctly
          @tile_data['gridTiles'].each do |tile|
            tile_id = SecureRandom.uuid
            @tileset.define_tile(tile_id, tile['src'][0], tile['src'][1])
            @tileset.set_tile(tile_id, [{ x: tile['px'][0], y: tile['px'][1] }])
          end
        end
      end
    end
  end
end