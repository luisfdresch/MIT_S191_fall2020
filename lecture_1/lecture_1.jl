### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 092ef052-fb87-11ea-2b57-4fd14c7ba27b
begin
	using Images
	philip = load("philip.jpg")
end

# ╔═╡ 9a389e38-fc31-11ea-06f9-8d469fa9cb5d
using PlutoUI

# ╔═╡ b3604c8e-fb83-11ea-1a7d-f30e798dd460
md""" # Module I: Images"""

# ╔═╡ 1bbc0f18-fb87-11ea-3686-ffd06fbe458c
md"""
[Video  ](https://www.youtube.com/watch?v=DGojI9xcCfg)
"""

# ╔═╡ 6960db3e-fb84-11ea-38d6-d34ed0a6da83
url = "https://i.imgur.com/VGPeJ6s.jpg"

# ╔═╡ 19b371ae-fb85-11ea-1563-a71ae5745225
download(url, "philip.jpg")

# ╔═╡ 2a4d18ce-fb87-11ea-1080-f7a5190c713c
typeof(philip)

# ╔═╡ 36196bc6-fb87-11ea-2ed5-bfc5b96dc9b6
RGBX(0.9, 1, 0.1)

# ╔═╡ 419f7508-fb8c-11ea-0034-1989b3b6a3a2
size(philip)

# ╔═╡ 63fe344c-fc2f-11ea-374d-a52e43243303
head = philip[1800:end-400, 600:2000]

# ╔═╡ 5ca1a818-fc30-11ea-0cc7-e57f85a8cb4e


# ╔═╡ 5633dbcc-fc30-11ea-1cc1-cdeaa406cb2d


# ╔═╡ af53998c-fc2f-11ea-3c21-15df0089ad43
head

# ╔═╡ b53066f0-fc2f-11ea-3eaf-73d7d9fa0966
[head head]

# ╔═╡ c1d862cc-fc2f-11ea-215f-73e282341a6c
size([head head])

# ╔═╡ caf4da48-fc2f-11ea-1b0d-d5ea03d0a82f
[head reverse(head, dims=2)
reverse(head, dims=1) reverse(reverse(head, dims=2), dims=1)]

# ╔═╡ 85721f6c-fc2f-11ea-2729-97cea4765fc0
new_phil = copy(head)

# ╔═╡ 33c2abb8-fc30-11ea-1778-fd698e29eb0c
for i in 1:100
	for j in 1:300
		new_phil[i,j] = RGB(1, 0, 0)
	end
end

# ╔═╡ 71068b5c-fc30-11ea-1689-55a56eb26021
new_phil

# ╔═╡ 74fac232-fc30-11ea-1ae0-777c78f32c6d
begin
	new_phil2 = copy(new_phil)
	new_phil2[100:200, 1:100] .= RGB(1,1,0)
	new_phil2
end

# ╔═╡ cc70a23e-fc30-11ea-3e96-63ec5732694a
function redify(color)
	return RGB(color.r, 0, 0)
end

# ╔═╡ 2effda6e-fc31-11ea-338f-693733c8be90
redify.(philip)

# ╔═╡ 64974298-fc31-11ea-331b-c512f74668df
function decimate(array, step)
	return array[1:step:end, 1:step:end]
end

# ╔═╡ 496e44e4-fc31-11ea-07f6-65462f6c19be
begin
	poor_phil = decimate(new_phil, 5)
	
	poor_phil
end

# ╔═╡ 2816cfea-fc32-11ea-020d-cf59995173b4
size(poor_phil)

# ╔═╡ 628f24aa-fc33-11ea-0134-2df7f915f612
md"""
# Adding interaction
"""

# ╔═╡ 04ebdcee-fc33-11ea-115c-4fd8daf2da61
@bind decimate_factor Slider(1:100, show_value = true)

# ╔═╡ 327f7850-fc33-11ea-0f7f-212bc8f3be36
decimate(head, decimate_factor)

# ╔═╡ b8208ed0-fc34-11ea-1fc5-27f155020570
md"""
# A concrete first taste at abstraction

[Video 2](https://www.youtube.com/watch?v=foN1_hAGfNg)
"""

