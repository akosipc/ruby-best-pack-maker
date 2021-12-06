# typed: strict
require 'byebug'
require 'sorbet-runtime'

Dir[File.join("./lib/**/*.rb")].each {|f| require f }
