### A Pluto.jl notebook ###
# v0.12.3

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

# ╔═╡ f376e058-0a40-11eb-3869-d5b111dedac0
begin
	using Pkg
	Pkg.activate("/home/luisfdresch/Documents/2020.2/MIT_S191_fall2020")
	using CSV
	using DataFrames 
	using Shapefile 
	using ZipFile 
	using PlutoUI 
	using LsqFit
	using Plots
end

# ╔═╡ 5517deb0-0a46-11eb-0357-39b934c94054
using Dates

# ╔═╡ 31394c62-0a4a-11eb-1d98-33c4b992bb16
using Statistics

# ╔═╡ 93c3831a-0a3f-11eb-3538-0d991eb8a500
md""" # Epidemic propagation

## Dataframes, data wrangling, data visualisation exercise, lestquares model fit
"""

# ╔═╡ ceb69d18-0b13-11eb-0217-fb47e9b26ffa
md" ### Downloading data"

# ╔═╡ b8240e16-0a3f-11eb-3ab5-2f9f349bf67b
url = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"

# ╔═╡ 12a37d36-0a40-11eb-24c9-fb065442dd5f
download(url, "covid_data.csv")

# ╔═╡ f22983fc-0b13-11eb-02c2-e9822acbf026
md" ### Setting up environment and packages"

# ╔═╡ f893e700-0b13-11eb-14ab-b58db505b133
md" Loading csv file"

# ╔═╡ 1259d912-0a41-11eb-24cd-539b4a36e542
csv_data = CSV.File("covid_data.csv");

# ╔═╡ 04ab19ee-0b14-11eb-2eee-9f53b47ffa27
md" Creating Dataframe"

# ╔═╡ 1dcb9d7c-0a42-11eb-08b2-535ca06b96f5
df = DataFrame(csv_data);

# ╔═╡ ed22c72a-0a43-11eb-01f7-f3b366e37cbc
md" "

# ╔═╡ 685162be-0b14-11eb-164d-c3a3f3a94637
md" ### Data visualization"

# ╔═╡ 10bfddd4-0b14-11eb-207a-bbd8d68faed8
md" Select Country for analysis"

# ╔═╡ 7b998e22-0a43-11eb-2f31-6f75f0d7a919
begin
	@bind country Select(unique(df["Country/Region"]))
	
end

# ╔═╡ 434b2214-0a44-11eb-330f-2d872c620c69
country_row = findfirst(df["Country/Region"].==country)

# ╔═╡ d15307cc-0a42-11eb-2395-ffa54e21ff09
country_cum_cases = Vector(df[country_row, 5:end])

# ╔═╡ 9a903032-0a44-11eb-144f-3968fd0c7aa0
scatter(country_cum_cases, m=:o, alpha=0.5, ms=2, xlabel = "day", ylabel= "cumulative cases", label = country, leg=:topleft)

# ╔═╡ 18689e06-0b15-11eb-023d-99bfc8e85129
md" Daily cases visualization, the diff function calculates the difference between consecutive values of a vector"

# ╔═╡ f0faa61c-0a44-11eb-1cf8-198cf7b51017
country_daily_cases = diff(country_cum_cases)

# ╔═╡ 9c3efc96-0a45-11eb-3fdd-01beb89f05f6
plot(country_daily_cases, m=:d, ms=2, alpha=0.8, ylabel = "Daily cases", xlabel = "days", leg = false, title=country)

# ╔═╡ 01ea1010-0b15-11eb-11e9-b98d6c31c40d
md" Changing xticks to Date type"

# ╔═╡ cafaae18-0a45-11eb-24ac-27a7b39984d0
date_strings = names(df)[5:end]

# ╔═╡ 6b97746e-0a46-11eb-3f1c-9174927a7e08
date_strings[1]

# ╔═╡ 590c8710-0a46-11eb-0ec6-4d332b7b59ac
dates = parse.(Date, date_strings, Dates.DateFormat("m/d/Y")) .+Year(2000)

# ╔═╡ ec6e4bc4-0a46-11eb-10a1-2f5105253708
begin
	plot(dates[2:end], country_daily_cases, xrotation=45 , label = country, m=:o, alpha = 0.6, ms=3)
	xlabel!("Dates")
	ylabel!("Daily cases")
	title!("$(country) daily cases")
end

# ╔═╡ 79ceed84-0a49-11eb-1fdb-b90fc7cf35d6
moving_average(data, period) = [mean(data[i-period+1:i]) for i = period:length(data)]

# ╔═╡ c7e6a6ce-0a4e-11eb-23dd-15a50c5db3f3
begin
	md"""
	Start Date   \ End Date \Moving average period
	
	$(@bind d1 PlutoUI.DateField(default = Date(2020,01,01) ))
	$(@bind d2 PlutoUI.DateField(default = today()))
	
	$(@bind period Slider(1:20, show_value = true))
	
	"""
end

# ╔═╡ 4e1e475c-0a49-11eb-2a7d-4951f6898c81
begin
	plot(dates[2:end], country_daily_cases, xrotation=45 , label = "$country daily cases")
	scatter!(dates[2+period-1:end], moving_average(country_daily_cases, period), xrotation=45, label="$country cases moving average", leg=:topleft, alpha=0.9, ms=3, m=:o )
	title!(" $period days moving average, from $(Date(d1)) to $(Date(d2))")
	xlims!(Dates.value(Date(d1)), Dates.value(Date(d2)))
