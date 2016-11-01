require 'matrix'
class Matrix
	  def []=(i, j, x)
	      @rows[i][j] = x
    end
end

class Vector
	  def []=(i, x)
	      @elements[i] = x
    end
end

#resolver Ax=b
def gauss_seidel a,x, b, tol, max_iterations
	n = x.size
	c=Matrix.zero n,n
	g=Matrix.zero(n,1).column(0)
	for i in 0..(n-1) do
		g[i] = b[i] / a[i,i]
		for j in 0..(n-1) do
			if i!=j then
				c[i,j] = -a[i,j]/a[i,i]
			end
		end
	end
	i = 0
	max = 100
	while max.abs > tol and i<max_iterations do
		xtemp = g
		for j in 0..(n-1) do
			for k in 0..(n-1) do
				if k>j then
					xtemp[j] = xtemp[j] + c[j,k]*x[k]
				else
					xtemp[j] = xtemp[j] + c[j,k]*xtemp[k]
				end
			end
		end
		max =0
		for j in 0..(n-1) do
			if (xtemp[j] - x[j]).abs > max.abs then
				max = xtemp[j] - x[j]
			end
		end
		x = xtemp
		i+=1
		return x
	end
end
a = Matrix[
	[1,1,1],
	[1,2,3],
	[1,4,2]
]
b = Matrix[[3,6,7]]
x0=Matrix[[1,1,1]]

puts gauss_seidel(a, x0.row(0), b.row(0), 0.0001, 10000000)

