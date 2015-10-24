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
				@processor_id = value
			when /vendor_id/
				@vendor_id = value
			when /cpu family/
				@cpu_family = value
			when /model name/
				@model_name = value
			when /model(?:\t)?\b/
				@model = value
			when /stepping/
				@stepping = value
			when /microcode/
				@microcode = value
			when /cpu MHz/
				@cpu_mhz = value
			when /cache size/
				@cache_size = value
			when /physical id/
				@physical_id = value
			when /siblings/
				@siblings = value
			when /core id/
				@core_id = value
			when /cpu cores/
				@cpu_cores = value.to_i
			when /apicid/
				@apicid = value
			when /fdiv_bug/
				@fdiv_bug = false if value == 'no'
			when /f00f_bug/
				@f00f_bug = false if value == 'no'
			when /coma_bug/
				@coma_bug = false if value == 'no'
			when /fpu/
				@fpu = true if value == 'yes'
			when /cpuid level/
				@cpuid_level = value
			when /wp/
				@wp = true if value == 'yes'
			when /flags/
				@flags = value.split(/ /) { |e| e.strip! }
			when /bugs/
				@bugs = value.split(/ /) { |e| e.strip! } unless value.nil? || value == ''
			when /bogomips/
				@bogomips = value
			when /clflush size/
				@clflush_size = value
			when /cache_alignment/
				@cache_alignment = value
			when /address sizes/
				@address_size = value.split(/\,/)
				@address_size.each { |e| e.sub!(/\s*(.*?)/, "\\1") }
			when /power management/
				@power_management = value
			else
				raise "Unrecognized key-value pair:  #{name} : #{value}!"
			end
		end
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

