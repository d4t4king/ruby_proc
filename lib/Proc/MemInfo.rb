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
end

