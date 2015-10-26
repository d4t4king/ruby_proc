require File.join(File.dirname(__FILE__), '..', 'lib', 'Proc')
require 'test/unit'

class CPUTest < Test::Unit::TestCase

	attr_accessor :pc

	@@pc = Proc::CpuInfo.new()

	def test_processor_id
		assert_kind_of(Fixnum, @@pc.cpus[0].processor_id, "num")
	end
	def test_vendor_id
		assert_kind_of(Fixnum, @@pc.cpus[0].vendor_id, "num")
	end
	def test_cpu_family
		assert_not_nil(@@pc.cpus[0].cpu_family, "not nil")
	end
	def test_model
		assert_not_nil(@@pc.cpus[0].model, "not nil")
	end
	def test_model_name
		assert_not_nil(@@pc.cpus[0].model_name, "Not nil")
	end
	def test_stepping
		assert_kind_of(Fixnum, @@pc.cpus[0].stepping)
	end
	def test_microcode
		assert_not_nil(@@pc.cpus[0].microcode)
	end
	def test_cache_size
		assert_not_nil(@@pc.cpus[0].cache_size)
	end
	def test_cpu_mhz
		assert_kind_of(Float, @@pc.cpus[0].cpu_mhz)
	end
	def test_siblings
		assert_not_nil(@@pc.cpus[0].siblings)
	end
	def test_core_id
		assert_kind_of(Fixnum, @@pc.cpus[0].core_id)
	end
	def test_physical_id
		assert_kind_of(Fixnum, @@pc.cpus[0].physical_id)
	end
	def test_cpu_cores
		assert_kind_of(Fixnum, @@pc.cpus[0].cpu_cores)
	end
	def test_apic_id
		assert_kind_of(Fixnum, @@pc.cpus[0].apic_id)
	end
	def test_fdiv_bug
		assert_not_nil(@@pc.cpus[0].fdiv_bug)
	end
	def test_f00f_bug
		assert_not_nil(@@pc.cpus[0].f00f_bug)
	end
	def test_coma_bug
		assert_not_nil(@@pc.cpus[0].coma_bug)
	end
	def test_fpu
		assert_not_nil(@@pc.cpus[0].fpu)
	end
	def test_fpu_exception
		assert_not_nil(@@pc.cpus[0].fpu_exception)
	end
	def test_cpuid_level
		assert_kind_of(Fixnum, @@pc.cpus[0].cpuid_level)
	end
	def test_wp
		assert_not_nil(@@pc.cpus[0].wp)
	end
	def test_flags
		assert_kind_of(Array, @@pc.cpus[0].flags)
	end
	def test_bogomips
		assert_kind_of(Float, @@pc.cpus[0].bogomips)
	end
	def test_clflush_size
		assert_kind_of(Fixnum, @@pc.cpus[0].clflush_size)
	end
	def test_cachesize_alignment
		assert_kind_of(Fixnum, @@pc.cpus[0].cachesize_alignment)
	end
	def test_cache_alignment
		assert_kind_of(Fixnum, @@pc.cpus[0].cache_alignment)
	end
	def test_address_sizes
		assert_kind_of(Array, @@pc.cpus[0].address_sizes)
	end
	def test_power_management
		assert_nil(@@pc.cpus[0].power_management)
	end
end