# ╔═╡ e94d88a2-fc34-11ea-0d61-11d78288ab76
keep_track = [typeof(1), typeof(1.0), typeof("one"), typeof(1//1), typeof([1 2 ;3 4])]

# ╔═╡ 36bdf5f6-fc36-11ea-2621-0b7b7ae33fc4


# ╔═╡ ffb18dda-fc34-11ea-07c5-b30db40ccf26
typeof(keep_track)

# ╔═╡ 2259dd24-fc35-11ea-0481-8b0f96cf4f30
cute_one = load(download("https://gallery.yopriceville.com/var/resizes/Free-Clipart-Pictures/Decorative-Numbers/Cute_Number_One_PNG_Clipart_Image.png?m=1507172102"))

# ╔═╡ d3bd595c-fc34-11ea-32c5-b953f3f8f13c
element = cute_one

# ╔═╡ db68ade6-fc34-11ea-2bba-5d907419b804
fill(element, 3,4)

# ╔═╡ e31bf84a-fc34-11ea-3d33-99ac7d079be4
typeof(element)

# ╔═╡ ee708aa2-fc35-11ea-08fe-01b057f52894
md"""
# Array Basics

[Video 3](https://www.youtube.com/watch?v=CwDI-YOjWhc)
"""

# ╔═╡ 8898df6c-fc36-11ea-1c7b-7dde97cb0ef6
v = [1, 2, 3, 4] #vector (Array{Int64, 1})

# ╔═╡ 930f3fc0-fc36-11ea-3611-6db670a5fd94
size(v)

# ╔═╡ 967e0af8-fc36-11ea-0276-374fcef13af8
w = [1 2 3
	4 5 6]

# ╔═╡ cff617c6-fc36-11ea-0055-157b8c62a24d
w[:, 2:3]

# ╔═╡ de471f0a-fc36-11ea-0de2-4b4c79288450
A1 = rand(1:9, 3, 4)

# ╔═╡ e9a692cc-fc36-11ea-3383-cbbd0fad75f4
A2 = string.(rand("0123456789abcdef", 3, 4))

# ╔═╡ 2a9ebcce-fc38-11ea-2a25-652e373aebd8
colors = distinguishable_colors(6)

# ╔═╡ 0b6cca56-fc38-11ea-1c47-0bc7c7afa71d
A3 = rand(colors, 10,10)

# ╔═╡ 4731e71a-fc38-11ea-29c9-2daceb67599d
begin
	C = fill(A3, 5,5)
	C[1,1] = cute_one
	C
end

# ╔═╡ 7f498202-fc38-11ea-0473-f5d8dafc64c9
D = [i * j for i=1:5, j=1:5]

# ╔═╡ b0120e0e-fc38-11ea-33b9-599eef2c7054
[C C]

# ╔═╡ Cell order:
# ╟─b3604c8e-fb83-11ea-1a7d-f30e798dd460
# ╟─1bbc0f18-fb87-11ea-3686-ffd06fbe458c
# ╠═6960db3e-fb84-11ea-38d6-d34ed0a6da83
# ╠═19b371ae-fb85-11ea-1563-a71ae5745225
# ╠═092ef052-fb87-11ea-2b57-4fd14c7ba27b
# ╠═2a4d18ce-fb87-11ea-1080-f7a5190c713c
# ╠═36196bc6-fb87-11ea-2ed5-bfc5b96dc9b6
# ╠═419f7508-fb8c-11ea-0034-1989b3b6a3a2
# ╠═63fe344c-fc2f-11ea-374d-a52e43243303
# ╠═5ca1a818-fc30-11ea-0cc7-e57f85a8cb4e
# ╠═5633dbcc-fc30-11ea-1cc1-cdeaa406cb2d
# ╠═af53998c-fc2f-11ea-3c21-15df0089ad43
# ╠═b53066f0-fc2f-11ea-3eaf-73d7d9fa0966
# ╠═c1d862cc-fc2f-11ea-215f-73e282341a6c
# ╠═caf4da48-fc2f-11ea-1b0d-d5ea03d0a82f
# ╠═85721f6c-fc2f-11ea-2729-97cea4765fc0
# ╠═33c2abb8-fc30-11ea-1778-fd698e29eb0c
# ╠═71068b5c-fc30-11ea-1689-55a56eb26021
# ╠═74fac232-fc30-11ea-1ae0-777c78f32c6d
# ╠═cc70a23e-fc30-11ea-3e96-63ec5732694a
# ╠═2effda6e-fc31-11ea-338f-693733c8be90
# ╠═64974298-fc31-11ea-331b-c512f74668df
# ╠═496e44e4-fc31-11ea-07f6-65462f6c19be
# ╠═2816cfea-fc32-11ea-020d-cf59995173b4
# ╟─628f24aa-fc33-11ea-0134-2df7f915f612
# ╠═9a389e38-fc31-11ea-06f9-8d469fa9cb5d
# ╠═04ebdcee-fc33-11ea-115c-4fd8daf2da61
# ╠═327f7850-fc33-11ea-0f7f-212bc8f3be36
# ╟─b8208ed0-fc34-11ea-1fc5-27f155020570
# ╠═d3bd595c-fc34-11ea-32c5-b953f3f8f13c
# ╠═db68ade6-fc34-11ea-2bba-5d907419b804
# ╠═e31bf84a-fc34-11ea-3d33-99ac7d079be4
# ╠═e94d88a2-fc34-11ea-0d61-11d78288ab76
# ╠═36bdf5f6-fc36-11ea-2621-0b7b7ae33fc4
# ╠═ffb18dda-fc34-11ea-07c5-b30db40ccf26
# ╠═2259dd24-fc35-11ea-0481-8b0f96cf4f30
# ╟─ee708aa2-fc35-11ea-08fe-01b057f52894
# ╠═8898df6c-fc36-11ea-1c7b-7dde97cb0ef6
# ╠═930f3fc0-fc36-11ea-3611-6db670a5fd94
# ╠═967e0af8-fc36-11ea-0276-374fcef13af8
# ╠═cff617c6-fc36-11ea-0055-157b8c62a24d
# ╠═de471f0a-fc36-11ea-0de2-4b4c79288450
# ╠═e9a692cc-fc36-11ea-3383-cbbd0fad75f4
# ╠═2a9ebcce-fc38-11ea-2a25-652e373aebd8
# ╠═0b6cca56-fc38-11ea-1c47-0bc7c7afa71d
# ╠═4731e71a-fc38-11ea-29c9-2daceb67599d
# ╠═7f498202-fc38-11ea-0473-f5d8dafc64c9
# ╠═b0120e0e-fc38-11ea-33b9-599eef2c7054
