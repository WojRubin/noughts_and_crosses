$:.unshift File.join(File.dirname(__FILE__), "lib")
require 'string'
require 'numeric'
require 'validator'
require 'io'
require 'matrix'
require 'game'

game = Game.new
game.doing