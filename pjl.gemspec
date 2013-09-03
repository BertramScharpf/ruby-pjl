#
#  pjl.gemspec  --  Ruby-PJL Gem specification
#

$:.unshift "./lib"
require "pjl/version.rb"

Gem::Specification.new do |s|
  s.name              = PJL::NAME
  s.rubyforge_project = "NONE"     # Only this prevents a warning.
  s.version           = PJL::VERSION
  s.summary           = PJL::SUMMARY
  s.description       = PJL::DESCRIPTION
  s.license           = PJL::LICENSE
  s.authors           = PJL::TEAM
  s.email             = PJL::AUTHOR
  s.homepage          = PJL::HOMEPAGE

  s.requirements      = "Some other tools from the same author"
  s.add_dependency      "appl", ">=1.0"

  s.files             = %w(
                          lib/pjl.rb
                          lib/pjl/appl.rb
                          lib/pjl/version.rb
                          example/ifbrother
                          example/ifcanon
                          example/ifkyocera
                        )
  s.executables       = %w(
                        )

  s.has_rdoc          = true
  s.extra_rdoc_files  = %w(
                          README
                          LICENSE
                        )
  s.rdoc_options.concat %w(--charset utf-8 --main lib/pjl.rb)
end

