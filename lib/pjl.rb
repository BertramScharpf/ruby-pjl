#
#  pjl.rb  --  PJL generation
#

=begin rdoc

:section: Classes definied here

PJL generates PJL code.

=end


class Object
  def to_pjlkey ; to_s ; end
end
class String
  def to_pjlkey ; v = gsub '"', "''" ; %Q("#{v}") ; end
end
class Symbol
  def to_pjlkey ; r = to_s; r.upcase! ; r ; end
end
class Array
  def to_pjlkey ; map { |x| x.to_pjlkey }.join ; end
end


# PJL generation
#
# = Example
#
#   class MyPrinter
#     include PJL
#     def run
#       job "job-#$$" do
#         rdymsg display: "wait..."
#         enter :postscript do
#           puts "%!PS"
#           ...
#         end
#       end
#     end
#   end
#   MyPrinter.new.run
#
module PJL

  def job name, **kwargs
    print "\0"*32
    uels do
      pjl
      pjl :job, name: name, **kwargs
      yield
    ensure
      pjl :eoj, name: name
    end
  end

  def lparm p
    m = @m
    @m = { lparm: p.to_sym }
    yield
  ensure
    @m = m
  end

  def iparm p
    m = @m
    @m = { iparm: p.to_sym }
    yield
  ensure
    @m = m
  end

  def noop
    pjl
  end
  alias nop noop

  def method_missing name, *args, **kwargs, &block
    if block then
      super
    else
      args.each { |a|
        case a
          when String, Symbol then next
          else                     super
        end
      }
      if name.to_s =~ /\Apjl_/ then name = $'.to_sym end
      pjl name, *args, **kwargs
    end
  end

  def enter language
    pjl :enter, language: language.to_sym
    yield
  ensure
    uel
    pjl
  end

  private

  def uel
    print "\e%-12345X"
  end

  def uels
    uel
    yield
  ensure
    uel
  end

  class Cmd
    def initialize     ; @cmd = "@PJL" ; end
    def to_s           ; @cmd          ; end
    def push k         ;          @cmd << " " << k.to_pjlkey ; end
    def pushkw k, s, v ; push k ; @cmd << s   << v.to_pjlkey ; end
  end

  def pjl *args, **kwargs
    c = Cmd.new
    args.flatten!
    args   .each { |a|   c.push   a         }
    @m    &.each { |k,v| c.pushkw k, ":", v }
    kwargs .each { |k,v| c.pushkw k, "=", v }
    puts c
  end

  def system *args
    super or raise "#{args.first} terminated unsuccessful: #$?"
  end

end

