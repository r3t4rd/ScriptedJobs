scriptedjobs.lua
===

An extremely simple and pretty useful script if your jobs.lua counts more than 2000 lines.

**Features**

- Single file
- Very flexible code
- Quick and easy organization creation
- Supports creating your own tables and variables
- Automatically creates a category for the table if one is missing or not in use
- Job Stats customisation and scaling per rank

Example
---

```lua
local gangsters = {
	name = "Gangsters",
	command = "GANGSTA",
	color = Color(255,0,0,255),
	models = {
		{"models/Humans/Group03/Male_01.mdl","models/Humans/Group03/male_06.mdl"},
		"models/gman_high.mdl"
	},
	weapons = {
		weapon_glock,
		weapon_ak47
	},
	ranks = {
		"Newbie", "Active", "Raider", "Leader"
	},
	category = "Gang",
	stats = {
		50, 50, 50, 50
	},
	salary = 100
}
createJobs(gangsters)
```

Documentation
---

That looks pretty heavy and not really understandable. Let's take a look how the fuck is works:

### Table

##### `local gangsters = {}`

Creates new organisation.
You able to call it however you want and feel free to create them for any type of jobs you want. 

### Keys

##### `name = "string"`

Set the individual name for organization. Shows in scoreboard.

##### `command = "string"`

Set the individual command for organization. **Must be unique** for each organization.

##### `color = Color(r,b,a,alpha)`

Set color for organization. Shows in scoreboard and chat.

##### `models = {}`

Organization's models list. If you're using *unique* key, then feel free to create new table for each rank like this:
```lua
	models = {
		{'fake/path/model1.mdl', 'fake/path/model2.mdl', 'fake/path/model3.mdl'}, -- for rank1
		{'fake/path/model4.mdl', 'fake/path/model5.mdl'} -- for rank2
		'fake/path/model1.mdl' -- for rank3
	}
	ranks = {
		"rank1", -- using model1.mdl, model2.mdl and model3.mdl
		"rank2", -- using model4.mdl, model5.mdl
		"rank3" -- just model1.mdl
	}
```

If not, then:
```lua
	models = {
		'fake/path/model1.mdl',
		'fake/path/model2.mdl',
		'fake/path/model3.mdl'
	}
	ranks = {
		"rank1",
		"rank2", -- they're using all models from models table
		"rank3"
	}
```

##### `weapons = {}`

Weapon list. Works same as models for *unique* key.
Doesn't work with weapon names or other customs strings. Use only weapon class, please.
**tip:** ` LocalPlayer():GetActiveWeapon():GetClass()`

##### `ranks = {}`

Organization ranks. Sort them from lowest rank to highest, elsewhere whole hierarchy will fuck up.

##### `category = {}`

DarkRP category for created organization. If `nil` then create new for our organization.

##### `stats = {}`

*-- are they even resonable?*

##### `cvar = ""`

Custom cvars:
** - ** `m` - models (model1 for rank1, etc)
** - ** `w` - weapons (weapon1 for rank1, etc)
** - ** `s` - stats (statstable1 for rank1, etc)
** - ** `t` - title (title will not produced with - [%orgname%])

##### `sa = number`

Salary multiplier. Will increase salary for each rank:
```lua
	ranks = { "rank1", "rank2", "rank3"	},
	sa = 100
```
Will result:
```lua
	rank1 = DefaultSalary + 100
	rank2 = DefaultSalary + 200
	Rank3 = DefaultSalary + 300
```

Increases via `**salary** = *defaultSalary + (organization.salary * ogranization.ranks[number])*`

License
===

WTFPL, see [`LICENSE`](LICENSE) for details.