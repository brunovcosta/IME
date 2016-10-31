id = {
	pQuinas = { 1, 2, 3, 4, 5, 6, 7, 8 },
	oQuinas = { 0, 0, 0, 0, 0, 0, 0, 0 },
	pMeios = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
	oMeios = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
}
-- movimento F
f = {
	pQuinas = { 1, 2, 4, 8, 5, 6, 3, 7 },
	oQuinas = { 0, 0, 1, 2, 0, 0, 2, 1 },
	pMeios = { 1, 2, 7, 11, 5, 6, 4, 8, 9, 10, 3, 12 },
	oMeios = { 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0 },
}
--TODO fazer o resto
function mul(e1, e2)
	local pQuinas = {}
	local oQuinas = {}
	for i = 1, 8 do
		pQuinas[i] = e1.pQuinas[e2.pQuinas[i]]
		oQuinas[i] = (e1.oQuinas[e2.pQuinas[i]] + e2.oQuinas[i]) % 3
	end

	local pMeios = {}
	local oMeios = {}
	for i = 1, 12 do
		pMeios[i] = e1.pMeios[e2.pMeios[i]]
		oMeios[i] = (e1.oMeios[e2.pMeios[i]] + e2.oMeios[i]) % 2
	end

	return {
		pQuinas = pQuinas,
		oQuinas = oQuinas,
		pMeios = pMeios,
		oMeios = oMeios,
	}
end
-- permuta¸c~ao <-> [0, n! - 1]
function permutacao_para_indice(permutation)
	local index = 0
	local position = 2-- position 1 is paired with factor 0 and so is skipped
	local factor = 1
	for p = table.maxn(permutation) - 3,0 do 
		local successors = 0
		for q = p + 1 ,table.maxn(permutation)-1 do
			if (permutation[p] > permutation[q]) then
				successors=successors+1
			end
		end
		index = index+(successors * factor)
		factor = factor*position
		position=position+1
	end
	return index
end
function indice_para_permutacao(i, n)
end

-- orienta¸c~ao <-> [0, b^n - 1]
function orientacao_para_indice(o, b)
	local retVal = 0
	for i=1,table.maxn(o) do
		retVal = retVal+o[i]*math.pow(b,i-1)
	end
	return retVal
end
function indice_para_orientacao(i, b, n)
end

-- combina¸c~ao <-> [0, C(n, k) - 1]
function combinacao_para_indice(c, k)
end
function indice_para_combinacao(i, k, n)
end

-- estado -> indices
function estado_para_indices(e)
	return {
		pQuinas = permutacao_para_indice(e.pQuinas),
		oQuinas = orientacao_para_indice(e.oQuinas, 3),
		pMeios = permutacao_para_indice(e.pMeios),
		oMeios = orientacao_para_indice(e.oMeios, 2),
	}
end

-- indices -> estado
function indices_para_estado(i)
	return {
		pQuinas = indice_para_permutacao(i.pQuinas, 8),
		oQuinas = indice_para_orientacao(i.oQuinas, 3, 8),
		pMeios = indice_para_permutacao(i.pMeios, 12),
		oMeios = indice_para_orientacao(i.oMeios, 2, 12),
	}
end

function mul2(e, movimento)
	return {
		pQuinas = pQuinasTrans[e.pQuinas][movimento],
		oQuinas = oQuinasTrans[e.oQuinas][movimento],
		pMeios = pMeiosTrans[e.pMeios][movimento],
		oMeios = oMeiosTrans[e.oMeios][movimento],
	}
end
movimentos = {
	["F"] = f
}

oQuinasTrans = {}
for i = 0, 3^8 - 1 do
	local estado = indices_para_estado({ oQuinas = i })

	oQuinasTrans[i] = {}
	for nome, mov in ipairs(movimentos) do
		oQuinasTrans[i][nome] =
		estado_para_indices(mul(estado, mov)).oQuinas
	end
end
iId = estado_para_indices(id)


quinasDist = {}
quinasDist[iId.pQuinas][iId.oQuinas] = 0

local distancia = 0
local visitados = 0
function factorial(n)
	if n>0 then
		return n*factorial(n-1);
	else
		return 1
	end
end
while visitados < factorial(8) * 3^7 do
	for i = 0, factorial(8) - 1 do
		for j = 0, 3^7 - 1 do
			if quinasDist[i][j] == distancia then
				for nome, _ in ipairs(movimentos) do
					local pProx = pQuinasTrans[i][nome]
					local oProx = oQuinasTrans[j][nome]
					if not quinasDist[pProx][oProx] then
						quinasDist[pProx][oProx] = distancia + 1
						visitados = visitados + 1
					end
				end
			end
		end
	end
end
function solucao(e)
	for i = 0, inf do
		local sol = {}
		if busca(e, i, sol) then
			return sol
		end
	end
end

function busca(e, prof, sol)
	if prof == 0 then
		return i == iId
	end

	if quinasDist[e.cQuinas][e.pQuinas][e.oQuinas] > prof or
		meios1Dist[e.cMeios1][e.pMeios1][e.oMeios1] > prof or
		meios2Dist[e.cMeios2][e.pMeios2][e.oMeios2] > prof then
		return false
	end

	for nome, _ in ipairs(movimentos) do
		table.insert(sol, nome)
		if busca(mul(e, nome), prof - 1, sol) then

			return true
		end
		table.remove(sol)
	end
end
