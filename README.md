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
	sa = 100
}
createJobs(gangsters)
```

Documentation
---

That looks pretty heavy and not really understandable. Let's take a look how the fuck is works:

### Table

##### local gangsters = {}

Creates new organisation.
You able to call it however you want and feel free to create them for any type of jobs you want. 

We're creating our new organization. Feel free to call it however you want. You can create them for any type of jobs even for 