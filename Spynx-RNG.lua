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
	state.Buff.Barrage = buffactive.Barrage or false
	state.Buff.Camouflage = buffactive.Camouflage or false
	state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
	state.Buff['Velocity Shot'] = buffactive['Velocity Shot'] or false
	state.Buff['Double Shot'] = buffactive['Double Shot'] or false
	
	state.FlurryMode = M{['description']='Flurry Mode', 'Flurry II', 'Flurry I'}
	send_command('bind ^f gs c cycle FlurryMode')
	
	
	state.warned = M(false)
	state.autows = M(false, 'AutoWS')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'lowHP')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('STP','Normal', 'MidAcc','FullAcc')
    state.WeaponskillMode:options('Normal', 'MidAcc', 'FullAcc')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')

	-- Bullets
	gear.RAbullet = "Chrono Bullet"
	gear.WSbullet = "Chrono Bullet"
	gear.MAbullet = "Orichalcum Bullet"
	options.ammo_warning_limit = 5
	
	-- JAs
	send_command('bind ^z input /ja "Berserk" <me>')
	send_command('bind ^t input /ja "Double Shot" <me>')
	
	-- Autoshoot toggles
	send_command('bind ^[ gs rh enable')
	send_command('bind ^] gs rh disable')	
	send_command('bind ^; gs rh set "Last Stand"')
	send_command("bind ^' gs rh set")
	send_command('bind ^c gs rh clear')
	
	-- Additional local binds
    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^f')
	send_command('unbind ^z')
	send_command('unbind ^t')
	send_command('unbind ^[')
	send_command('unbind ^]')
	send_command('unbind ^;')
	send_command("unbind ^'")
	send_command('unbind ^c')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    
	
	sets.buff.Barrage = {
		head="Orion Beret +3",
		body="Orion Jerkin +3",
		hands="Orion Bracers +3",
	}
	
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +3"}
	sets.buff['Velocity Shot'] = set_combine(sets.midcast.RA, {body="Amini Caban +1", back=gear.RNG_TP_Cape})
	
	
	--------------------------------------
    -- Precast sets
    --------------------------------------

	-- Fast cast for trusts
	sets.precast.FC = {
		head="Carmine Mask +1", 	--	14
		body="Taeon Tabard",		--	 4
		hands="Leyline Gloves", 	--	 7
		legs="Gyve Trousers",		--	 4
		feet="Carmine Greaves +1",	--	 8
		neck="Orunmila's Torque",  	--	 5
		ear1="Loquacious Earring", 	--	 2
	}								--  44
	
	-- Snapshot caps at 70 - 
	sets.precast.RA = {					-- SNAP		RAPID
		-- RNG merits/base 				--	10		 35
		ammo=gear.RAbullet,			                      
		head=gear.Taeon_SNAP_head,		--	10            
		body="Oshosi Vest +1",			-- 	14            
		hands=gear.Carmine_SNAP_hands,	--	 8		 11   
		feet="Meg. Jam. +2",			--	10            
		legs=gear.Adhemar_SNAP_legs,	--	 9		 10   
		waist="Yemaya Belt",			--			 5
		back=gear.RNG_SNAP_Cape,		--  10				
	}									--	71		 61		

	
	sets.precast.RA.Flurry1 = set_combine(sets.precast.RA,{			-- SNAP		RAPID  
		-- Original set					--	71		 61	
		-- Flurry1						--  15
		body="Amini Caban +1",          -- -14
	})									--	70		 61    

	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1,{
		-- Original set					--	70		 61	
		-- Flurry2 vs flurry 1			--  15
		head="Orion Beret +3",			-- -10		 18    
	})									--	75		 79

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    -- Weaponskill sets
	sets.precast.WS = {
		ammo=gear.WSbullet,
		head="Orion Beret +3",
		body="Orion Jerkin +3",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
		ring1="Dingir Ring",
		ring2="Regal Ring",
		back=gear.RNG_WSPhys_Cape,
		waist="Fotia Belt",
	}
	
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
    
	sets.precast.WS["Last Stand"] = sets.precast.WS
	
	sets.precast.WS["Last Stand"].MidAcc = set_combine(sets.precast.WS["Last Stand"],{
		neck="Iskur Gorget",
		ear2="Telos Earring",
		waist="Kwahu Kachina Belt"
	})

	sets.precast.WS["Last Stand"].FullAcc = set_combine(sets.precast.WS["Last Stand"].MidAcc,{
		ring1="Cacoethic Ring +1",
	})
	
	
	sets.precast.WS["Evisceration"] = {
		range="Fomalhaut",
		ammo="Chrono Bullet",
		head=gear.Adhemar_TP_head,
		body=gear.Herc_CDC_body,
		hands=gear.Herc_CDC_hands,
		legs="Samnuha Tights", 
		feet="Thereoid Greaves",
		neck="Light Gorget",
		waist="Light Belt",
		ear1="Moonshade Earring",
		ear2="Sherida Earring",
		ring1="Begrudging Ring",
		ring2="Regal Ring",
	}
	
	sets.precast.WS["Trueflight"] = {
		ammo=gear.MAbullet,
		head="Orion Beret +3",
		body="Samnuha Coat",
		hands=gear.Carmine_LS_hands,
		legs=gear.Herc_MAB_legs,
		feet=gear.Herc_MAB_feet,
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		ear1="Friomisi Earring",
		ear2="Moonshade Earring",
		ring1="Dingir Ring",
		ring2="Regal Ring",
		back=gear.RNG_WSMagic_Cape
	}
	
	sets.precast.WS["Trueflight"].FullTP = set_combine(sets.precast.WS['Trueflight'],{ear2="Hecate's Earring"})
	
	sets.precast.WS['Wildfire'] = sets.precast.WS["Trueflight"].FullTP
	
	--------------------------------------
    -- Midcast sets
    --------------------------------------
	
	sets.midcast.RA = {
		ammo=gear.RAbullet,	
		head="Arcadian Beret +1",
		body="Orion Jerkin +3",
		hands=gear.Adhemar_RA_hands,
		legs=gear.Adhemar_RA_legs,
		feet="Meg. Jam. +2",
		neck="Iskur Gorget",
		ear1="Telos Earring",
		ear2="Enervating Earring",
		ring1="Dingir Ring",
		ring2="Regal Ring",
		back=gear.RNG_RA_Cape,
		waist="Yemaya Belt"
	}
	
	sets.midcast.RA.MidAcc = set_combine(sets.midcast.RA,{
		head="Meghanada Visor +2",
		legs="Meg. Chausses +2"
	})

	sets.midcast.RA.FullAcc = set_combine(sets.midcast.RA.MidAcc,{
		head="Orion Beret +3",
		hands="Orion Bracers +3",
		waist="Kwahu Kachina Belt",
		ring1="Cacoethic Ring +1"
	})
	
	sets.midcast.RA.STP = set_combine(sets.midcast.RA, {
		feet="Carmine Greaves +1",
		ear2="Dedition Earring",
		ring2="Ilabrat Ring",
	})
	
    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
		range="Fomalhaut",
		ammo=gear.RAbullet,
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Carmine Cuisses +1",
		feet="Meg. Jam. +2",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		ear1="Genmei Earring",
		ear2="Etiolation Earring",
		ring1="Defending Ring",
		ring2="Dark Ring",
		back="Moonbeam Cape"
	}
	
	sets.idle.Town = set_combine(sets.idle,{})

    -- Defense sets
    sets.defense.Evasion = {}
    sets.defense.PDT = {}
    sets.defense.MDT = {}

    -- Melee sets
    sets.engaged = {
		head=gear.Adhemar_TP_head,
		body=gear.Adhemar_TP_body,
		hands=gear.Adhemar_TP_hands,
		legs="Samnuha Tights",
		feet=gear.Herc_TP_feet,
		neck="Asperity Necklace",		
		ear1="Brutal Earring",
		ear2="Sherida Earring",
		ring1="Epona's Ring",
		ring2="Petrov Ring",
		back=gear.RNG_TP_Cape,
		waist="Windbuffet Belt +1"
	}
	
	sets.engaged.DW = set_combine(sets.engaged,{ -- Need 21 DW at haste capped
		body=gear.Adhemar_TP_body,		-- 5
		hands="Floral Gauntlets",	-- 5
		ear1="Suppanomimi"			-- 5
	})
	
	sets.engaged.Acc = set_combine(sets.engaged,{})
    sets.engaged.PDT = {}
    sets.engaged.Acc.PDT = {}
	
	sets.Obi = {waist="Hachirin-no-Obi"}
	
	-- Orgnizer set
	organizer_items = {
		-- Weapons
		axe1="Perun +1",
		dagger1="Atoyac",
		dagger2="Kustawi +1",
		dagger3="Malevolence",
		shield="Nusku Shield",
		gun1="Fomalhaut",
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
		obulletpouch="Orichalcum Bullet Pouch"
	}
	
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
		do_bullet_checks(spell, spellMap, eventArgs)
	end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    -- Flurry mode/status check
	if state.FlurryMode.value == 'Flurry II' and (buffactive[265] or buffactive[581]) then
			equip(sets.precast.RA.Flurry2)
	elseif state.FlurryMode.value == 'Flurry I' and (buffactive[265] or buffactive[581]) then
		equip(sets.precast.RA.Flurry1)
	end
	
	-- Obi check
	if spell.type == 'WeaponSkill' then
		if spell.english == 'Trueflight' then
			if world.weather_element == 'Light' or world.day_element == 'Light' then
				equip(sets.Obi)
			end
			if player.tp > 2900 then
				equip(sets.precast.WS["Trueflight"].FullTP)
			end	
		elseif spell.english == 'Wildfire' and (world.weather_element == 'Fire' or world.day_element == 'Fire') then
			equip(sets.Obi)
		end
	end
	
	
