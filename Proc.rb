#!/usr/bin/env ruby

require 'rubygems'
require 'colorize'
require 'pp'

#class Proc() {
#	attr_accessor :proc
#}

class Proc::CpuInfo
	attr_accessor :processor_count
	attr_accessor :core_count
	attr_accessor :cpus				# an array of Proc::CpuInfo::CPU objects

	def initialize() 
		@processor_count = %x{/bin/grep -c 'processor' /proc/cpuinfo}.chomp.strip.to_i
		@core_count = %x{/bin/grep 'cpu cores' /proc/cpuinfo | /usr/bin/cut -d: -f2 | /usr/bin/sort -u}.chomp.strip.to_i

		#if @processor_count > 1
		#	cpu = Process::CpuInfo::CPU.new()
		#	@cpus << cpu
		#end
	end
end

class Proc::CpuInfo::CPU
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
	attr_accessor :fpu
	attr_accessor :fpu_exception
	attr_accessor :cpuid_level
	attr_accessor :wp
	attr_accessor :flags
	attr_accessor :bogomips
	attr_accessor :clflush_size
	attr_accessor :cachesize_alignment
	attr_accessor :address_sizes
	attr_accessor :power_management

	def initialize() 
		%x{"cat /proc/cpuinfo"}.split(/\n/).each do |l|
			l.chomp!
			(name, value) = l.split(/\:/)
			name.strip!
			value.strip!

			case name
			when /processor/
				@processor_id = value
			when /vendor_id/
				@vendor_id = value
			when /cpu family/
				@cpu_family = value
			when /model/
				@model = value
			when /model name/
				@model_name = value
			when /stepping/
				@stepping = value
			when /microsode/
				@microcode = value
			when /cpu MHz/
				@cpu_mhz = value
			when /cache size/
				@cache_size = value
			else
				raise "Unrecognized key-value pair:  #{name} : #{value}!"
			end
		end
	end

	def pretty_print
		puts <<-EOS

Processor	:	#{@processor_id}
Vendor ID	:	#{@vendor_id}

EOS
	end
end

