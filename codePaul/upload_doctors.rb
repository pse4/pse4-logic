# encoding: ansi
require_relative 'common'




File.readlines('doktor.csv').each { |line| line = line[0...-1]
f = line.split('|')
puts f}



