require 'rubygems'
require 'colorize'
require 'pp'

class Proc

	class Proc::CpuInfo
		attr_accessor :processor_count
		attr_accessor :core_count
		attr_accessor :cpus				# an array of Proc::CpuInfo::CPU objects
	
		def initialize() 
			@processor_count = %x{/bin/grep -c 'processor' /proc/cpuinfo}.chomp.strip.to_i
			@core_count = %x{/bin/grep 'cpu cores' /proc/cpuinfo | /usr/bin/cut -d: -f2 | /usr/bin/sort -u}.chomp.strip!.to_i
			@cpus = Array.new

			if @processor_count > 1
				puts "Processing #{@processor_count} processors."
				cpu_data = %x{/bin/cat /proc/cpuinfo}.split(/\n\n/)
				puts "CPU data glob count doesn't match processor count: #{cpu_data.size.to_s} : #{@processor_count.to_s}" unless cpu_data.size == @processor_count
				cpu_data.each do |glob|
					p = Proc::CpuInfo::CPU.new(glob)
					print "In Proc::CpuInfo.initialize():  ".red
					puts "#{p.class}"
					#pp p
					@cpus.push(p)
				end
				#pp @cpus
				puts "There are #{@cpus.size} CPUs in @cpus."
			end
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
	
		def initialize(proc_data_str = nil) 
			raise "CPU data glob empty!" if proc_data_str.nil? || proc_data_str == ''
	
			fields = proc_data_str.split(/\n/) { |f| f.strip! }

			#pp fields
			fields.each do |kvp|
				(name, value) = kvp.split(/\:/)
				name.strip!
				value.strip! unless value.nil? || value == ''

				case name
				when /processor/
					@processor_id = value.to_i
				when /vendor_id/
					@vendor_id = value.to_i
				when /cpu family/
					@cpu_family = value.to_i
				when /model name/
					@model_name = value
				when /model(?:\t)?\b/
					@model = value.to_i
				when /stepping/
					@stepping = value.to_i
				when /microcode/
					@microcode = value
				when /cpu MHz/
					@cpu_mhz = value.to_f
				when /cache size/
					@cache_size = value
				when /physical id/
					@physical_id = value.to_i
				when /siblings/
					@siblings = value.to_i
				when /core id/
					@core_id = value.to_i
				when /cpu cores/
					@cpu_cores = value.to_i
				when /apicid/
					@apic_id = value.to_i
				when /initial apicid/
					@initial_apic_id = value.to_i
				when /fdiv_bug/
					if value == 'no'
						@fdiv_bug = false 
					elsif value == 'yes'
						@fdiv_bug = true
					else 
						@fdiv_bug = -1
					end
				when /f00f_bug/
					if value == 'no'
						@f00f_bug = false 
					elsif value == 'yes'
						@f00f_bug = true
					else
						@f00f_bug = -1
					end
				when /coma_bug/
					if value == 'no'
						@coma_bug = false 
					elsif value == 'yes'
						@coma_bug = true
					else
						@coma_bug = -1
					end
				when /fpu/
					if value == 'yes'
						@fpu = true 
					elsif value == 'no'
						@fpu = false
					else
						@fpu = -1
					end
				when /fpu_exception/
					if value == 'yes'
						@fpu_exception = true
					elsif value == 'no'
						@fpu_exception = false
					else
						@fpu_exception = -1
					end
				when /cpuid level/
					@cpuid_level = value.to_i
				when /wp/
					if value == 'yes'
						@wp = true 
					elsif value == 'no'
						@wp = false
					else
						@wp = -1
					end
				when /flags/
					@flags = value.split(/ /) { |e| e.strip! }
				when /bugs/
					@bugs = value.split(/ /) { |e| e.strip! }
				when /bogomips/
					@bogomips = value.to_f
				when /clflush size/
					@clflush_size = value.to_i
				when /cache_alignment/
					@cache_alignment = value.to_i
				when /address sizes/
					@address_sizes = value.split(/\,/)
					@address_sizes.each { |e| e.sub!(/\s*(.*?)/, "\\1") }
				when /power management/
					@power_management = value
				else
					raise "Unrecognized key-value pair:  #{name} : #{value}!"
				end
			end
		end

		def dump_all
			puts <<-EOS