end

		

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' and state.Buff.Barrage then
		equip(sets.buff.Barrage)
	end    
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    
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
    if state.Buff[buff] ~= nil then
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
    
end

function display_current_job_state(eventArgs)
    local msg = ''
	
	msg = msg .. '[ Offense/Ranged: '..state.OffenseMode.current..'/'..state.RangedMode.current
	msg = msg .. ' ][ WS: '..state.WeaponskillMode.current
	msg = msg .. ' ][ AutoWS: '..tostring(state.autows.value)

	msg = msg .. ' ]'
	
	add_to_chat(060, msg)
	
    eventArgs.handled = true
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
	local bullet_name
	local bullet_min_count = 1
	
	if spell.type == 'WeaponSkill' then
		if spell.skill == "Marksmanship" then
			if spell.name == 'Trueflight' or spell.name == 'Wildfire' then
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
	elseif spell.action_type == 'Ranged Attack' then
		bullet_name = gear.RAbullet
		if buffactive['Double Shot'] then
			bullet_min_count = 2
		end
	end
	
	local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
	
	-- If no ammo is available, give appropriate warning and end.
	if not available_bullets then
		if spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
			add_to_chat(104, 'No weaponskill ammo ('..bullet_name..') left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
			return
		else
			add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
			eventArgs.cancel = true
			return
		end
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

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 16)
end