end


# ╔═╡ 54fac966-0b15-11eb-3546-73aae2db82bb
md" Using semilog scale"

# ╔═╡ fb7f4610-0a55-11eb-301b-e781b6c6ee9e
begin
	scatter(replace(country_daily_cases, 0=> NaN), yscale=:log10)
	#xlims!(Dates.value(Date(2020,03,01)), Dates.value(Date(2020,03,25)))
	xlims!(38,62)
end

# ╔═╡ ba9a24ce-0b15-11eb-0e63-e1181c9ed448
md" ### Fitting a model to least squares method"

# ╔═╡ 3c923144-0a56-11eb-2160-692444e900dc
model(x, p) = p[1].* exp.(p[2].*x)

# ╔═╡ 127ebd0a-0a56-11eb-3396-1b10633b4f70
begin
	p0 = [0.5, 0.5]
	xdata = 40:59
	ydata = country_daily_cases[xdata]
	
	fit = curve_fit(model, xdata, ydata, p0)
end;

# ╔═╡ cf6d482c-0a57-11eb-0dcf-3901630f5df2
parameters = coef(fit)

# ╔═╡ 47149a22-0b15-11eb-1ebc-f550d4912747


# ╔═╡ 368eb252-0a58-11eb-2d61-f9250a362311
begin
	scatter(replace(country_daily_cases, 0 => NaN), yscale=:log10, xlims=(25,150), leg=false)
	plot!(xdata, model(xdata, parameters), lw =3, ls=:dash, alpha=1)
end

# ╔═╡ d5fa9c06-0a59-11eb-2a7d-3dece0935a77
md" ## Adding map cases viualization"

# ╔═╡ c621922a-0b13-11eb-2acd-a17387e78b7a
# TODO Add map cases

# ╔═╡ Cell order:
# ╟─93c3831a-0a3f-11eb-3538-0d991eb8a500
# ╟─ceb69d18-0b13-11eb-0217-fb47e9b26ffa
# ╟─b8240e16-0a3f-11eb-3ab5-2f9f349bf67b
# ╠═12a37d36-0a40-11eb-24c9-fb065442dd5f
# ╟─f22983fc-0b13-11eb-02c2-e9822acbf026
# ╠═f376e058-0a40-11eb-3869-d5b111dedac0
# ╟─f893e700-0b13-11eb-14ab-b58db505b133
# ╠═1259d912-0a41-11eb-24cd-539b4a36e542
# ╟─04ab19ee-0b14-11eb-2eee-9f53b47ffa27
# ╠═1dcb9d7c-0a42-11eb-08b2-535ca06b96f5
# ╟─ed22c72a-0a43-11eb-01f7-f3b366e37cbc
# ╠═685162be-0b14-11eb-164d-c3a3f3a94637
# ╟─10bfddd4-0b14-11eb-207a-bbd8d68faed8
# ╟─7b998e22-0a43-11eb-2f31-6f75f0d7a919
# ╟─434b2214-0a44-11eb-330f-2d872c620c69
# ╠═d15307cc-0a42-11eb-2395-ffa54e21ff09
# ╠═9a903032-0a44-11eb-144f-3968fd0c7aa0
# ╟─18689e06-0b15-11eb-023d-99bfc8e85129
# ╠═f0faa61c-0a44-11eb-1cf8-198cf7b51017
# ╠═9c3efc96-0a45-11eb-3fdd-01beb89f05f6
# ╟─01ea1010-0b15-11eb-11e9-b98d6c31c40d
# ╠═cafaae18-0a45-11eb-24ac-27a7b39984d0
# ╠═6b97746e-0a46-11eb-3f1c-9174927a7e08
# ╠═5517deb0-0a46-11eb-0357-39b934c94054
# ╠═590c8710-0a46-11eb-0ec6-4d332b7b59ac
# ╟─ec6e4bc4-0a46-11eb-10a1-2f5105253708
# ╟─31394c62-0a4a-11eb-1d98-33c4b992bb16
# ╟─79ceed84-0a49-11eb-1fdb-b90fc7cf35d6
# ╟─c7e6a6ce-0a4e-11eb-23dd-15a50c5db3f3
# ╟─4e1e475c-0a49-11eb-2a7d-4951f6898c81
# ╟─54fac966-0b15-11eb-3546-73aae2db82bb
# ╠═fb7f4610-0a55-11eb-301b-e781b6c6ee9e
# ╟─ba9a24ce-0b15-11eb-0e63-e1181c9ed448
# ╠═3c923144-0a56-11eb-2160-692444e900dc
# ╠═127ebd0a-0a56-11eb-3396-1b10633b4f70
# ╠═cf6d482c-0a57-11eb-0dcf-3901630f5df2
# ╠═47149a22-0b15-11eb-1ebc-f550d4912747
# ╠═368eb252-0a58-11eb-2d61-f9250a362311
# ╟─d5fa9c06-0a59-11eb-2a7d-3dece0935a77
# ╠═c621922a-0b13-11eb-2acd-a17387e78b7a
