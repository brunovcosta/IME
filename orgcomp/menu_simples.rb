loop do
	system "clear"
	puts %{
                                   
 _____         _____               
|     |___ ___|     |___ _____ ___ 
|  |  |  _| . |   --| . |     | . |
|_____|_| |_  |_____|___|_|_|_|  _|
          |___|               |_|  
}
	
	puts "Qual programa deseja executar?"
	puts "1 - Big Endian/Little Endian"
	puts "2 - Código de Hamming"
	puts "3 - Raid"
	puts "0 - Sair"
	case gets.chop.to_i
	when 1
		load "./trabalho_a.rb"
	when 2
		load "./trabalho_b.rb"
	when 3
		load "./trabalho_c.rb"
	else
		exit
	end
	gets
end
