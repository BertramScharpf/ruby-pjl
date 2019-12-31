#
#  pjl.gemspec  --  Ruby-PJL Gem specification
#

require "./lib/pjl/version.rb"

Gem::Specification.new do |s|
  s.name              = PJL::NAME
  s.version           = PJL::VERSION
  s.summary           = PJL::SUMMARY
  s.description       = PJL::DESCRIPTION
  s.license           = PJL::LICENSE
  s.authors           = PJL::TEAM
  s.email             = PJL::AUTHOR
  s.homepage          = PJL::HOMEPAGE

  s.requirements      = "Some other tools from the same author"
  s.add_dependency      "appl", "~>1.0"

  s.files             = %w(
                          lib/pjl.rb
                          lib/pjl/appl.rb
                          lib/pjl/version.rb
                          example/ifbrother
                          example/ifcanon
                          example/ifkyocera
                          example/iffile
                          example/printcap
                          example/nikolaus.ps
                        )
  s.executables       = %w(
                        )

  s.extra_rdoc_files  = %w(
                          README
                          LICENSE
                        )
  s.rdoc_options.concat %w(--charset utf-8 --main lib/pjl.rb)
end

