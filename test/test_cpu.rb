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
	def test_model
		assert_not_nil(@@pc.cpus[0].model, "not nil")
	end
end
