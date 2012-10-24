require 'rake/clean'
require 'rake/testtask'
require 'fileutils'
require 'date'

require 'lib/hotkeys/version.rb'

# task :default => :test
# task :spec => :test

# PACKAGING ============================================================

if defined?(Gem)
  # Load the gemspec using the same limitations as github
  def spec
    require 'rubygems' unless defined? Gem::Specification
    @spec ||= eval(File.read('hotkeys.gemspec'))
  end

  def package(ext='')
    "pkg/hotkeys-#{spec.version}" + ext
  end

  desc 'Build packages'
  task :package => %w[.gem].map {|e| package(e)}

  desc 'Build and install as local gem'
  task :install => package('.gem') do
    `gem install #{package('.gem')}`
  end

  directory 'pkg/'
  CLOBBER.include('pkg')

  file package('.gem') => %w[pkg/ hotkeys.gemspec] + spec.files do |f|
    `gem build hotkeys.gemspec`
    mv File.basename(f.name), f.name
  end

end