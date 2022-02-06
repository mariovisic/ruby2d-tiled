# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :render_test do
  require File.join(__dir__, 'lib/ruby2d/tiled')

  set width: 1280
  set height: 720

  world_files = Dir.glob(File.join(__dir__, 'spec/fixtures/*.ldtk'))

  puts "Press a key to view the next world"

  on :key_down do |event|
    case event.key
    when 'return'
      world_file = world_files.pop
      if world_file
        Window.clear
        puts "Loading: #{File.basename(world_file)}"

        @world = Ruby2d::Tiled::LDTK.load(world_file)
        @world.show
      else
        close
      end
    end
  end

  on :key do |event|
    if @world
      case event.key
      when 'a' then @world.scale = @world.scale - 0.005
      when 'z' then @world.scale = @world.scale + 0.005
      when 'left' then @world.x_offset = @world.x_offset - 5
      when 'right' then @world.x_offset = @world.x_offset + 5
      when 'up' then @world.y_offset = @world.y_offset - 5
      when 'down' then @world.y_offset = @world.y_offset + 5
      end
    end
  end

  update do
    if Window.frames % 60 == 0
      puts "FPS: #{Window.fps.round}"
    end
  end

  show
end

task default: [ :spec, :render_test ]