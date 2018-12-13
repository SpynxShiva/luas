-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan)
-------------------------------------------------------------------------------------------------------------------

--[[	Custom Features:
		
		Magic Burst			Toggle Magic Burst Mode  [Alt-`]
		Death Mode			Casting and Idle modes that maximize MP pool throughout precast/midcast/idle swaps
		Capacity Pts. Mode	Capacity Points Mode Toggle [WinKey-C]
		Auto. Lockstyle		Automatically locks desired equipset on file load
--]]

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2
	
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	include('organizer-lib')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

	state.CP = M(false, "Capacity Points Mode")

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Spaekona', 'Resistant')
	state.IdleMode:options('Normal', 'DT')

	-- Useful states
	state.WeaponLock = M(false, 'Weapon Lock')	
	state.Staff = M{['description']='Current Weapon', "Lathi", 'Grioavolr'}
	state.MagicBurst = M(false, 'Magic Burst')
	state.DeathMode = M(false, 'Death Mode')	
	state.CP = M(false, "Capacity Points Mode")

	-- Additional local binds
	send_command('bind ^` input /ma Stun <t>') 
	send_command('bind ^m gs c toggle MagicBurst')
	send_command('bind ^d gs c toggle DeathMode')
	send_command('bind ^c gs c toggle CP')
	send_command('bind !l gs c toggle WeaponLock')
	send_command('bind ^g gs c cycle Staff')

	-- Default gear to be used when no weather/day bonus
	gear.default.obi_waist = "Refoccilation Stone"
	gear.default.obi_ring = "Shiva Ring +1"
	gear.default.obi_back = gear.BLM_nuke_Cape
	
	-- Augmented items mapping

	select_default_macro_book()
	set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^`')
	send_command('unbind ^m')
	send_command('unbind ^d')
	send_command('unbind ^c')
	send_command('unbind !l')
	
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	---- Precast Sets ----
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Mana Wall'] = {
		feet="Wicce Sabots +1",
		back=gear.BLM_death_Cape
	}

	sets.precast.JA.Manafont = {} -- body="Arch. Coat"

	-- Fast cast sets for spells
	sets.precast.FC = {
		--	/RDM --15 /SCH -- 10
		main="Oranyan", 			-- 7
		sub="Enki Strap",
		ammo="Sapience Orb", 		-- 2
		head=gear.Merl_FC_head, 	-- 13
		neck="Orunmila's Torque", 	-- 5
		ear1="Etiolation Earring", 	-- 1
		ear2="Loquacious Earring", 	-- 2
        body="Anhur Robe", 			-- 10
		ring1="Kishar Ring",		-- 4
		ring2="Prolix Ring",		-- 2
		back=gear.BLM_FC_Cape, 		-- 4
		waist="Witful Belt", 		-- 3 (3)
		legs="Psycloth Lappas", 	-- 7
		feet=gear.Merl_FC_feet, 	-- 11
	}
									-- 71 (3)

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash"
	})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {waist="Siegel Sash"})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		body="Heka's Kalasiris", -- +5
		ammo="Impatiens",  		 -- -2 (+2)
		back="Perimede Cape" 	 -- -4 (+4)
	})							-- 72 +7 = 79 (9)

	sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {
		head=empty,
		body="Twilight Cloak"
	})

	sets.precast.Storm = set_combine(sets.precast.FC, {})
	
	sets.precast.FC.DeathMode = {
		ammo="Ghastly Tathlum +1",
		head="Amalric Coif +1",		-- 11
		body=gear.Amal_nuke_body,  	-- 
		hands="Bokwus Gloves", 
		legs="Psycloth Lappas", 	--7
		feet=gear.Amal_nuke_feet,
		neck="Orunmila's Torque", 	--5
		ear1="Etiolation Earring", 	--1
		ear2="Loquacious Earring", 	--2
		ring1="Mephitas's Ring +1",
		ring2="Mephitas's Ring", 
		back="Bane Cape", 		   	--TBD
		waist="Witful Belt", 		--3 (3)
	}
									-- 39
	
	sets.precast.FC.Impact.DeathMode = {head=empty,	body="Twilight Cloak"}

	-- Weaponskill sets
	
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		body="Onca Suit",
		--neck="Fotia Gorget",
		ear1="Moonshade Earring"
		--waist="Fotia Belt"
	}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	sets.precast.WS['Myrkr'] = {
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body="Weatherspoon Robe",
		hands="Bokwus Gloves",
		legs=gear.Amal_nuke_legs,
		feet="Telchine Pigaches",
		neck="Orunmila's Torque",
		ear1="Gifted Earring",
		ear2="Etiolation Earring",
		ring1="Mephitas's Ring +1",
		ring2="Mephitas's Ring",
		back="Bane Cape",
		waist="Shinjutsu-No-Obi +1",
	} -- Max MP
	
	---- Midcast Sets ----

	sets.midcast.FastRecast = sets.precast.FC

	sets.midcast.Cure = {
		head="Gendewitha caubeen +1", 	-- 10
		body="Heka's Kalasiris",		-- 15
		hands=gear.Telchine_CPR_hands,	-- 10 (7)
		legs="Gyve Trousers", 			-- 10
		feet="Medium's Sabots", 		-- 9
		neck="Phalaina Locket", 		-- 4 (4)
		ring1="Kunaji Ring",			-- 0 (5)
		waist="Gishdubar Sash" 			-- 0 (10)
	}
										-- 58 (26)

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})

	sets.midcast.Cursna = set_combine(sets.midcast.Cure, {waist="Gishdubar Sash",ring1="Purity Ring"})

	sets.midcast['Enhancing Magic'] = {
		main="Gada",
		sub="Ammurapi Shield",
		head=gear.Telchine_enh_head,
		neck="Incanter's Torque",
		ear2="Andoaa Earring",
		body=gear.Telchine_enh_body,
		hands=gear.Telchine_enh_hands,
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Perimede Cape",
		waist="Olympus Sash",
		legs=gear.Telchine_enh_legs,
		feet=gear.Telchine_enh_feet
	}

	sets.midcast.EnhancingDuration = sets.midcast['Enhancing Magic']

	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		main="Bolelabunga",
		sub="Genmei Shield"
	})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
		head="Amalric Coif +1",
		waist="Gishdubar Sash"
	})
	
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		waist="Siegel Sash",	-- 20
		neck="Nodens Gorget",	-- 30
		legs="Shedier Seraweels"-- 35
	})

	sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
		main="Vadose Rod",		--	1
		sub="Ammurapi Shield",
		head="Amalric Coif +1",	--	2
		legs="Shedir Seraweels",--	1
		waist="Emphatikos Rope",--	1
	})

	sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring1="Sheltered Ring"})
		
	sets.midcast.Protectra = sets.midcast.Protect
	sets.midcast.Shell = sets.midcast.Protect
	sets.midcast.Shellra = sets.midcast.Protect

	sets.midcast.MndEnfeebles = {
		main=gear.Grio_enf,sub="Enki Strap",ammo="Pemphredo Tathlum",
		head="Amalric Coif +1",neck="Incanter's Torque",ear1="Regal Earring",ear2="Dignitary's Earring",
        body="Spae. Coat +2",hands="Jhakri Cuffs +2",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.BLM_nuke_Cape,waist="Luminary Sash",legs="Psycloth Lappas",feet=gear.Merl_nuke_feet
	} -- MND/Magic accuracy

	sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {}) -- INT/Magic accuracy
		
	sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles

	sets.midcast['Dark Magic'] = set_combine(sets.midcast.MndEnfeebles,{
		ammo="Pemphredo Tathlum",
		neck="Erra Pendant",
		body="Shango Robe",
		ring2="Archon Ring"
	})
	

	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		main="Rubicundity",
		sub="Genmei Shield",
		head="Pixie Hairpin +1",
		ring1="Evanescence Ring",
		ring2="Archon Ring",
		waist="Fucho-no-obi",
		feet=gear.Merl_dark_feet
	})

	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

	sets.midcast.Death = {
		main=gear.Grio_death,		-- 5
		sub="Enki Strap",
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body=gear.Merl_nuke_body,	-- 8
		hands=gear.Amal_nuke_hands,	-- 0 (6)
		legs=gear.Amal_nuke_legs,
		feet=gear.Merl_nuke_feet, 	-- 8
		neck="Mizu. Kubikazari", 	-- 10
		ear1="Barkaro. Earring",
		ear2="Friomisi Earring",
		ring1="Mephitas's Ring +1",
		ring2="Archon Ring",
		back=gear.BLM_death_Cape, 	-- 5
		waist="Shinjutsu-No-Obi +1"	
	}
									-- 36 (6)
	-- To get: Elder's Grip +1
	
	-- Elemental Magic sets
	
	sets.midcast['Elemental Magic'] = {
		main=gear.Grio_nuke, sub="Enki Strap", ammo="Pemphredo Tathlum",
		head=gear.Merl_nuke_head, neck="Sanctity Necklace", ear1="Barkaro. Earring", ear2="Regal Earring",
		body=gear.Amal_nuke_body, hands=gear.Amal_nuke_hands, ring1=gear.ElementalRing, ring2="Shiva Ring +1",
		back=gear.BLM_nuke_Cape, waist=gear.ElementalObi, legs=gear.Amal_nuke_legs,	feet=gear.Amal_nuke_feet,
	}

	sets.midcast['Elemental Magic'].DeathMode = set_combine(sets.midcast['Elemental Magic'], {
		main=gear.Grio_death,
		sub="Elder's Grip +1",
		ammo="Ghastly Tathlum +1",
		legs=gear.Amal_nuke_legs,
		neck="Sanctity Necklace",
		back=gear.BLM_death_Cape
	})

	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		legs=gear.Merl_nuke_legs,
		feet=gear.Merl_nuke_feet,
		waist="Eschan Stone",
	})
			
	sets.midcast['Elemental Magic'].Spaekona = set_combine(sets.midcast['Elemental Magic'], {
		body="Spaekona's Coat +2",
	})

	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
		main=gear.Grio_nuke,
		sub="Enki Strap",
		head=empty,
		body="Twilight Cloak",
		ring2="Archon Ring",
	})

	-- Initializes trusts at iLvl 119
	sets.midcast.Trust = sets.precast.FC
	
	sets.resting = {
		main="Chatoyant Staff",
		waist="Shinjutsu-No-Obi +1"
	}

	-- Idle sets
	
	sets.idle = {
		main="Bolelabunga",
		sub="Genmei Shield",
		ammo="Pemphredo Tathlum",
		head="Befouled Crown",
		body="Jhakri Robe +2",
		hands=gear.Merl_Ref_hands,
		legs="Assid. Pants +1",
		feet=gear.Merl_nuke_feet,
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Genmei Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Moonbeam Cape",
		waist="Refoccilation Stone",
	}

	sets.idle.DT = set_combine(sets.idle, {
		main="Mafic Cudgel",
		sub="Genmei Shield",
		ammo="Staunch Tathlum +1",		--	2	2
		neck="Loricate Torque +1",	--	6	6
		ear1="Etiolation Earring",	--		3
		ear2="Odnowa Earring +1",	--		2
		body="Mallquis Saio +2",	--	6	6
		ring1="Dark Ring",			--	6	4
		ring2="Defending Ring",		--	10	10
		back="Moonbeam Cape",		--	5	5
		legs="Artsieq Hose",		--	5
	})

	sets.idle.ManaWall = set_combine(sets.idle.DT, {
		feet="Wicce Sabots +1",
		back=gear.BLM_death_Cape
	})

	sets.idle.DeathMode = {
		main=gear.Grio_death,
		sub="Enki Strap",
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body=gear.Amal_nuke_body,
		hands="Amalric Gages",
		legs="Amalric Slops",
		feet=gear.Merl_dark_feet,
		neck="Sanctity Necklace",
		ear1="Barkaro. Earring",
		ear2="Gifted Earring",
		ring1="Mephitas's Ring +1",
		ring2="Mephitas's Ring",
		back=gear.BLM_death_Cape,
		waist="Shinjutsu-No-Obi +1",
	}

	sets.idle.Town = set_combine(sets.idle, {
		head="Amalric Coif +1",
		body=gear.Amal_nuke_body,
		hands=gear.Amal_nuke_hands,
		legs=gear.Amal_nuke_legs,
		feet=gear.Amal_nuke_feet,
	})

	sets.idle.Weak = sets.idle.DT
		
	-- Defense sets

	sets.defense.PDT = sets.idle.DT
	sets.defense.MDT = sets.idle.DT

	sets.Kiting = {}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_dt = {}

	sets.magic_burst = {
		main=gear.Grio_MB,			-- 8
		sub="Enki Strap",
		neck="Mizu. Kubikazari",	-- 10
		head=gear.Merl_MB_head,		-- 10
		hands=gear.Amal_nuke_hands, -- 0 (6)
		ring1="Mujin Band", 		-- 0 (5)
		ring2="Locus Ring",			-- 5
		back=gear.BLM_nuke_Cape,	-- 5
	} 
									-- 38 (11) -> capped
	
	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group

	sets.engaged = sets.idle

	sets.buff.Doom = {waist="Gishdubar Sash"}

	sets.DarkAffinity = {head="Pixie Hairpin +1",ring2="Archon Ring"}
	sets.Obi = {waist="Hachirin-no-Obi"}
	sets.CP = {back="Mecisto. Mantle"}
	
	-- Organizer set
	organizer_items = {
	  -- Weapons
	  --Food
	  food="Pear Crepe",
	  hqfood="Crepe Belle Helene",
	  -- Meds
	  echos="Echo Drops",
	  remedy="Remedy",
	  --Utils
	  warpr="Warp Ring",
	  teler="Dim. Ring (Dem)",
	  -- Others
	  eobi="Hachirin-No-Obi",
	  ering="Zodiac Ring"
	}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' and state.DeathMode.value then
		eventArgs.handled = true
		equip(sets.precast.FC.DeathMode)
		if spell.english == "Impact" then
			equip(sets.precast.FC.Impact.DeathMode)
		end
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' and state.DeathMode.value then
		eventArgs.handled = true
		if spell.skill == 'Elemental Magic' then
			equip(sets.midcast['Elemental Magic'].DeathMode)
		elseif spell.skill == 'Dark Magic' then
			equip(set_combine(sets.midcast.Death,{neck="Erra Pendant"}))
		else
			equip(sets.midcast.Death)
		end
	end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) and not state.DeathMode.value then
		equip(sets.midcast.EnhancingDuration)
	end
	if spell.skill == 'Elemental Magic' and spell.english == "Comet" then
		equip(sets.DarkAffinity)		
	end
	if spell.skill == 'Elemental Magic' then
		if state.Staff.current == 'Grioavolr' or state.CastingMode.value == 'Resistant' then
			equip({main=gear.Grio_nuke,sub="Enki Strap"})
		else
			equip({main="Lathi",sub="Enki Strap"})
		end
		
		if state.MagicBurst.value and spell.english ~= 'Death' then
			equip(sets.magic_burst)
			add_to_chat(122, 'MB Used')
			if spell.english == "Impact" then
				equip(sets.midcast.Impact)
			end
		end
		
		if (spell.element == world.day_element or spell.element == world.weather_element) then
			equip(sets.Obi)
		end
		
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	-- Unlock armor when Mana Wall buff is lost.
	if buff== "Mana Wall" then
		if gain then
			--send_command('gs enable all')
			equip(sets.idle.ManaWall)
			--send_command('gs disable all')
		else
			--send_command('gs enable all')
			handle_equipping_gear(player.status)
		end
	end

	if buff == "doom" then
		if gain then		   
			equip(sets.buff.Doom)
			send_command('@input /p Doomed.')
			disable('waist')
		else
			enable('waist')
			handle_equipping_gear(player.status)
		end
	end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	if state.WeaponLock.value == true then
		if state.DeathMode.value  then
			equip({main=gear.Grio_death,sub="Enki Strap"})
		elseif state.Staff.current == 'Grioavolr' or state.CastingMode.value == 'Resistant' then
			equip({main=gear.Grio_nuke,sub="Enki Strap"})
		else
			equip({main="Lathi",sub="Enki Strap"})
		end
		disable('main','sub')
	else
		enable('main','sub')
	end
end

-- latent DT set auto equip on HP% change
--windower.register_event('hpp change', function(new, old)
--		if new<=25 then
--			equip(sets.latent_dt)
--		end
--	end)


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
	if spell.action_type == 'Magic' then
		if spell.skill == "Enfeebling Magic" then
			if spell.type == "WhiteMagic" then
				return "MndEnfeebles"
			else
				return "IntEnfeebles"
			end
		end
	end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if state.DeathMode.value then
		idleSet = sets.idle.DeathMode
	end
	if player.mpp < 51 then
		idleSet = set_combine(idleSet, sets.latent_refresh)
	end
	--if player.hpp <= 25 then
	--	idleSet = set_combine(idleSet, sets.latent_dt)
	--end
	if state.CP.current == 'on' then
		equip(sets.CP)
		disable('back')
	else
		enable('back')
	end
	-- if Mana Wall active, lock armor and equip -DT
	if buffactive['Mana Wall'] then
		idleSet = sets.idle.ManaWall
		--send_command('gs disable all')
	end
	
	return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
	display_current_caster_state()
	eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 5)
end

function set_lockstyle()
	send_command('wait 2; input /lockstyleset 7')
end
