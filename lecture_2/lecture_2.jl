### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 831180f6-fc51-11ea-18f7-1723d90016f8
begin
	using Statistics
	using Images
	using FFTW
	using Plots
	using DSP
	using ImageFiltering
	using PlutoUI
end

# ╔═╡ 9874d7d2-fc46-11ea-3add-c7d2823fcf5c
md"""
# Convolutions in image processing
"""

# ╔═╡ db710c46-fc4f-11ea-1547-bd629f6cc736
import Pkg; Pkg.activate("/home/luisfdresch/Documents/2020.2/MIT_S191_fall2020/")

# ╔═╡ a3d9f7b6-fc54-11ea-2afd-576392f3c8bf
begin 
	image = load(download("https://super.abril.com.br/wp-content/uploads/2020/09/04-09_gato_SITE.jpg?quality=100"))[:,1:end-250]
	
end

# ╔═╡ fcc2a086-fc55-11ea-1340-034436164b99
kernel = Kernel.gaussian((1,1))

# ╔═╡ 2cb7a570-fc56-11ea-3a8f-db4b9fedbd5c


# ╔═╡ 0ebf9576-fc56-11ea-2383-39c994a0a2c1
convolve(image, kernel)

# ╔═╡ Cell order:
# ╟─9874d7d2-fc46-11ea-3add-c7d2823fcf5c
# ╠═db710c46-fc4f-11ea-1547-bd629f6cc736
# ╠═831180f6-fc51-11ea-18f7-1723d90016f8
# ╠═a3d9f7b6-fc54-11ea-2afd-576392f3c8bf
# ╠═fcc2a086-fc55-11ea-1340-034436164b99
# ╠═2cb7a570-fc56-11ea-3a8f-db4b9fedbd5c
# ╠═0ebf9576-fc56-11ea-2383-39c994a0a2c1
