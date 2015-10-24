require_relative './CpuInfo/CPU.rb'

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

