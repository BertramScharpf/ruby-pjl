#
#  pjl.rb  --  PJL generation
#

=begin rdoc

:section: Classes definied here

PJL generates PJL code.

=end
    

require "pipe"

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

  VERSION = "1.0"

  def job name, *args
    print "\0"*32
    uel
    pjl
    j = { :name => name.to_s }
    pjl_opt :job, j, *args
    yield
  ensure
    pjl_opt :eoj, j
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

  def echo *args
    pjl :echo, *args
  end

  def comment *args
    pjl :comment, *args
  end

  def method_missing name, *args, &block
    nh = args.find { |a| not Hash === a }
    if nh then
      raise NoMethodError,
                    "undefined instance method `#{meth}' for #{self.class}"
    else
      n = name.to_s
      case n
        when /\Apjl_/ then pjl_opt $', *args
        else               pjl_opt n,  *args
      end
    end
  end

  def enter language
    pjl_opt :enter, :language => language.to_sym
    yield
  ensure
    uel
    pjl
  end

  def pipe cmd
    Pipe.run cmd, $stdout do |p|
      p.feed $stdin
    end
  end

  private

  def uel
    print "\e%-12345X"
  end

  def pjl *args
    l = [ "@PJL", *args]
    l.flatten!
    z = l.join " "
    puts z
  end

  def pjl_opt name, *args
    opt = {}
    args.each { |a| a.each { |k,v| opt[ k] = v } }
    cmd = [ name.to_s.upcase]
    @m and @m.each { |k,v|
      cmd.push k.to_s.upcase, ":", v
    }
    opt.each { |k,v|
      w = case v
        when String then
          v = v.gsub '"', "''"
          "\"#{v}\""
        when Symbol then
          v = v.to_s.upcase
        else
          v.to_s
      end
      cmd.push k.to_s.upcase, "=", w
    }
    pjl cmd
  end

end

