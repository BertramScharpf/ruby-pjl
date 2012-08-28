#
#  pjl.gemspec  --  Ruby-PJL Gem specification
#

require "./lib/pjl.rb"

Gem::Specification.new do |s|
  s.name              = "pjl"
  s.version           = PJL::VERSION
  s.summary           = "PJL generation"
  s.description       = <<EOT
Write PJL commands from a Ruby program.
EOT
  s.authors           = [ "Bertram Scharpf"]
  s.email             = "bs-ruby", ">=3.0"
  s.has_rdoc          = true
  s.files             = %w(
                          lib/pjl.rb
                          example/mfc7420
                        )
  s.extra_rdoc_files  = %w(
                          README
                          LICENSE
                          example/mfc7420
                        )
end

