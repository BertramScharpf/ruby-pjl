#
#  pjl.gemspec  --  Ruby-PJL Gem specification
#

require "./lib/pjl.rb"

Gem::Specification.new do |s|
  s.name              = "pjl"
  s.version           = PJL::VERSION
  s.summary           = "PJL generation"

  s.description       = <<-EOT
Write PJL commands from a Ruby program.
                          EOT

  s.license           = "BSD"
  s.authors           = [ "Bertram Scharpf"]
  s.email             = "<software@bertram-scharpf.de>"
  s.homepage          = "http://www.bertram-scharpf.de"

  s.rubyforge_project = "NONE"     # Only this prevents a warning.

  s.requirements      = "Just Ruby"
  s.add_dependency      "appl", ">=1.0"
  s.add_dependency      "bs-ruby", ">=3.2"

  s.files             = %w(
                          lib/pjl.rb
                          lib/pjl/appl.rb
                          example/mfc7420
                        )
  s.executables       = %w(
                        )
  s.extra_rdoc_files  = %w(
                        )


  s.has_rdoc          = true
  s.extra_rdoc_files  = %w(
                          README
                          LICENSE
                        )
  s.rdoc_options.concat %w(--charset utf-8 --main lib/pjl.rb)
end

