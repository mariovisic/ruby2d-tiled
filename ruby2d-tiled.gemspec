# frozen_string_literal: true

require_relative "lib/ruby2d/tiled/version"

Gem::Specification.new do |spec|
  spec.name = "ruby2d-tiled"
  spec.version = Ruby2d::Tiled::VERSION
  spec.authors = ["Mario Visic"]
  spec.email = ["mario@mariovisic.com"]

  spec.summary = "A 2d level loader for Ruby2D, compatible with LDTK files"
  spec.description = "Load your worlds and levels into ruby2d using this convinent gem which reads files written by the LDTK editor."
  spec.homepage = "https://github.com/mariovisic/ruby2d-tiled"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.4"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mariovisic/ruby2d-tiled"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "ruby2d", ">= 0.11.1"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
