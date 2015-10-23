#!/usr/bin/env ruby

require 'rubygems'
require 'pp'
require 'colorize'

require_relative 'Proc.rb'

p = Proc::CpuInfo.new()

puts p.class

p.cpus.each do |cpu|
	cpu.show_stuff
end
