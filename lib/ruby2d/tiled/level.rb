require 'securerandom'

module Ruby2d
  module Tiled
    class Level
      attr_writer :x_offset, :y_offset, :angle

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
        @angle = 0

        @data = data
        @layer_data = layer_data
        @tileset_relative_path = tileset_relative_path
        @tilesets = {}

        @layers = @data['layerInstances'].reverse.select do |layer|
          ['Tiles', 'IntGrid', 'AutoLayer'].include?(layer['__type'])
        end
        @ruby2d_objects = []
      end

      def show
        Window.set(background: @data['__bgColor'])

        @layers.each_with_index do |layer, z_index|
          grid_size = layer['__gridSize'] * @scale
          grid_tiles = layer['gridTiles'] + layer['autoLayerTiles']

          if grid_tiles.size > 0
            tileset = @tilesets[layer['__identifier']]

            if !tileset
              tileset = Ruby2D::Tileset.new(
                File.expand_path(File.join(@tileset_relative_path, layer['__tilesetRelPath'])),
                tile_width: layer['__gridSize'],
                tile_height: layer['__gridSize'],
                scale: @scale,
                z: z_index,
                padding: 0, # FIXME: implement padding
                spacing: 0, # FIXME: implement spacing
              )

              # FIXME: We use the gridSize and not the width and height, i'm not sure if that's OK
              # Will need to fix this later
              (grid_tiles.uniq { |tile| tile.slice('src', 'f') }).each do |tile|
                tileset.define_tile("#{tile['t']}#{tile['f']}", tile['src'][0] / layer['__gridSize'], tile['src'][1] / layer['__gridSize'], flip: FLIP_MAP[tile['f']])
              end

              @tilesets[layer['__identifier']] = tileset
            end

            grid_tiles.each do |tile|
              tileset.set_tile("#{tile['t']}#{tile['f']}", [{ x: (tile['px'][0] * @scale) + @x_offset, y: (tile['px'][1] * @scale) + @y_offset }])
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
                  z: z_index,
                  size: grid_size,
                  color: color
                ))
              end
            end
          end
        end
      end

      def scale=(scale)
        @scale = scale
        @tilesets.each_value { |tileset| tileset.instance_variable_set('@scale', scale) }
      end

      def clear
        @ruby2d_objects.each(&:remove)
        @tilesets.each_value(&:clear_tiles)
        @ruby2d_objects = []
      end
    end
  end
end