Key				:	Value							:	Class/Object Type
========================================================================================================================
Processor			:	#{@processor_id.to_s}							:	#{@processor_id.class}
Vendor ID			:	#{@vendor_id.to_s}							:	#{@vendor_id.class}
CPU Family			:	#{@cpu_family}							:	#{@cpu_family.class}
Model Name			:	#{@model_name}		:	#{@model_name.class}
Model				:	#{@model}							:	#{@model.class}
Stepping			:	#{@stepping}							:	#{@stepping.class}
Microcode			:	#{@microcode}							:	#{@microcode.class}
CPU MHz				:	#{@cpu_mhz}							:	#{@cpu_mhz.class}
Cache Size			:	#{@cache_size}							:	#{@cache_size.class}
Physical ID			:	#{@physical_id}							:	#{@physical_id.class}
Siblings			:	#{@siblings}							:	#{@siblings.class}
Core ID				:	#{@core_id}							:	#{@core_id.class}
CPU Cores			:	#{@cpu_cores.to_s}							:	#{@cpu_cores.class}
APIC ID				:	#{@apic_id}							:	#{@apic_id.class}
Initial APIC ID			:	#{@initial_apic_id}							:	#{@initial_apic_id.class}
fdiv Bug			:	#{@fdiv_bug}							:	#{@fdiv_bug.class}
f00f Bug			:	#{@f00f_bug}							:	#{@f00f_bug.class}
coma Bug			:	#{@coma_bug}							:	#{@coma_bug.class}
FPU				:	#{@fpu}							:	#{@fpu.class}
FPU Exception			:	#{@fpu_exception}							:	#{@fpu_exception.class}
CPU ID Level			:	#{@cpuid_level}							:	#{@cpuid_level.class}
WP				:	#{@wp}							:	#{@wp.class}
Flags				:	#{@flags.to_s}							:	#{@flags.class}
Bugs				:	#{@bugs.to_s}							:	#{@bugs.class}
BogoMIPs			:	#{@bogomips}							:	#{@bogomips.class}
clFlush Size			:	#{@clflush_size}							:	#{@clflush_size.class}
Cache Alignment			:	#{@cache_alignment.to_s}							:	#{@cache_alignment.class}
Address Sizes			:	#{@address_size.to_s}			:	#{@address_size.class}
Power Management		:	#{@power_management}							:	#{@power_management.class}
=========================================================================================

	EOS
		end

		def show_stuff
			puts <<-EOS
	
Processor		:	#{@processor_id.to_s}
Vendor ID		:	#{@vendor_id.to_s}
Model			:	#{@model_name}
CPU Family		:	#{@cpu_family}
CPU MHz			:	#{@cpu_mhz}
CPU Cores		:	#{@cpu_cores.to_s}

	EOS
		end
	end

	class Proc::MemInfo
		attr_accessor	:mem_total
		attr_accessor	:mem_free
		attr_accessor	:mem_available
		attr_accessor	:buffers
		attr_accessor	:cached
		attr_accessor	:swap_cached
		attr_accessor	:active
		attr_accessor	:inactive
		attr_accessor	:active_anon
		attr_accessor	:inactive_anon
		attr_accessor	:active_file
		attr_accessor	:inactive_file
		attr_accessor	:unevictable
		attr_accessor	:mlocked
		attr_accessor	:swap_total
		attr_accessor	:swap_free
		attr_accessor	:dirty
		attr_accessor	:writeback
		attr_accessor	:anon_pages
		attr_accessor	:mapped
		attr_accessor	:s_hmem
		attr_accessor	:s_lab
		attr_accessor	:s_reclaimable
		attr_accessor	:s_unreclaim
		attr_accessor	:kernel_stack
		attr_accessor	:page_tables
		attr_accessor	:nfs_unstable
		attr_accessor	:bounce
		attr_accessor	:write_back_tmp
		attr_accessor	:commit_limit
		attr_accessor	:committed_as
		attr_accessor	:vmalloc_total
		attr_accessor	:vmalloc_used
		attr_accessor	:vmalloc_chunk
		attr_accessor	:hardware_corrupted
		attr_accessor	:anon_huge_pages
		attr_accessor	:huge_pages_total
		attr_accessor	:huge_pages_free
		attr_accessor	:huge_pages_rsvd
		attr_accessor	:huge_pages_surp
		attr_accessor	:huge_page_size
		attr_accessor	:direct_map_4k
		attr_accessor	:direct_map_2m
	
		def initialize
			%x{/bin/cat /proc/meminfo}.split(/\n/).each do |mem|
				(name, val) = mem.split(/\:/)
	
				case name
				when /MemTotal/
					$stderr.puts "|#{val}|"
					mt = val.split(/ kB/)[0].to_i
					$stderr.puts "|#{mt}|"
					mt *= 1024
					@mem_total = mt
				when /MemFree/
					@mem_free = val.lstrip!
				#else
				#	raise "Unrecognized key/value pair: #{name}:#{val}"
				end
			end
		end
	
		def human_readable
			return nil if bytes == 0
			case bytes
			when bytes > 1024^4								# terabytes
				giga = 1024^3
				bytes %= gigs
				$stderr.puts bytes
			when bytes <= 1024^4 && bytes > 1024^3			# gigabytes
				bytes / 1024^4
			when bytes <= 1024^3 && bytes > 1024^2			# megabytes
				bytes / 1024^3
				puts "#{bytes} MB"
			when bytes <= 1024^2 && bytes > 1024			# kilobytes
				bytes /= 1024^2
				puts "#{bytes} KB"
			when bytes <= 1024
				puts "#{bytes} B"
			else
				puts "We should never get here."
			end
		end
	end
end
