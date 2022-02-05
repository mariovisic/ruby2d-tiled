# frozen_string_literal: true

$LOAD_PATH.push(__dir__)

require "tiled/ldtk"
require "tiled/level"
require "tiled/world"
require "tiled/version"

module Ruby2d
  module Tiled
    class Error < StandardError; end
  end
end
