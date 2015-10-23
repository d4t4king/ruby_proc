#!/usr/bin/env ruby

require 'rubygems'
require 'pp'
require 'colorize'

require_relative 'Proc.rb'

p = Proc::CpuInfo.new()

#puts p.class

total_cores = 0
p.cpus.each do |cpu|
	cpu.show_stuff
	total_cores += cpu.cpu_cores
	puts "#######################################################"
	puts cpu.inspect
	puts "#######################################################"
end

puts "Total cores (from CPU objects): #{total_cores}"


