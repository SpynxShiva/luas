-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
require('rnghelper')

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
	send_command('lua u autora')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	-- QuickDraw Selector
	state.Mainqd = M{['description']='Primary Shot', 'Dark Shot', 'Earth Shot', 'Water Shot', 'Wind Shot', 'Fire Shot', 'Ice Shot', 'Thunder Shot'}
	state.Altqd = M{['description']='Secondary Shot', 'Earth Shot', 'Water Shot', 'Wind Shot', 'Fire Shot', 'Ice Shot', 'Thunder Shot', 'Dark Shot'}
	state.UseAltqd = M(false, 'Use Secondary Shot')
	state.SelectqdTarget = M(false, 'Select Quick Draw Target')
	state.IgnoreTargetting = M(false, 'Ignore Targetting')
	
	state.Currentqd = M{['description']='Current Quick Draw', 'Main', 'Alt'}
	
	state.FlurryMode = M{['description']='Flurry Mode', 'Flurry II', 'Flurry I'}
	send_command('bind ^f gs c cycle FlurryMode')
	
	state.HasteMode = M{['description']='Haste Mode', 'Haste II', 'Haste I'}
	send_command('bind @h gs c cycle HasteMode')
	
	
	state.LuzafRing = M(false, "Luzaf's Ring")
	-- Whether a warning has been given for low ammo
	state.warned = M(false)
	
	define_roll_values()
	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'MidAcc','HighAcc')
    state.RangedMode:options('STP','Normal', 'Acc','Enmity')
    state.WeaponskillMode:options('Normal', 'Acc','Enmity')
    state.PhysicalDefenseMode:options('None', 'PDT')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'DT','Crit')
	state.HybridMode:options('Normal', 'DT','Crit')

	-- Useful states
	state.ForceCompensator = M(false, 'Force Compensator')
	state.CP = M(false, "Capacity Points Mode")
	state.MDshot = M(false, "Magic Damage Bonus Shot")
	
	send_command('bind ^z input /ja "Berserk" <me>')
	send_command('bind ^t input /ja "Triple Shot" <me>')
	
	
	send_command('bind ^l gs c toggle ForceCompensator')
	send_command('bind ^b gs c toggle MDshot')
	
	-- QD toogles
	send_command('bind ^- gs c cycleback mainqd')
	send_command('bind ^= gs c cycle mainqd')
	send_command('bind !- gs c cycle altqd')
	send_command('bind != gs c cycleback altqd')
	
	-- Autoshoot toggles
	send_command('bind ^[ gs rh enable')
	send_command('bind ^] gs rh disable')	
	send_command('bind ^; gs rh set "Last Stand"')
	send_command('bind ^\' gs rh set "Leaden Salute"')
	send_command('bind ^c gs rh clear')
	
	-- Gears
	-- Bullets
	gear.RAbullet = "Chrono Bullet"
	gear.WSbullet = "Chrono Bullet"
	gear.MAbullet = "Orichalc. Bullet"
	gear.QDbullet = "Animikii Bullet"
	options.ammo_warning_limit = 5
	
	-- Weapon sets
	state.WeaponSets = M{['description']='Weapon set', 'Melee', 'RangedMelee', 'RangedOnly', 'LeadenSpeed', 'LeadenPower'}
	WeaponSetsGear = { 
		["Melee"] = {main="Naegling",sub="Blurred Knife +1",range="Anarchy +2"},
		["RangedMelee"] = {main="Kustawi +1",sub="Blurred Knife +1", range="Fomalhaut"},
		["RangedOnly"] = {main="Kustawi +1",sub="Nusku Shield", range="Fomalhaut"},
		["LeadenSpeed"] = {main="Kaja Knife",sub="Blurred Knife +1",range="Fomalhaut"},
		["LeadenPower"] = {main="Naegling",sub="Kaja Knife",range="Fomalhaut"},
	}	
	
	send_command('bind ^. gs c cycleback WeaponSets')
	send_command('bind ^/ gs c cycle WeaponSets')
	
    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^l')
	send_command('unbind ^m')
	send_command('unbind ^c')
	send_command('unbind ^b')
	send_command('unbind ^z')
	send_command('unbind ^t')
	send_command('unbind !w')
	send_command('unbind ^-')
	send_command('unbind ^=')
	send_command('unbind !-')
	send_command('unbind !=')
	send_command('unbind ^[')
	send_command('unbind ^]')
	send_command('unbind @h')
	send_command('unbind ^;')
	send_command('unbind ^.')
	send_command('unbind ^/')	
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    
	sets.enmity={
		feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},
		right_ear="Enervating Earring",
		left_ring="Cacoethic Ring",
		right_ring="Cacoethic Ring +1",
	}
	
	--------------------------------------
    -- Precast sets
    --------------------------------------
	sets.precast.JA['Random Deal'] = {body="Lanun Frac"}
	sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
	
	sets.precast.FC = {
		head="Carmine Mask +1", 	--	14
		body=gear.Taeon_FC_body,	--	 8
		hands="Leyline Gloves", 	--	 8
		feet="Carmine Greaves +1",	--	 8
		neck="Orunmila's Torque",  	--	 5
		ear1="Loquacious Earring", 	--	 2
		ring1="Kishar Ring",		--	 4
	}								--  49
	
	sets.precast.CorsairRoll = {
		-- Compensator is equipped only if low TP or forced
		head="Lanun tricorne +1",	
		body="Meg. Cuirie +2",		
		hands="Chasseur's Gants",  	
		legs="Desultor Tassets",
		feet="Meg. Jam. +2",		
		neck="Regal Necklace",	
		waist="Flume Belt +1",
		ring1="Defending Ring",
		ring2="Luzaf's Ring",
		ear1="Genmei Earring",		
		ear2="Etiolation Earring",	
		back="Camulus's Mantle"
	}
	
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac"})
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants"})
	
	-- Snapshot caps at 70 - 
	sets.precast.RA = {					-- SNAP		RAPID
		-- COR Gifts/base				--	10		 30
		ammo=gear.RAbullet,			
		head=gear.Taeon_SNAP_head,		--	10
		body="Oshosi Vest +1",			-- 	14
		hands=gear.Carmine_SNAP_hands,	--	 8		 11
		feet="Meg. Jam. +2",			--	10
		legs=gear.Adhemar_SNAP_legs,	--	 9		 10
		waist="Yemaya Belt",			--			 5
		back=gear.COR_SNAP_Cape,		--	10
	}									--	71		 56
	
	
	sets.precast.RA.Flurry1 = set_combine(sets.precast.RA,{
									-- SNAP		RAPID
		body="Laksa. Frac +3",		-- -10		20
	})								--	57		76
	
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1,{
									-- SNAP		RAPID
		head="Chass. Tricorne",  	-- -10		12
        feet="Pursuer's Gaiters", 	-- -10	    10
        waist="Impulse Belt", 		--   3		-5
									--  40		93
	})
	
    -- Weaponskill sets
	sets.precast.WS = {
		ammo=gear.WSbullet,
		head=gear.Herc_RA_head,
		body="Laksa. Frac +3",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Lanun Bottes +3",
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		ring1="Epaminondas's Ring",
		ring2="Regal Ring",
		back=gear.COR_WSPhys_Cape,
		waist="Fotia Belt",
	}
	
    sets.precast.WS['Leaden Salute'] = {
		ammo=gear.MAbullet,
		head="Pixie Hairpin +1",
		body="Samnuha Coat",
		hands=gear.Carmine_LS_hands,
		legs=gear.Herc_MAB_legs,
		feet="Lanun Bottes +3",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		ear1="Friomisi Earring",
		ear2="Moonshade Earring",
		ring1="Dingir Ring",
		ring2="Archon Ring",
		back=gear.COR_WSMagic_Cape
	}
	
	sets.precast.WS['Leaden Salute'].FullTP = {ear2="Hecate's Earring"}
	
	sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS['Leaden Salute'],{
		head=gear.Herc_MAB_head,
		ear2="Hecate's Earring",
		ring2="Regal Ring"
	})
	
	sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Wildfire']
	
	sets.precast.WS["Last Stand"] = sets.precast.WS
	
	sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
		head="Meghanada Visor +2",
		neck="Iskur Gorget",
		ear2="Telos Earring",
		feet="Meg. Jam. +2",
		ring1="Cacoethic Ring +1",
		waist="Kwahu Kachina Belt",
	})

	sets.precast.WS['Last Stand'].Enmity = set_combine(sets.precast.WS['Last Stand'], sets.enmity)
	
	sets.precast.WS["Savage Blade"] = {
		head=gear.Herc_SB_head,
		neck="Caro Necklace",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body="Laksa. Frac +3",
		hands="Meg. Gloves +2",
		ring1="Karieyh Ring +1",
		ring2="Epaminondas's Ring",
		back=gear.COR_SB_Cape,
		waist="Prosilio Belt +1",
		legs=gear.Herc_SB_legs,
		feet="Lanun Bottes +3"
	}
	
	sets.precast.WS["Savage Blade"].FullTP = set_combine(sets.precast.WS["Savage Blade"],{
		ear1="Odnowa Earring +1"
	})
	
	sets.precast.WS["Savage Blade"].Acc = set_combine(sets.precast.WS["Savage Blade"],{
		head="Meghanada Visor +2",
		neck="Combatant's Torque",
		ear1="Telos Earring",
		waist="Grunfeld Rope",
		ring2="Regal Ring",
	})
	
	
	sets.precast.WS['Requiescat']=sets.precast.WS["Savage Blade"]
	
	--[[
	sets.precast.WS['Evisceration']={
		head=gear.Adhemar_TP_head,
        body=gear.Herc_CDC_body,
		hands=gear.Herc_CDC_hands,
        legs="Samnuha Tights",
        feet=gear.Herc_TP_feet,
        neck="Fotia Gorget",
        ear1="Brutal Earring",
		ear2="Moonshade Earring",
        ring1="Begrudging Ring",
        ring2="Regal Ring",
        back=gear.COR_SB_Cape,
        waist="Fotia Belt",
	}--]]
	
	
	sets.precast.JA['Fold'] = {hands="Commodore Gants +2"}
	--------------------------------------
    -- Midcast sets
    --------------------------------------
	sets.midcast.CorsairShot = {
		ammo=gear.QDbullet,
		head=gear.Herc_MAB_head,
		body="Samnuha Coat",
		hands=gear.Carmine_LS_hands,
		legs=gear.Herc_MAB_legs,
		feet=gear.Herc_MAB_feet,
		neck="Sanctity Necklace",
		ear1="Hecate's Earring",
		ear2="Friomisi Earring",
		ring1="Dingir Ring",
		ring2="Shiva Ring +1",
		back="Gunslinger's Cape",
		waist="Eschan Stone"
	}
	
	sets.midcast.CorsairShot.Resistant = set_combine(sets.midcast.CorsairShot, {
		head="Mummu Bonnet +1",
		body="Mummu Jacket +2",
		hands="Mummu Wrists +1",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Sanctity Necklace",
		ear1="Hermetic Earring",
		ear2="Digni. Earring"
	})
    
	sets.midcast.CorsairShot['Light Shot'] = sets.midcast.CorsairShot.Resistant
	sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot.Resistant
	
	sets.midcast.RA = {
		ammo=gear.RAbullet,	
		head="Meghanada Visor +2",
		body="Oshosi Vest +1",
		hands=gear.Adhemar_RA_hands,
		legs=gear.Adhemar_RA_legs,
		feet="Meg. Jam. +2",
		neck="Iskur Gorget",
		ear1="Telos Earring",
		ear2="Enervating Earring",
		ring1="Rajas Ring",
		ring2="Ilabrat Ring",
		back=gear.COR_RA_Cape,
		waist="Yemaya Belt"
	}
	
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA,{
		body="Laksa. Frac +3",
		hands="Meg. Gloves +2",
		waist="Kwahu Kachina Belt",
		ring1="Cacoethic Ring +1",
		ring2="Regal Ring",
	})
	
	sets.midcast.RA.STP = set_combine(sets.midcast.RA, {
        feet="Carmine Greaves +1",
        ear1="Dedition Earring",
	})
	
	
	sets.midcast.RA.Enmity = set_combine(sets.midcast.RA.MidAcc,sets.enmity)
	
	
    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {					-- PDT	MDT
		ammo=gear.RAbullet,
		head=gear.Herc_DT_head,		-- 4	4
		body="Meg. Cuirie +2",		-- 8
		hands=gear.Herc_DT_hands,	-- 6	4
		legs="Carmine Cuisses +1",	
		feet="Lanun Bottes +3",		-- 6
		neck="Loricate Torque +1",	-- 6	6
		waist="Flume Belt +1",		-- 4
		ear1="Odnowa Earring +1",	-- 		2
		ear2="Etiolation Earring",	-- 		3
		ring1="Defending Ring",		--10	10
		ring2="Dark Ring",			-- 6	4
		back="Moonbeam Cape"		-- 5	5
	}								--55	38
	
	sets.idle.DT = set_combine(sets.idle,{legs="Meghanada Chausses +2"})

    -- Defense sets
    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT
	sets.Kiting = {legs="Carmine Cuisses +1"}

	--------------------------------------
    -- Melee sets
    --------------------------------------
	
	-- 0 haste -> 59
	sets.engaged = {				-- DW
		head=gear.Adhemar_TP_head,		
		neck="Iskur Gorget",
		ear1="Eabani Earring",		--	4
		ear2="Suppanomimi",			--	5
		body=gear.Adhemar_TP_body,	--	6
		hands="Floral Gauntlets",	--	5
		ring1="Petrov Ring",		
		ring2="Epona's Ring",
		back=gear.COR_DW_Cape,		-- 10
		waist="Reiki Yotai",		--	7
		legs="Carmine Cuisses +1",	--	6
		feet=gear.Herc_TP_feet
	}								-- 43
	
	
	-- 15% haste -> 52
	sets.engaged.LowHaste = sets.engaged
	
	-- 30% haste -> 41
	sets.engaged.HighHaste = sets.engaged
	
	-- Capped haste -> 21
	sets.engaged.MaxHaste = {
		head=gear.Adhemar_TP_head,
		neck="Iskur Gorget",
		ear1="Telos Earring",
		ear2="Suppanomimi",			--	5
		body=gear.Adhemar_TP_body,	--	6
		hands=gear.Adhemar_TP_hands,
		ring1="Petrov Ring",
		ring2="Epona's Ring",
		back=gear.COR_DW_Cape,		-- 10
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
		feet=gear.Herc_TP_feet
	}								-- 21
	
	-- Ninja DW updated: 
	if player.sub_job == 'NIN' then
		-- No haste 	-> 49
		-- No changes (43<49)
	
		-- 15% haste 	-> 42
		-- No changes (43 vs 42)
		
		-- 30% haste 	-> 31
		sets.engaged.HighHaste = set_combine(sets.engaged,{  
			-- Base							43			
			waist="Windbuffet Belt +1",	--  -7
			hands=gear.Adhemar_TP_hands --	-5
		})								--  31
		
		-- Max haste	-> 11
		sets.engaged.MaxHaste = set_combine(sets.engaged.MaxHaste,{
			-- Base						--	21
			back=gear.COR_TP_Cape,		-- -10
		})								--	11
	end
	
	
	-- WAR sub -> don't need any DW
	if player.sub_job == 'WAR' then
		sets.engaged = {
			head=gear.Adhemar_TP_head,
			neck="Iskur Gorget",
			ear1="Cessance Earring",
			ear2="Brutal Earring",
			body=gear.Adhemar_TP_body,
			hands=gear.Adhemar_TP_hands,
			ring1="Epona's Ring",
			ring2="Petrov Ring",
			back=gear.COR_TP_Cape,
			waist="Windbuffet Belt +1",
			legs="Samnuha Tights",
			feet=gear.Herc_TP_feet
		}
		
		sets.engaged.LowHaste = sets.engaged
	
		sets.engaged.HighHaste = sets.engaged
		
		sets.engaged.MaxHaste = sets.engaged
	end
	
	-- Acc swaps
	sets.MidAcc = {
		head="Dampening Tam",
		neck="Combatant's Torque",
		ear2="Cessance Earring",
		ring1="Chirich Ring",
		waist="Kentarch Belt +1"
	}
	sets.HighAcc = {
		head="Carmine Mask +1",
		neck="Combatant's Torque",
		ear2="Cessance Earring",
		ring1="Chirich Ring",
		ring2="Cacoethic Ring +1",
		waist="Kentarch Belt +1",
		legs="Carmine Cuisses +1"
	}
	
	sets.engaged.MidAcc = set_combine(sets.engaged,sets.MidAcc)
	sets.engaged.HighAcc = set_combine(sets.engaged,sets.HighAcc)
	sets.engaged.MidAcc.LowHaste = set_combine(sets.engaged.LowHaste,sets.MidAcc)
	sets.engaged.HighAcc.LowHaste = set_combine(sets.engaged.LowHaste,sets.HighAcc)
	sets.engaged.MidAcc.HighHaste = set_combine(sets.engaged.HighHaste,sets.MidAcc)
	sets.engaged.HighAcc.HighHaste = set_combine(sets.engaged.HighHaste,sets.HighAcc)
	sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.MaxHaste,sets.MidAcc)
	sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.MaxHaste,sets.HighAcc)
	
	sets.engaged.PDT = set_combine(sets.engaged,{
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		waist="Sailfi Belt +1"
	})
	
	-- Hybrid sets
	sets.engaged.Hybrid = {
		legs="Meghanada Chausses +2",	--	6
		hands=gear.Herc_DT_hands,		--	6	4
		neck="Loricate Torque +1", 		--	6	6
		ring1="Defending Ring", 		-- 10	10
	}									-- 28	20
	
	sets.engaged.Critical = {}
	--[[{
		head="Mummu Bonnet +1",		-- 4
		body="Mummu Jacket +2",		-- 9
		hands="Mummu Wrists +1",	-- 5
		legs="Mummu Kecks +1",		-- 6
		feet="Mummu Gamashes +1",	-- 4
		ring1="Mummu Ring", 		-- 3
		ring2="Begrudging Ring",	-- 5
		waist="Kwahu Kachina Belt",	-- 4
									-- 40
	}--]]
	
	sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    
    sets.engaged.DT.LowHaste = set_combine(sets.engaged.LowHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.LowHaste = set_combine(sets.engaged.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.LowHaste = set_combine(sets.engaged.HighAcc.LowHaste, sets.engaged.Hybrid)    
    
    sets.engaged.DT.HighHaste = set_combine(sets.engaged.HighHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.HighHaste = set_combine(sets.engaged.HighAcc.HighHaste, sets.engaged.Hybrid)    
    
    sets.engaged.DT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste, sets.engaged.Hybrid)    
	
	
	sets.engaged.Crit = set_combine(sets.engaged, sets.engaged.Critical)
    sets.engaged.MidAcc.Crit = set_combine(sets.engaged.MidAcc, sets.engaged.Critical)
    sets.engaged.HighAcc.Crit = set_combine(sets.engaged.HighAcc, sets.engaged.Critical)
    
    sets.engaged.Crit.LowHaste = set_combine(sets.engaged.LowHaste, sets.engaged.Critical)
    sets.engaged.MidAcc.Crit.LowHaste = set_combine(sets.engaged.MidAcc.LowHaste, sets.engaged.Critical)
    sets.engaged.HighAcc.Crit.LowHaste = set_combine(sets.engaged.HighAcc.LowHaste, sets.engaged.Critical)    
    
    sets.engaged.Crit.HighHaste = set_combine(sets.engaged.HighHaste, sets.engaged.Critical)
    sets.engaged.MidAcc.Crit.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, sets.engaged.Critical)
    sets.engaged.HighAcc.Crit.HighHaste = set_combine(sets.engaged.HighAcc.HighHaste, sets.engaged.Critical)    
    
    sets.engaged.Crit.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.Critical)
    sets.engaged.MidAcc.Crit.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, sets.engaged.Critical)
    sets.engaged.HighAcc.Crit.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste, sets.engaged.Critical)
    
	sets.buff.Doom = {waist="Gishdubar Sash"}
	sets.Obi = {waist="Hachirin-no-Obi"}
	sets.MBbonus = {feet="Chasseur's Bottes +1"}
	
	-- Orgnizer set
	organizer_items = {
		-- Weapons
		dagger1="Kustawi +1",
		dagger2="Kaja Knife",
		dagger3="Blurred Knife +1",
		shield="Nusku Shield",
		sword1="Naegling",
		gun1="Fomalhaut",
		gun2="Compensator",
		gun3="Anarchy +2",
		-- Meds
		echos="Echo Drops",
		remedy="Remedy",
		-- Food
		sushi="Sublime Sushi",
		atkfood="Red Curry Bun",
		-- Utils
		warpr="Warp Ring",
		teler="Dim. Ring (Dem)",
		-- Others
		eobi="Hachirin-No-Obi",
		--shihei="Shihei",
		cards="Trump Card",
		cardcase="Trump Card Case",
		obulletpouch="Orichalcum Bullet Pouch",
		cape1=gear.COR_TP_Cape,
		cape2=gear.COR_DW_Cape,
		
	}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
	-- Check that proper ammo is available if we're using ranged attacks or similar.
	if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
		do_bullet_checks(spell, spellMap, eventArgs)
	end
	
	-- Prevent folding without a bust
	--if spell.english == 'Fold' and buffactive['Bust'] ~= 1 then
		--add_to_chat(104, 'Trying to fold without a bust. Aborting.')
		--eventArgs.cancel = true
		--return
	--end
