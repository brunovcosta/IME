# Programa deve simular o esquema de armazenamento e recuperação RAID 5 com um bit de
# informação por disco ao invés de uma tira, recebendo um conjunto de informações em tempo de
# execução (uma linha, caracteres e números inteiros), com quatro discos para informação e um para
# as redundâncias e paridade. Deve ser simulada a perda de um disco e recuperação dos dados
# perdidos (4.6 pontos).


def calcula_paridade palavra
	soma=0
	for digito in palavra
		soma+=digito
	end
	return soma%2
end

def erro palavra
	return nil if calcula_paridade(palavra)==1

	key_1 = palavra[1-1]
	key_2 = palavra[2-1]
	bit_1 = palavra[3-1]
	key_3 = palavra[4-1]
	bit_2 = palavra[5-1]
	bit_3 = palavra[6-1]
	bit_4 = palavra[7-1]

	erro_1 = key_1 ^ bit_1 ^ bit_2 ^ bit_4
	erro_2 = key_2 ^ bit_1 ^ bit_3 ^ bit_4
	erro_3 = key_3 ^ bit_2 ^ bit_3 ^ bit_4

	return "#{erro_3}#{erro_2}#{erro_1}".to_i(2)-1
end

def inverte_bit palavra,pos
	palavra[pos] = 1-palavra[pos]
end

def corrigir palavra
	inverte_bit palavra, erro(palavra) if erro(palavra)
	return palavra
end

def proteger p
	palavra = [0,0,p[0],0,p[1],p[2],p[3]]

	bit_1 = palavra[3-1]
	bit_2 = palavra[5-1]
	bit_3 = palavra[6-1]
	bit_4 = palavra[7-1]

	key_1 = bit_1 ^ bit_2 ^ bit_4
	key_2 = bit_1 ^ bit_3 ^ bit_4
	key_3 = bit_2 ^ bit_3 ^ bit_4

	
	nova_palavra =  [key_1,key_2,p[0],key_3,p[1],p[2],p[3]]

	return nova_palavra.concat [1 - calcula_paridade(nova_palavra)]
	
end


def frase2raid frase
	binarios = frase.chars.map{|c|("00000000"+c.ord.to_s(2))[-8..-1]} 
	bits4 = binarios.map{|b|[b[0..3],b[4..7]]}.flatten   
	protegido = bits4.map{|b| proteger b.chars.map{|c|c.to_i}}
	info = protegido.map{|b| [b[2],b[4],b[5],b[6]]}
	tiras = protegido.map{|b| [b[0],b[1],b[3],b[7]]}
	raid = []
	for n in 0..(info.length-1)
		raid[n] = info[n] << tiras[n]
	end

	return raid
end

def raid2frase raid
	hamming_complete = raid.map{|f|[f[4][0],f[4][1],f[0],f[4][2],f[1],f[2],f[3],f[4][3]]}
	correto = hamming_complete.map{|c| corrigir c}
	info = correto.map{|f|[f[2],f[4],f[5],f[6]]}
	chars= []
	info.each_slice(2){|a,b| chars << ( a.concat b)}
	return chars.map{|c|c.join.to_i(2).chr}.join
end

puts "Digite uma frase para armazenar em raid 4"
raid = frase2raid gets.chop
raid.each{|f|p f}
puts "Escolha uma coluna para remover"
col = gets.chop.to_i-1
raid.each{|f| f[col]=0}
raid.each{|f|p f}
puts "Recuperando dados"
raid.each{|f| b = proteger f;f[4] = [b[0],b[1],b[3],b[7]]} if col==4
p raid2frase raid
