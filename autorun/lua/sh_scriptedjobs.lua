--[[
	scriptedjobs.lua
	Author: r3t4rd
	git: https://github.com/r3t4rd/ScriptedJobs

	Purpose:
		Attempt to simplify creating jobs for really big servers and their custom jobs.lua file.

	Example:
	```lua
		local gangster = {
			name = "[Gangster]",
			command = "GANGSTA",
			color = Color(255,255,255,255),
			models = { "models/Humans/Group01/Male_01.mdl" },
			weapons = { "weapon_physgun" },
			ranks = { "Newbie", "Active", "Raider", "Leader" },
			category = "Gangsters",
			salary = 100
		}
		createJob(gangster)
	```

	Creates 4 jobs (Newbie - [Gangster], Active - [Gangster], Raider - [Gangster], Leader - [Gangster]) in category "Gangsters".
--]]

local jCats = {
	"[Example: easy jobs]",
	"[Example: fake job list]"
}
local function cCat(jobList)
	local a = jobList
	if istable(jobList) then
		local c = table.Count(a)
		print('[cats.lua] cat list contains ' .. c .. ' cats.')
		for n = 1, c do
			DarkRP.createCategory{
				name = a[n],
				categorises = "jobs",
				startExpanded = true,
				color = Color(255,255,255,255),
				canSee = function(ply) return true end,
				sortOrder = n
			}
			print('[cats.lua] Successfully created category for [' .. n .. '] - ' .. a[n])
		end
	else
		if table.HasValue(jCats, a) then return nil end
		DarkRP.createCategory{
			name = a,
			categorises = "jobs",
			startExpanded = true,
			color = Color(255,0,0,255),
			canSee = function(ply) return true end,
			sortOrder = 0
		}
		print('[cats.lua] isnt valid or dosnt exsist. Created manually cat for [' .. jobList .. ']')
	end
end

local cList = {
	cE = Color(0,0,180,255),
	eE = Color(0,180,0,255),
	bE = Color(255,0,0,255),
}
local easyExample = {
	name = "",
	command = "easyEx",
	color = cList.eE,
	models = { 
		"models/Humans/Group01/Male_01.mdl",
		"models/Humans/Group01/Male_02.mdl",
		"models/Humans/Group01/Male_03.mdl", 
	},
	weapons = {
		"weapon_fists",
		"weapon_physgun"
	},
	ranks = {
		"Easy Citizen", "Male Citizen", "Just yet another one citizen job"
	},
	category = "[Example: easy jobs]",
	salary = 10,
	cvar = "t"
}
local complexExample = {
	name = "[Complex Example]",
	command = "complexExample",
	color = cList.cE,
	models = {
		"models/Humans/Group01/Male_01.mdl",
		"models/Humans/Group01/Male_04.mdl",
		"models/Barney.mdl",
	},
	weapons = {
		"weapon_physgun",
		"weapon_physgun",
		"weapon_fists"
	},
	ranks = {
		"Glock-man", "AK-man", "Fist-man"
	},
	stats = {
		{50, 50, 50, 50},
		{100, 100, 100, 100},
		{450, 450, 450, 450}
	},
	category = "[Example: complex jobs]",
	salary = 100,
	cvar = "mwst"
}
local function createJob(c)
	local na, de, cn, co, mo, we, ra, ca, st, sa, ad, vt, lic, cc, cwm, cww, cws, cvar = c.name, c.description, c.command, c.color, c.models, c.weapons, c.ranks, c.category, c.stats, c.salary, c.admin, c.vote, c.license, table.Count(c.ranks), nil, nil, nil, c.cvar or nil
	print('[jobs.lua] ' .. cn .. ' contains ' .. cc .. ' jobs.')
	for n = 1, cc do
		if ra == nil or n > cc then return end
		local tn = "TEAM_" .. string.upper(cn) .. '_' .. ra[n]
		local ti = ra[n] .. ' - ' .. na[n]
		if cvar and string.match(cvar, 'm') then if mo == istable(mo[n]) then cwm = mo[n] else cwm = { mo[n] } end end
		if cvar and string.match(cvar, 'w') then if we == istable(we[n]) then cww = we[n] else cww = { we[n] } end end
		if cvar and string.match(cvar, 's') then if st == istable(st[n]) then cws = st[n] else cws = { st[n] } end end
		if cvar and string.match(cvar, 't') then ti = ra[n] end
		tn = DarkRP.createJob(ti, {
			color = co or Color('255,0,0,255'),
			model = cwm or mo,
			description = de or [[]],
			weapons = cww or we,
			max = c.max or 0,
			command = cn .. n or ti .. n or 'fakecmd' .. n,
			salary = GAMEMODE.Config.normalsalary + (sa*n),
			admin = ad or 0,
			vote = vt or false,
			hasLicense = lic or false,
			candemote = dem or false,
			category = cCat(ca) or ca or 'Other',
			PlayerSpawn = function(ply)
				-- stats
				-- finishme
			end
		})
		print('[jobs.lua] Successfully created job for [' .. tn .. '] - ' .. ti)
	end
end
local function initJobs(tj)
	print('shit')
	if istable(tj) then
		print('Its table')
		for k, v in pairs(tj) do
			print('shitshit')
			createJob(v)
		end
	else
		print('broken')
		return
	end
end
local jTables = {
	easyExample, complexExample
}

cCat(jCats)
initJobs(jTables)