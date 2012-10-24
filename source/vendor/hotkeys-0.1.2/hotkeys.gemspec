require 'lib/hotkeys/version'

Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  s.name = %q{hotkeys}
  s.version = "#{Hotkeys::Version::STRING}"
  s.authors = ["Rob Lowe"]
  s.date = %q{2011-06-08}
  s.description = %q{A simple gem which allows you to bind global hot keys with macruby}
  s.email = %q{rob@iblargz.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "CHANGES",
    "README.md"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.md",
    "Rakefile",
    "hotkeys.gemspec",
    "lib/hotkeys.rb",
    "lib/hotkeys/version.rb",
    "lib/hotkeys/support.rb",
    "lib/hotkeys/support/bridgesupport/Events.bridgesupport",
    "lib/hotkeys/support/bundles/shortcut.bundle",
    "lib/hotkeys/support/bundles/shortcut.m",
    "lib/hotkeys/support/keys.rb"
  ]
  s.homepage = %q{http://github.com/RobertLowe/hotkeys}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.2}
  s.summary = %q{A simple gem which allows you to bind global hot keys with macruby}

  s.add_development_dependency(%q<rake>, [">= 0"])
  s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
end 