end


-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    -- Equip compensator only if TPs are very low (to avoid losing them) or if ForceCompensator (CTRL+C) is set
	if (spell.type == 'CorsairRoll' and player.tp < 200 ) or (spell.type == 'CorsairRoll' and state.ForceCompensator.value) then
		add_to_chat(104, 'Compensator used')
		equip({range="Compensator"})
	end	
	
	 -- Flurry mode/status check
	if state.FlurryMode.value == 'Flurry II' and (buffactive[265] or buffactive[581]) then
			equip(sets.precast.RA.Flurry2)
	elseif state.FlurryMode.value == 'Flurry I' and (buffactive[265] or buffactive[581]) then
		equip(sets.precast.RA.Flurry1)
	end
	
	-- Equip obi if weather/day matches for WS/Quick Draw.
    if spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        if spell.english == 'Leaden Salute' then
            if world.weather_element == 'Dark' or world.day_element == 'Dark' then
                equip(sets.Obi)
            end
            if player.tp > 2750 then
                equip(sets.precast.WS['Leaden Salute'].FullTP)
            end 
        elseif spell.english == 'Savage Blade' and player.tp > 2750 then 
			equip(sets.precast.WS['Savage Blade'].FullTP)
		elseif spell.english == 'Wildfire' and (world.weather_element == 'Fire' or world.day_element == 'Fire') then
            equip(sets.Obi)
        elseif spell.type == 'CorsairShot' and (spell.element == world.weather_element or spell.element == world.day_element) then
            if spell.english ~= "Light Shot" and spell.english ~= "Dark Shot" then
                equip(sets.Obi)
            end
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.type == 'CorsairShot' and (spell.element == world.weather_element or spell.element == world.day_element) then
		if spell.english ~= "Light Shot" and spell.english ~= "Dark Shot" then
			equip(sets.Obi)
		end
		
		if state.MDshot.value then
			equip(sets.MBbonus)
		end
     end
	 
	
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
	
	if spell.english == "Light Shot" then
        send_command('@timers c "Light Shot ['..spell.target.name..']" 60 down abilities/00195.png')
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
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
	
	-- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
		if not midaction() then
            handle_equipping_gear(player.status)
        end
    elseif state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
	
	
