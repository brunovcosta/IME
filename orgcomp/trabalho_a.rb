class String
	def is_i?
		/\A[-+]?\d+\z/ === self
	end
end

class Integer
  def to_base(base=10)
    return [0] if zero?
    raise ArgumentError, 'base must be greater than zero' unless base > 0
    num = abs
    return [1] * num if base == 1
    [].tap do |digits|
      while num > 0
        digits.unshift num % base
        num /= base
      end
    end
  end
end

def big_writer data
	memoria=[]
	for palavra in data
		palavra.concat("\0") unless palavra.is_i?
		while palavra && palavra.size!=0
			if palavra.is_i?
				palavra=palavra.to_i.to_base(256)
				memoria << [0,0,0,0].concat(palavra).last(4)
				palavra = nil 
			else
				memoria << (palavra[0..3].chars.concat([0,0,0,0]))[0..3]
				palavra = palavra[4..-1]
			end
		end
	end
	return memoria  
end

def little_writer data
	memoria=[]
	for palavra in data
		palavra.concat("\0") unless palavra.is_i?
		while palavra && palavra.size!=0
			if palavra.is_i?
				palavra=palavra.to_i.to_base(256)
				memoria << [0,0,0,0].concat(palavra).last(4)
				palavra = nil 
			else
				memoria << ([0,0,0,0].concat(palavra[0..3].reverse.chars)).last(4)
				palavra = palavra[4..-1]
			end
		end
	end
	return memoria  
end

def big_reader data
	word = ""
	for array in data
		if array.any?{|e| e.is_a? String}
			for letra in array
				if !(letra.is_a? Integer)
					word.concat(letra)
				end
			end
			if word.chars.last == "\0"
				word.concat(" ")
			end
		else
			number = 256*256*256*array[0]+256*256*array[1]+256*array[2]+array[3]
			word.concat(number.to_s)
			word.concat(" ")
		end
	
	end
	return word
end

def little_reader data
	word = ""
	temp_word=""
	for array in data
		if array.any?{|e| e.is_a? String}
			for letra in array
				if !(letra.is_a? Integer)
					temp_word.insert(0,letra)
				end
			end
			word.concat(temp_word)
			temp_word=""
			if word.chars.last == "\0"
				word.concat(" ")
			end
		else
			number = 256*256*256*array[0]+256*256*array[1]+256*array[2]+array[3]
			word.concat(number.to_s)
			word.concat(" ")
		end	
	end
	return word
end

puts "Digite uma frase: \n"
original = gets
leitura = original.chop.split

puts "Escolha uma opção de gravação:\n"
puts  "1 - Big Endian"
puts  "2 - Little Endian"
print "Opção: "

opcao1 = gets.to_i

if opcao1 == 1 then
	gravado_em = "Big Endian"
	memoria = big_writer leitura
elsif opcao1 == 2 then
	gravado_em = "Little Endian"
	memoria = little_writer leitura
end

puts "Opcao escolhida: "+gravado_em
memoria.each{|f|p f}
puts "Escolha uma opção de leitura:\n"
puts  "1 - Big Endian"
puts  "2 - Little Endian"
print "Opção: "

opcao2 = gets.to_i

if opcao2 == 1 then
	lido_em = "Big Endian"
	final = big_reader memoria
elsif opcao2 == 2 then
	lido_em = "Little Endian"
	final = little_reader memoria
end

puts "Frase Original: "+original
puts "Foi gravado em: "+gravado_em
puts "Foi lido em: "+lido_em
puts "Resultado: "+final
