require 'securerandom'

module Ruby2d
  module Tiled
    class Level
      def initialize(data, tileset_relative_path, layer_data)
        @data = data
        @layer_data = layer_data
        @tileset_relative_path = tileset_relative_path
        @tilesets = @data['layerInstances'].select do |layer|
          ['Tiles', 'IntGrid'].include?(layer['__type'])
        end
      end

      def show
        Window.set(background: @data['__bgColor'])

        (@data['layerInstances'].reverse.select do |layer|
          ['Tiles', 'IntGrid', 'AutoLayer'].include?(layer['__type'])
        end).each do |layer|
          if layer['gridTiles'].size > 0 || layer['autoLayerTiles'].size > 0
            tileset = Ruby2D::Tileset.new(
              File.expand_path(File.join(@tileset_relative_path, layer['__tilesetRelPath'])),
              tile_width: layer['__gridSize'],
              tile_height: layer['__gridSize'],
              padding: 0, # FIXME: implement padding
              spacing: 0, # FIXME: implement spacing
            )

            grid_tiles = layer['gridTiles'] + layer['autoLayerTiles']


            # FIXME: We use the gridSize and not the width and height, i'm not sure if that's OK
            # Will need to fix this later
            grid_tiles.each do |tile|
              tile_id = SecureRandom.uuid
              tileset.define_tile(tile_id, tile['src'][0] / layer['__gridSize'], tile['src'][1] / layer['__gridSize'])
              tileset.set_tile(tile_id, [{ x: tile['px'][0], y: tile['px'][1] }])
            end
          elsif layer['intGridCsv'].size > 0
            layer_data = @layer_data.detect { |layer_data| layer_data['uid'] == layer['layerDefUid'] }

            layer['intGridCsv'].each_with_index do |int_grid_value, index|
              if int_grid_value != 0
                color = (layer_data['intGridValues'].detect { |value| value['value'] == int_grid_value })['color']

                # FIXME: Need to support offsers here :)
                x = (index % layer['__cWid']) * layer['__gridSize']
                y = ((index + 1).to_i / layer['__cWid'].to_i) * layer['__gridSize']

                Ruby2D::Square.new(
                  x: x,
                  y: y,
                  size: layer['__gridSize'],
                  color: color
                )
              end
            end
          end
        end
      end
    end
  end
end