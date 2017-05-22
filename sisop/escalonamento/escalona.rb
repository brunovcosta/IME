@time = 0

n1 = gets.to_i
@rr_same = 0
@rr_time = 10
@rr=[]
for i in 1..n1
	split  = gets.split

	@rr << {
		burst: split[0].to_i,
		io: split[1].to_i,
		done: 0,
		name: i
	}
end

n2 = gets.to_i
@fcfs_limit = 30
@fcfs=[]
for i in 1..n2
	split  = gets.split

	@fcfs << {
		burst: split[0].to_i,
		io: split[1].to_i,
		done: 0,
		name: i+n1
	}
end

@io_time = 20
@io = []

def get_phase p
	rest = p[:done] % (p[:burst] + @io_time)
	if rest < p[:burst]
		return :cpu
	else
		return :io
	end
end

def total_time p
	return (@io_time+p[:burst])*p[:io] + p[:burst]
end

@delta_time = 1
while not [@rr,@fcfs,@io].all? &:empty?
	@time+=@delta_time
	
	# executa processos
	@rr[0][:done]+=@delta_time unless @rr.empty?
	@fcfs[0][:done]+=@delta_time if @rr.empty? and not @fcfs.empty?
	@io[0][:done]+=@delta_time unless @io.empty?


	unless @rr.empty?
		@rr_same += @delta_time
		if @rr_same >= @rr_time
			p = @rr.shift
			p[:wait_start]=@time
			@fcfs << p

			@rr_same = 0
		end
	end

	# remove processos que ja terminaram
	for queue in [@rr,@fcfs,@io]
		queue.delete_if{|p|p[:done] > (total_time p)}
	end

	# passa processos em fase io para io
	@rr_same = 0 if @rr.first and (get_phase @rr.first)==:io
	@io.concat (@rr|@fcfs).select{|p| (get_phase p) == :io}
	@fcfs.delete_if{|p| (get_phase p) == :io}
	@rr.delete_if{|p| (get_phase p) == :io}

	# passa processos em io para rr
	@rr.concat @io.select{|p| (get_phase p) == :cpu}
	@io.delete_if{|p| (get_phase p) == :cpu}

	# passa processos ociosos de fcfs para rr
	@rr.concat @fcfs.select{|p| @time - p[:wait_start] > @fcfs_limit}
	@fcfs.delete_if{|p| @time - p[:wait_start] > @fcfs_limit}

	if not @rr.empty?
		puts "#{@time}\t#{@rr.first[:name]}\t#{@io[0] and @io[0][:name]}"
	elsif not @fcfs.empty?
		puts "#{@time}\t#{@fcfs.first[:name]}\t#{@io[0] and @io[0][:name]}"
	end

end