end

function customize_idle_set(idleSet)
    return idleSet
end


function customize_melee_set(meleeSet)
    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    determine_haste_group()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    -- Compensator
	if state.ForceCompensator.value == true then
        add_to_chat(104, 'Force Compensator: [On]')
    elseif state.ForceCompensator.value == false then
        add_to_chat(104, 'Force Compensator: [Off]')
    end
	
	-- Main QD
	if state.Mainqd.current ~= nil then
		add_to_chat(104, 'Current QD:'..state.Mainqd.current)
	end
	
	-- Alternative QD
	if state.Altqd.current ~= nil then
		add_to_chat(104, 'Current Atl QD:'..state.Altqd.current)
	end

	-- Main/aternative QD toggle
	if state.UseAltqd.value == true then
		add_to_chat(104, 'Alt QD: [On]')
    elseif state.UseAltqd.value == false then
        add_to_chat(104, 'Alt QD: [Off]')
    end	
	
	-- Use gear to increase elemenetal damage on shot
	if state.MDshot.value == true then
		add_to_chat(104, 'Magic Damage Bonus shot: [On]')
    elseif state.MDshot.value == false then
        add_to_chat(104, 'Magic Damage Bonus shot: [Off]')
    end
	
    eventArgs.handled = true
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	-- Equip weapons based on mode
	if state.WeaponSets.current then
		add_to_chat(104,'Equippping set:' .. state.WeaponSets.current )
        equip(WeaponSetsGear[state.WeaponSets.current])
	end
 end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
	local bullet_name
	local bullet_min_count = 1
	
	if spell.type == 'WeaponSkill' then
		if spell.skill == "Marksmanship" then
			if spell.name == 'Leaden Salute' or spell.name == 'Wildfire' then
				-- magical weaponskills
				bullet_name = gear.MAbullet
				
			else
				-- physical weaponskills
				bullet_name = gear.WSbullet
			end
		else
			-- Ignore non-ranged weaponskills
			return
		end
	elseif spell.type == 'CorsairShot' then
		bullet_name = gear.QDbullet
	elseif spell.action_type == 'Ranged Attack' then
		bullet_name = gear.RAbullet
		if buffactive['Triple Shot'] then
			bullet_min_count = 3
		end
	end
	
	local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
	
	-- If no ammo is available, give appropriate warning and end.
	if not available_bullets then
		if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
			add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
			return
		elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
			add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
			return
		else
			add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
			eventArgs.cancel = true
			return
		end
	end
	
	-- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
	if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
		add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
		eventArgs.cancel = true
		return
	end
	
	-- Low ammo warning.
	if spell.type ~= 'CorsairShot' and state.warned.value == false
		and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
		local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
		--local border = string.repeat("*", #msg)
		local border = ""
		for i = 1, #msg do
			border = border .. "*"
		end
		
		add_to_chat(104, border)
		add_to_chat(104, msg)
		add_to_chat(104, border)

		state.warned:set()
	elseif available_bullets.count > options.ammo_warning_limit and state.warned then
		state.warned:reset()
	end
end

function determine_haste_group()

    -- Gearswap can't detect the difference between Haste I and Haste II
    -- so use winkey-H to manually set Haste spell level.

    -- Haste (buffactive[33]) - 15%
    -- Haste II (buffactive[33]) - 30%
    -- Haste Samba - 5~10%
    -- Honor March - 12~16%
    -- Victory March - 15~28%
    -- Advancing March - 10~18%
    -- Embrava - 25%
    -- Mighty Guard (buffactive[604]) - 15%
    -- Geo-Haste (buffactive[580]) - 30~40%

    classes.CustomMeleeGroups:clear()

	if state.HasteMode.value == 'Haste II' then
        if(((buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604])) or
            (buffactive[33] and (buffactive[580] or buffactive.embrava)) or
            (buffactive.march == 2 and buffactive[604]) or buffactive.march == 3) then
            add_to_chat(122, 'Magic Haste Level: 43%')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ((buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba']) then
            add_to_chat(122, 'Magic Haste Level: 35%')
            classes.CustomMeleeGroups:append('HighHaste')
        elseif ((buffactive[580] or buffactive[33] or buffactive.march == 2) or
            (buffactive.march == 1 and buffactive[604])) then
            add_to_chat(122, 'Magic Haste Level: 30%')
            classes.CustomMeleeGroups:append('HighHaste')
        elseif (buffactive.march == 1 or buffactive[604]) then
            add_to_chat(122, 'Magic Haste Level: 15%')
            classes.CustomMeleeGroups:append('LowHaste')
        end
    else
        if (buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or
            (buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604])) or
            (buffactive.march == 2 and (buffactive[33] or buffactive[604])) or
            (buffactive[33] and buffactive[604] and buffactive.march ) or buffactive.march == 3 then
            add_to_chat(122, 'Magic Haste Level: 43%')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ((buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or
            (buffactive.march == 2 and buffactive['haste samba']) or
            (buffactive[580] and buffactive['haste samba'] ) then
            add_to_chat(122, 'Magic Haste Level: 35%')
            classes.CustomMeleeGroups:append('HighHaste')
        elseif (buffactive.march == 2 ) or
            ((buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
            (buffactive[580] ) or  -- geo haste
            (buffactive[33] and buffactive[604]) then
            add_to_chat(122, 'Magic Haste Level: 30%')
            classes.CustomMeleeGroups:append('HighHaste')
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            add_to_chat(122, 'Magic Haste Level: 15%')
            classes.CustomMeleeGroups:append('LowHaste')
        end
    end
end

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
	command = cmdParams[1]:lower()
	
	if command == 'qd' then
		if cmdParams[2] == 't' then
			state.IgnoreTargetting:set()
		end

		local doqd = ''
		if state.UseAltqd.value == true then
			doqd = state[state.Currentqd.current..'qd'].current
			state.Currentqd:cycle()
		else
			doqd = state.Mainqd.current
		end		
		
		send_command('@input /ja "'..doqd..'" <t>')
	end
	
end


function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Drachen Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Puppet Roll"]     = {lucky=3, unlucky=7, bonus="Pet Magic Attack/Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Naturalist's Roll"]       = {lucky=3, unlucky=7, bonus="Enh. Magic Duration"},
        ["Runeist's Roll"]       = {lucky=4, unlucky=8, bonus="Magic Evasion"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies' Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, '[ Lucky: '..tostring(rollinfo.lucky)..' / Unlucky: '..tostring(rollinfo.unlucky)..' ] '..spell.english..': '..rollinfo.bonus..' ('..rollsize..') ')
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(2, 14)
end

function job_sub_job_change(newSubjob, oldSubjob)
    -- Reload gearswap on SJ change to handle SJ specific sets
	send_command('gs reload')
end
