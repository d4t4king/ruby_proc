#!/usr/bin/env ruby

require 'rubygems'
require 'pp'
require 'colorize'

require_relative 'lib/Proc.rb'
#include Proc

p = Proc::CpuInfo.new()

#puts p.class

total_cores = 0
p.cpus.each do |cpu|
	cpu.show_stuff
	total_cores += cpu.cpu_cores
	#puts "#######################################################"
	#puts cpu.inspect
	#puts "#######################################################"
	#puts "#######################################################"
	#puts p.cpus[0].dump_all
	#puts "#######################################################"
end

puts "Total cores (from CPU objects): #{total_cores}"

m = Proc::MemInfo.new()
#pp m
puts "Total system memory: #{m.human_readable(m.mem_total)}"

