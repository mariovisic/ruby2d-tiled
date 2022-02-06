require 'securerandom'

module Ruby2d
  module Tiled
    class Level
      attr_writer :scale, :x_offset, :y_offset

      FLIP_MAP = {
        0 => nil,
        1 => :horizontal,
        2 => :vertical,
        3 => :both,
      }

      def initialize(data, tileset_relative_path, layer_data)
        @scale = 1
        @x_offset = 0
        @y_offset = 0

        @data = data
        @layer_data = layer_data
        @tileset_relative_path = tileset_relative_path

        @layers = @data['layerInstances'].reverse.select do |layer|
          ['Tiles', 'IntGrid', 'AutoLayer'].include?(layer['__type'])
        end
        @ruby2d_objects = []
      end

      def show
        Window.set(background: @data['__bgColor'])

        @layers.each do |layer|
          grid_size = layer['__gridSize'] * @scale

          if layer['gridTiles'].size > 0 || layer['autoLayerTiles'].size > 0
            tileset = Ruby2D::Tileset.new(
              File.expand_path(File.join(@tileset_relative_path, layer['__tilesetRelPath'])),
              tile_width: layer['__gridSize'],
              tile_height: layer['__gridSize'],
              scale: @scale,
              padding: 0, # FIXME: implement padding
              spacing: 0, # FIXME: implement spacing
            )

            @ruby2d_objects.push(tileset)

            grid_tiles = layer['gridTiles'] + layer['autoLayerTiles']


            # FIXME: We use the gridSize and not the width and height, i'm not sure if that's OK
            # Will need to fix this later

            grid_tiles.each do |tile|
              tile_id = SecureRandom.uuid
              tileset.define_tile(tile_id, tile['src'][0] / layer['__gridSize'], tile['src'][1] / layer['__gridSize'], flip: FLIP_MAP[tile['f']])
              tileset.set_tile(tile_id, [{ x: (tile['px'][0] * @scale) + @x_offset, y: (tile['px'][1] * @scale) + @y_offset }])
            end
          elsif layer['intGridCsv'].size > 0
            layer_data = @layer_data.detect { |layer_data| layer_data['uid'] == layer['layerDefUid'] }

            layer['intGridCsv'].each_with_index do |int_grid_value, index|
              if int_grid_value != 0
                color = (layer_data['intGridValues'].detect { |value| value['value'] == int_grid_value })['color']

                # FIXME: Need to support offsers here :)
                x = (((index % layer['__cWid'])) * grid_size) + @x_offset
                y = (((index + 1).to_i / layer['__cWid'].to_i) * grid_size) + @y_offset

                @ruby2d_objects.push(Ruby2D::Square.new(
                  x: x,
                  y: y,
                  size: grid_size,
                  color: color
                ))
              end
            end
          end
        end
      end

      def clear
        @ruby2d_objects.each(&:remove)
        @ruby2d_objects = []
      end
    end
  end
end