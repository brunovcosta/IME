def f x
	@xs.each_index do |i|
		if @xs[i]== x then
			return @ys[i]
		end
	end
end

def divided_diference x
	if x.size == 2 then
		return (f(x[1]) -f(x[0]))/(x[1]-x[0])
	elsif x.size ==1 then
		return f(x[0])
	else
		x1 = x.dup
		x1.shift
		f1 = divided_diference x1
		x2 = x.dup
		x2.pop
		f2 = divided_diference x2
		return (f1-f2)/(x.last-x.first)
	end
end

#aqui vem as frescuras de input e output
puts "insira os x's"
@xs = (gets.chomp.split " ")
@xs.each_index{|i| @xs[i] = @xs[i].to_f}
puts "insira os y's"
@ys = (gets.chomp.split " ")
@ys.each_index{|i| @ys[i] = @ys[i].to_f}

puts "Polinômio"
puts "p(x) = "
@xs.each_index do |k|
	print divided_diference @xs[0..k] 
	print "\t*x^"
	print k
	if k<@xs.size-1 then
		puts "+"
	else
		puts ""
	end
end

#aqui eu imprimo a piramide
puts "\n\nTabela de diferenças divididas:"
@xs.each_index do |i|
	for j in 0..i do
		print divided_diference @xs[(i-j)..i]
		print "\t"
	end
	puts " "
	
end
