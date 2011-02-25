require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
# require 'shoulda'
require 'active_record'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
# $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'lib/chronicler'
require 'models/user'

def load_schema
  config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
  # ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
  db_adapter = ENV['DB'] || 'sqlite3'
  
  # no DB passed, try sqlite3 by default
  db_adapter ||=
    begin
      require 'sqlite3'
        'sqlite3'
    rescue MissingSourceFile 
    end
    
  if db_adapter.nil? 
    raise "No DB Adapter selected. Configure test/database.yml and use DB=mysql|postgresql|sqlite3 to pick one. sqlite3 will be used by default (gem install sqlite3-ruby)."
  end
  
  ActiveRecord::Base.establish_connection(config[db_adapter])
  load(File.dirname(__FILE__) + "/schema.rb")
end

load_schema

class Test::Unit::TestCase
end
