#!/usr/bin/env ruby

require 'rubygems'
require 'colorize'
require 'pp'

class Proc() {

}

class Proc::CpuInfo()
	attr_accessor :processor_count
	attr_accessor :core_count
	attr_accessor :cpus				# an array of Proc::CpuInfo::CPU objects
end

class Proc::CpuInfo::CPU()
	attr_accessor :processor_id
	attr_accessor :vendor_id
	attr_accessor :cpu_family
	attr_accessor :model
	attr_accessor :model_name
	attr_accessor :stepping
	attr_accessor :microcode
	attr_accessor :cache_size
	attr_accessor :cpu_mhz
	attr_accessor :siblings
	attr_accessor :core_id
	attr_accessor :physical_id
	attr_accessor :cpu_cores
	attr_accessor :apic_id
	attr_accessor :initial_acpi_id
	attr_accessor :fdiv_bug
	attr_accessor :f00f_bug
	attr_accessor :coma_bug
end
