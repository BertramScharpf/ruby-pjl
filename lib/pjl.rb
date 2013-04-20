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
#         rdymsg :display => "wait..."
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

  def job name, *args
    print "\0"*32
    uel
    pjl
    j = { :name => name.to_s }
    args.push j
    pjl :job, *args
    yield
  ensure
    pjl :eoj, j
    uel
  end

  def lparm p
    m = @m
    @m = { :lparm => p.to_sym }
    yield
  ensure
    @m = m
  end

  def iparm p
    m = @m
    @m = { :iparm => p.to_sym }
    yield
  ensure
    @m = m
  end

  def noop
    pjl
  end
  alias nop noop

  def method_missing name, *args, &block
    if block then
      super
    else
      args.each { |a|
        case a
          when String, Symbol, Hash then next
          else                           super
        end
      }
      if name.to_s =~ /\Apjl_/ then name = $'.to_sym end
      pjl name, *args
    end
  end

  def enter language
    pjl :enter, :language => language.to_sym
    yield
  ensure
    uel
    pjl
  end

  private

  def uel
    print "\e%-12345X"
  end

  def pjl *args
    opt = {}
    opt.update args.pop while args.last.is_a? Hash
    l = []
    args.flatten!
    args.each { |a| l.push a }
    @m and @m.each { |k,v| l.push [ k, :":", v] }
    opt      .each { |k,v| l.push [ k, :"=", v] }
    cmd = "@PJL"
    l.each { |x| cmd << " " << x.to_pjlkey }
    puts cmd
  end

end

