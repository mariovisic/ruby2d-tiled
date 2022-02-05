# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :render_test do
  require File.join(__dir__, 'lib/ruby2d/tiled')

  world_files = Dir.glob(File.join(__dir__, 'spec/fixtures/*.ldtk'))

  puts "Press a key to view the next world"

  on :key_down do |event|
    if event.key == 'return'
      world_file = world_files.pop
      if world_file
        Window.clear
        puts "Loading: #{File.basename(world_file)}"

        world = Ruby2d::Tiled::LDTK.load(world_file)
        world.show
      else
        close
      end
    end
  end

  show
end

task default: [ :spec, :render_test ]