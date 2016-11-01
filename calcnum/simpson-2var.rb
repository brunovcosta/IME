@nx = 2
@ny = 4

def f x,y
	#coloque aqui sua lei de formação
	return Math.exp(-(x+y)) 
end
def innerintegral x, a, b
	if a<b then
		h = (b-a)*1.0/@ny
		m=0
		s=0
		for y in (a..b).step h 
			r=f x,y
			print "r: "
			puts r
			print "m: "
			puts (if !(y==a || y==b) then (m+1)*2.0 else 1 end) 
			if(y==a || y==b)
				s+=r
			else
				if m == 0 then m = 1 else m = 0 end
				s+=r*(m+1)*2.0
			end
		end
		return s*h/3.0
	else
		#puts "a<b:{"
		#puts a
		#puts b
		#puts "}"
		return 0
	end
end

def integral1 x
	a= x*x
	b=Math.sqrt x
	return innerintegral x, a, b
end

def integral2 x
	a=(x+2)/3
	b=6-x
	innerintegral x, a, b
end

def integral x
	#if x<2
		int = integral1 x
		print "I("
		print x
		print ") = "
		puts int
		return int
	#else
	#	return integral2 x
	#end
end

def outerintegral 
	a=0.0
	b=1.0
	h = (b-a)/@nx
	m=0
	s=0
	for x in (a..b).step h 
		r=integral x
		if(x==a || x==b)
			s+=r
		else
			if m == 0 then m = 1 else m = 0 end
			s+=r*(m+1)*2.0
		end
	end
	return s*h/3.0
end

puts outerintegral
