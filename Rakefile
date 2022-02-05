# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :render_test do
  require File.join(__dir__, 'lib/ruby2d/tiled')

  world_files = Dir.glob(File.join(__dir__, 'spec/fixtures/*.ldtk'))

  puts "Press a key to view the next world"

  on :key_down do
    world_file = world_files.pop
    if world_file
      puts "Loading: #{File.basename(world_file)}"

      world = Ruby2d::Tiled::LDTK.load(File.read(world_file))
      world.show
    else
      close
    end
  end

  show
end