# frozen_string_literal: true

$LOAD_PATH.push(__dir__)

require "tiled/version"
require "tiled/ldtk"
require "tiled/world"

module Ruby2d
  module Tiled
    class Error < StandardError; end
  end
end
