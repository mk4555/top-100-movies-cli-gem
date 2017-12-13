
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "top_100_movies/version"

Gem::Specification.new do |spec|
  spec.name          = "top-100-movies"
  spec.version       = Top100Movies::VERSION
  spec.authors       = ["Min Suk Kim"]
  spec.email         = ["mk4555@nyu.edu"]

  spec.summary       = %q{CLI gem that lists and shows details of top 100 movies picked by Rotten Tomatoes}
  spec.description   = %q{All data from this gem is scraped from https://www.rottentomatoes.com}
  spec.homepage      = "https://github.com/mk4555/top-100-movies-cli-gem"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org/"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
