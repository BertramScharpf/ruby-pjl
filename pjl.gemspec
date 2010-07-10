#
#  pjl.gemspec  --  Ruby-PJL Gem specification
#


require "rubygems"

require "./lib/pjl.rb"

SPEC = Gem::Specification.new do |s|
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

if $0 == __FILE__ then
  (Gem::Builder.new SPEC).build
end

