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

--[[
Table: jCats
Function: cCat(jobList)

Purpose:
	jCats [table]
		contains all job categories you want.

	cCat(jobList) [function]
		1. cCat parses table (jobList) and creates every job from.
		2. cCat able to create any sort of category even it's not created or just missing.
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

--[[
Table: cList

Purpose:
	It just contains every color for example jobslists. cE - complexExample color, eE - easyExample color, etc.

	Feel free to edit this or don't even use.
--]]
local cList = {
	cE = Color(0,0,180,255),
	eE = Color(0,180,0,255),
	bE = Color(255,0,0,255),
}

--[[
Table: easyExample

Purpose:
	Create job for every rank from current organisation.
--]]
local easyExample = { 
	name = "", -- That's name of our organisation. If you're wanna create jobs without any tags in scoreboard, feel free to leave it empty.
	command = "easyEx", -- That's our command for org. It will be easyEx1 for Easy Citizen, easyEx2 for Male Citizen, etc.
	color = cList.eE, -- Color for our jobs. Feel free to simplify it and use Color(r,g,b,alpha).
	models = { -- These models will be applied for every job we have in ranklist. If you want to use each model for any job you want - check complexExample.
		"models/Humans/Group01/Male_01.mdl",
		"models/Humans/Group01/Male_02.mdl",
		"models/Humans/Group01/Male_03.mdl", 
	},
	weapons = { -- Same as models. Every rank will have these weapons.
		"weapon_fists",
		"weapon_physgun"
	},
	ranks = { -- That's our jobs. If 'name' wasn't empty, then it will be shown as 'Easy Citizen - [%name%]', else just 'Easy Citizen'.
		"Easy Citizen", "Male Citizen", "Just yet another one citizen job", , "Fourth job", "5", "o_O", "Call me new fucking job!"
	},
	category = "[Example: easy jobs]", -- As is. That's category.
	salary = 10, -- Salary multiplier. DefaultSalary + (salary*rankpos).
	cvar = "t" -- Cvars are here to make your joblist more complex and personal. Check complexExample or documentation for more information.
}
--[[
Table: complexExample

Purpose:
	This example was created to show you how complex table you create.
--]]
local complexExample = {
	name = "[Complex Example]", -- Will be shown in scoreboard after '%jobname% - [Complex Example]'
	command = "complexExample", -- same as easy.
	color = cList.cE, -- same as easy.
	models = { -- Same as easy, but it will we have value 'm' in our cvar key below. So:
		"models/Humans/Group01/Male_01.mdl", -- Will be applied for our first job. That's 'Glock-man'
		"models/Humans/Group01/Male_04.mdl", -- Will be applied for our second job. That's 'AK-man'
		"models/Barney.mdl", -- Will be applied for our third job. That's 'Fist-man'
	},
	weapons = { -- Same as models. Our cvar key contain value 'w', so:
		"weapon_physgun", -- Will be applied for our first job. 
		"weapon_physgun", -- Will be applied for our second job.
		"weapon_fists" -- Third job.
	},
	ranks = {
		"Glock-man", "AK-man", "Fist-man" -- joblist. Please, sort them from LOWEST to HIGHEST rank in organisation, because salary scaling from lowest to highest.
	},
	stats = {
		{50, 50, 50, 50}, -- Glock man's stats, cuz it's first.
		{100, 100, 100, 100}, -- AK-man's stats, cuz it's second.
		{450, 450, 450, 450} -- Fist-man's stats, cuz it's third.
	},
	category = "[Example: complex jobs]", -- Category. I didn't set it before, so this category will be created automatically.
	salary = 100, -- Salary multiplier. Same as easy.
	cvar = "mwst" -- m is for models, w for weapons, s for stats and t is for nulled name. A little bit shitty, but I'll try to code later.
}
--[[
Function: createJob(c)
	
Purpose:
	Create jobs for table from Table (c).
--]]
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
--[[
Function: initJobs(tj)

Purpose:
	Initialise jobs for every organisation table from(tj).
--]]
local function initJobs(tj)
	if istable(tj) then
		for k, v in pairs(tj) do
			createJob(v)
		end
	else
		print('[jobs.lua] SOMETHING WAS BROKEN. CHECK YOUR JOBLIST.')
		return
	end
end
--[[
Table: jTables

Purpose:
	Contain every job table and initialises in initJobs(jTables) with categories via cCat(jCats).
--]]
local jTables = {
	easyExample, complexExample
}

cCat(jCats)
initJobs(jTables)