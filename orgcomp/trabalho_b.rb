# Programa deve ter a capacidade de uma vez definidos um alfabeto para transmissão de 4 bits de
# informação (todas as possibilidades possíveis), fazer o código a ser transmitido com as
# redundâncias para detecção e recuperação de um bit, além de um bit extra para teste de paridade
# ímpar. Após isso deve ser possível escolher uma das palavras código e selecionar um bit para ser
# invertido (simulação de erro na transmissão). Posteriormente deve ser simulado o receptor, que irá
# verificar a paridade e dizer se a recepção foi correta ou não, no caso de incorreção deve ter a
# capacidade de recuperar a informação correta. Tudo deve ser implementado e calculado utilizando o
# algoritmo de Hamming e os conceitos matemáticos associados a bits, paridade e operações lógicas
# (3.2 pontos).

require "colorize"


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

puts "Insira sua palavra de 4 bits"
palavra_inicial = gets.chop.chars.map{|c|c.to_i}

puts "Sua palara com o os bits de redundância e #{proteger(palavra_inicial).join}"

puts "Insira a palavra recebida"
palavra = gets.chop.chars.map{|c|c.to_i}

def pinta_palavra palavra, pos, cor
	palavra_com_cor = palavra.dup
	palavra_com_cor[pos]=palavra[pos].to_s.send cor
	return  palavra_com_cor.join
end

if erro palavra
	posicao_erro = (erro(palavra)+8)%8
	puts "Seu erro foi na posição #{posicao_erro+1}"
	puts pinta_palavra palavra, posicao_erro, "red"
	puts " "*posicao_erro+"^"
	puts "Sua palavra correra é #{corrigir(palavra).join}"
	puts pinta_palavra palavra, posicao_erro, "green"
else
	puts "Sua palavra está correta"
end
