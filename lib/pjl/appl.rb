#
#  pjl/appl.rb  --  Application
#

require "appl"
require "pjl"

class PjlAppl < Application

  NAME      = "pjlappl"
  VERSION   = "0.0"
  SUMMARY   = "This is just a template"

  attr_writer :width, :length, :indent, :login, :host
  attr_bang :plain, :debug

  define_option "c", :plain!,              "pass through control characters"
  alias_option  "c", "passctrl"
  define_option "w", :width=,  "NUM",                                "width"
  alias_option  "w", "width"
  define_option "l", :length=, "NUM",                               "length"
  alias_option  "l", "length"
  define_option "i", :indent=, "NUM",                               "indent"
  alias_option  "i", "indent"
  define_option "n", :login=,  "STR",                           "login name"
  alias_option  "n", "login"
  define_option "h", :host=,   "STR",                            "host name"
  alias_option  "h", "host"

  define_option "g", :debug!,           "lots of ugly debugging information"
  alias_option  "g", "debug"

  define_option "H", :help,                         "show this options list"
  alias_option  "H", "help"
  define_option "V", :version,                    "show version information"
  alias_option  "V", "version"

  def run
    @host ||= gethostname
    @host, = @host.split "."
    @acct_file = @args.shift
    if @plain then
      while (l = readline) do
        print l
      end
    else
      frame
    end
  rescue EOFError
  end

  include PJL

  private

  def gethostname
    require "socket"
    Socket.gethostname
  end

end

