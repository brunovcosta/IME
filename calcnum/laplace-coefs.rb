def coefs m,n, right, up, left, bottom
	matrix = []
	for i in 1..m*n do
		matrix.push []
		for j in 1..m*n do
			matrix.last.push 0	
		end
	end
	for i in 0..m*n do
		matrix[i][i] = 4
		if i > 0 then
			matrix[i][i-1] = -1
		end
		if i+1 < m*n then
			matrix[i][i+1] = -1
		end
		if i > n then
			matrix[i][i-n] = -1
		end
		if i+n < m*n then
			matrix[i][i+n] = -1
		end
	end
end
