# encoding: utf-8
#require 'rubygems' # not necessary for Ruby 1.9 and above!
#require 'bson'
require 'mongo'
include Mongo

require_relative 'pool'
require_relative 'configuration'
require_relative 'db/db'

def readHashFromFile(fn)
  fg = {}
  ll = nil
  File.readlines(fn).each { |line| line = line[0...-1]
  if ll != nil
    fg[ll] = line
    ll = nil
  else
    ll = line
  end

  }
  return fg
end

# read from file formatted like:
# key
# value1"value2"..."valuen\n
def readHashArray(fn)
    fg = {}
    ll = nil
    File.readlines(fn).each { |line| 
        line = line[0...-1] # remove newline
        if ll != nil
            fg[ll] = line.split('"')
            ll = nil
        else
            ll = line
        end

    }
    return fg
end
