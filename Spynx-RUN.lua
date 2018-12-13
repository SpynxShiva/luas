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
	-- /BLU Spell Maps
    blue_magic_maps = {}

    blue_magic_maps.Enmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific',
        'Poison Breath', 'Blitzstrahl', 'Sheep Song', 'Chaotic Eye'}
    blue_magic_maps.Cure = S{'Wild Carrot'}
    blue_magic_maps.Buffs = S{'Cocoon', 'Refueling'}

    rayke_duration = 36
    gambit_duration = 92
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc','FullAcc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.HybridMode:options('Normal', 'DT')
	state.IdleMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT','HP')
	state.MagicalDefenseMode:options('MDT')
	state.CastingMode:options('Normal', 'Quick')
	
	-- Useful states
	state.WeaponLock = M(false, 'Weapon Lock') 
	state.Greatsword = M{['description']='Current Weapon', 'Lionheart', 'Aettir','Epeolatry'}
	state.Runes = M{['description']='Runes', "Ignis", "Gelus", "Flabra", "Tellus", "Sulpor", "Unda", "Lux", "Tenebrae"}
	state.HasteMode = M{['description']='Haste Mode', 'Haste II', 'Haste I'}
	
	-- Additional local binds
    send_command('bind ^` input //gs c rune')
	send_command('bind ^- gs c cycleback Runes')
	send_command('bind ^= gs c cycle Runes')
	send_command('bind @h gs c cycle HasteMode')
	send_command('bind ^g gs c cycle Greatsword')
	send_command('bind @w gs c toggle WeaponLock')
	
    select_default_macro_book()
	set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
	send_command('unbind ^-')
	send_command('unbind ^=')
	send_command('unbind @h')
	send_command('unbind ^g')
	send_command('unbind @2')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    
	--------------------------------------
    -- Precast sets
    --------------------------------------

	sets.precast.FC = {
		ammo="Sapience Orb", 		-- 2
		head="Carmine Mask +1", 	--14
		body=gear.Taeon_FC_body, 	-- 8
		hands="Leyline Gloves", 	-- 8
		legs="Aya. Cosciales +2", 	-- 6
		feet="Carmine Greaves +1", 	-- 8
		neck="Orunmila's Torque", 	-- 5
		ear1="Loquacious Earring", 	-- 2
		ear2="Etiolation Earring",	-- 1
		ring1="Kishar Ring", 		-- 4
		ring2="Prolix Ring",		-- 2
		back=gear.RUN_FC_Cape		--10
									--70
	}
	
	
	sets.precast.FC.HP = set_combine(sets.precast.FC, {
        body="Runeist's Coat +3",	-- -8
        ear1="Odnowa Earring",		-- -2
        ear2="Odnowa Earring +1",	-- -1
        ring2="Moonlight Ring",		-- -2
    })								-- 57
	
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        legs="Futhark Trousers +1",
        waist="Siegel Sash",
	})
	
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		ammo="Impatiens",
		neck="Magoraga Beads",
		waist="Rumination Sash",
	})
	
    -- Precast sets to enhance JAs
    sets.Enmity = {
		ammo="Sapience Orb",		--	2
		head="Halitus Helm",		--	8
		neck="Unmoving Collar +1",	-- 10
		ear1="Cryptic Earring",		--	4
		ear2="Friomisi Earring",	--	2	
		body="Emet Harness +1",		-- 10
		hands="Kurys Gloves",		--	9
		ring1="Provocare Ring",		--	5
		ring2="Begrudging Ring",	--	5
		back=gear.RUN_tank_Cape,	-- 10
		waist="Goading Belt",		--	3
		legs="Erilaz Leg Guards +1",--	7
		feet="Erilaz Greaves +1",	--	6
	}
	
	sets.Enmity.HP = set_combine(sets.Enmity, {
        ear2="Odnowa Earring +1",
        ring1="Moonlight Ring",
        back="Moonbeam Cape",
        waist="Oneiros Belt",
    })
	
	sets.precast.JA['Vallation'] = set_combine(sets.Enmity, {body="Runeist's Coat +3", legs="Futhark Trousers +1", back="Ogma's Cape"})
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
	sets.precast.JA['Pflug'] = set_combine(sets.Enmity, {feet="Runeist Bottes +1"})
    sets.precast.JA['Battuta'] = set_combine(sets.Enmity, {head="Fu. Bandeau +1"})
    sets.precast.JA['Liement'] = set_combine(sets.Enmity, {}) -- body="Futhark Coat +1"
	
	sets.precast.JA['Lunge'] = {
        ammo="Seeth. Bomblet +1",
        head=gear.Herc_MAB_head,
        body="Samnuha Coat",
        hands="Carmine Fin. Ga. +1",
        legs=gear.Herc_MAB_legs,
        feet=gear.Herc_MAB_feet,
        neck="Sanctity Necklace",
        ear1="Hecate's Earring",
        ear2="Friomisi Earring",
        ring1="Mujin Band",
        ring2="Locus Ring",
        back="Argocham. Mantle",
        waist="Eschan Stone",
        }

    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands="Runeist Mitons +1"}
    sets.precast.JA['Rayke'] = {} -- feet="Futhark Boots +1"
    sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity, {})	-- body="Futhark Coat +1"
    sets.precast.JA['Swordplay'] = set_combine(sets.Enmity, {}) -- hands="Futhark Mitons +1"
    sets.precast.JA['Vivacious Pulse'] = set_combine(sets.Enmity, {head="Erilaz Galea +1", neck="Incanter's Torque"}) -- legs="Rune. Trousers +3"
    sets.precast.JA['One For All'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Provoke'] = sets.Enmity

	--------------------------------------
    -- Midcast sets
    --------------------------------------
	
	sets.midcast.FastRecast = sets.precast.FC
	
	sets.midcast.SpellInterrupt = {
        -- Merits					-- 10
		ammo="Impatiens", 			-- 10
        legs="Carmine Cuisses +1", 	-- 20
        ring1="Evanescence Ring", 	-- 5
		ear1="Halasz Earring",		-- 5
        waist="Rumination Sash", 	-- 10
    }								-- 60
	-- Improvements:
	-- Rawhide Gloves				-- 15
	-- Moonbeam Necklace			-- 10
	-- 								   85
	
	sets.midcast['Enhancing Magic'] = { -- Base: 388 + 16 (merits) = 404 
        head="Carmine Mask +1",		-- 11
        neck="Incanter's Torque",	-- 10
		ear1="Andoaa Earring",		-- 5
		hands="Runeist Mitons +1",-- 15
		ring1="Stikini Ring +1",	-- 8
        ring2="Stikini Ring +1",	-- 8
		back="Merciful Cape",		-- 5
		waist="Olympus Sash",		-- 5
		legs="Carmine Cuisses +1",  -- 18
    }
	
	sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'], {
        head="Erilaz Galea +1",		--	15%
        legs="Futhark Trousers +1", --  20%
	})
	
	sets.midcast['Temper'] = set_combine(sets.midcast['Enhancing Magic'], {
		main="Pukulatmuj +1", 
		sub="Chanter's Shield"
    })
	
	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
		main="Deacon Sword",	-- 4
		sub="Chanter's Shield",
		head="Futhark Bandeau +1",	-- 5
	})
	
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
	sets.midcast['Regen'] = set_combine(sets.midcast.EnhancingDuration, {head="Rune. Bandeau +1"})
	sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {waist="Gishdubar Sash"})
	
	sets.midcast.Flash = sets.Enmity
	sets.midcast.Flash.Quick = sets.precast.FC
	
    sets.midcast.Foil = sets.Enmity
	sets.midcast.Utsusemi = sets.midcast.SpellInterrupt
	
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Knobkierrie",
		head=gear.Adhemar_TP_head,
		body=gear.Adhemar_TP_body,
		hands=gear.Herc_Reso_hands,
		legs="Meg. Chausses +2",
		feet=gear.Herc_Reso_feet,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ear1="Moonshade Earring",
		ear2="Sherida Earring",
		ring1="Regal Ring",
		ring2="Niqmaddu Ring",
		back=gear.RUN_STRWS_Cape
	}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		ammo="Seeth. Bomblet +1",
		head="Carmine Mask +1",
		ear1="Telos Earring",
	})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {
		head="Lilitu Headpiece",
        body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
        legs="Lustratio Subligar +1",
        feet="Lustra. Leggings +1",
        neck="Caro Necklace",
        ring1="Ilabrat Ring",
        back=gear.RUN_DEXWS_Cape,
        waist="Grunfeld Rope",
	})
    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'],{
		ammo="Seeth. Bomblet +1",
        body="Meg. Cuirie +2",
        legs="Samnuha Tights",
        feet=gear.Herc_Reso_feet,
        ear2="Telos Earring",
	})
    
    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {					-- 	Refresh	PDT		MDT		BDT
									--	1
		ammo="Homiliary",			--	1
		head="Rawhide Mask",		--	1
		neck="Loricate Torque +1",	--			6		6		6
		ear1="Odnowa Earring +1",	--					2
		ear2="Etiolation Earring",	--					3
		body="Runeist's Coat +3",	--	3
		hands=gear.Herc_Ref_hands,	--	2		2
		ring1="Stikini Ring +1",	--  1
 		ring2="Stikini Ring +1",	--  1
		back="Moonbeam Cape",		--			5		5		5
		waist="Flume Belt +1",		--			4
		legs="Carmine Cuisses +1",	--
		feet=gear.Herc_Ref_feet,	--	2		2
	}								-- 12		19		16		11

	sets.idle.DT	= {
									--	PDT		MDT		BDT
		ammo="Staunch Tathlum +1",		--	2		2		2
		head=gear.Herc_DT_head,		--	4		4		4
		neck="Loricate Torque +1",	--	6		6		6
		ear1="Odnowa Earring +1",	--			2
		ear2="Etiolation Earring",	--			3
		body="Ayanmo Corazza +2",	--	6		6		6
		hands=gear.Herc_DT_hands,	--	6		4		4
		ring1="Defending Ring",		--	10		10		10
		ring2="Moonlight Ring",		--	4		4		4
		back="Moonbeam Cape",		--	5		5		5
		waist="Flume Belt +1",		--	4
		legs="Aya. Cosciales +2",	--	5		5		5
		feet="Turms Leggings +1",		--	
	}								--	52		51		46
	
	sets.idle.Town = set_combine(sets.idle,{})
	sets.idle.Town.DT = set_combine(sets.idle.DT,{})

    -- Defense sets
    sets.defense.PDT = {
									--	PDT		MDT		BDT
		sub="Refined Grip +1", 		--	3		3		3
		ammo="Staunch Tathlum +1",	--	3		3		3
		head=gear.Herc_DT_head,		--	4		4		4
		neck="Loricate Torque +1",	--	6		6		6
		ear1="Genmei Earring",		--	2
		ear2="Ethereal Earring",	--
		body="Futhark Coat +1",		--  7		7		7	
		hands="Turms Mittens +1",	--					
		ring1="Defending Ring",		--	10		10		10
		ring2="Moonlight Ring",		--	5		5		5
		back=gear.RUN_tank_Cape,
		waist="Flume Belt +1",		--	4
		legs="Erilaz Leg Guards +1",--	7
		feet="Turms Leggings +1",
		-- Shell V								24
	}								--	51		61		38
	
	sets.defense.MDT = {
									--	PDT		MDT		BDT
		sub="Refined Grip +1", 		--	3		3		3
		ammo="Staunch Tathlum +1",	--	3		3		3
		head=gear.Herc_DT_head,		--	4		4		4
		neck="Warder's Charm +1",	--					
		ear1="Odnowa Earring +1",	--	        2
		ear2="Ethereal Earring",	
		body="Runeist's Coat +3",
		hands=gear.Herc_DT_hands,	--	6		4		4
		ring1="Defending Ring",		--	10		10		10
		ring2="Moonlight Ring",		--	5		5		5	
		back="Moonbeam Cape",		--	5		5		5
		waist="Engraved Belt",		--
		legs="Erilaz Leg Guards +1",--	7
		feet="Erilaz Greaves +1",	--	5	
		-- Shell V								24
	
	}								--	48		60		34

	
	sets.defense.Parry = {
        -- Base master RUN 99		 	19
		hands="Turms Mittens +1",
        legs="Erilaz Leg Guards +1", --	2
        feet="Turms Leggings +1",	 --	5
        back=gear.RUN_tank_Cape,	 --	8
    }								 --	34 + 56 (battuta) = 90
	
	sets.defense.HP = set_combine(sets.defense.PDT, {
        ear1="Odnowa Earring",
        ear2="Odnowa Earring +1",
		back="Moonbeam Cape",
    })
	
    -- Melee sets
    sets.engaged = {				
		sub="Utu Grip",
		ammo="Yamarang",			
		head=gear.Adhemar_TP_head,  
		neck="Anu Torque",        
		ear1="Cessance Earring",    
		ear2="Sherida Earring",     
		body=gear.Adhemar_TP_body,  
		hands=gear.Adhemar_TP_hands,
		ring1="Epona's Ring",       
		ring2="Niqmaddu Ring",      
		back=gear.RUN_TP_Cape,      
		waist="Windbuffet Belt +1", 
		legs="Samnuha Tights",      
		feet=gear.Herc_TP_feet,     
	}                               
	
	sets.engaged.Acc = set_combine(sets.engaged,{
		head="Dampening Tam",neck="Combatant's Torque",
		waist="Kentarch Belt +1",legs="Meg. Chausses +2",
		ring1="Ilabrat Ring",
	})
	
	sets.engaged.FullAcc = set_combine(sets.engaged.Acc,{
		ring2="Chirich Ring"
	})
	
    sets.engaged.DT = set_combine(sets.engaged,{
									--	PDT		MDT		BDT
		-- Original					--						
		ammo="Staunch Tathlum +1", 	--	2		2
		head="Dampening Tam",		--			4			
		neck="Loricate Torque +1", 	--	6		6		6	
		body="Ayanmo Corazza +2",	--	6		6		6	
		legs="Meg. Chausses +2", 	--	6					
		ring1="Defending Ring",		--	10		10		10
		ring2="Moonlight Ring",  	--	4		4		4
		waist="Ioskeha Belt +1"	
	})								--	34		32		26	
	
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc,sets.engaged.DT)
	sets.engaged.FullAcc.DT = set_combine(sets.engaged.FullAcc,sets.engaged.DT)
	
	sets.buff.Doom = {ring1="Saida Ring", ring2="Purity Ring", waist="Gishdubar Sash"}
	sets.Embolden = set_combine(sets.midcast.EnhancingDuration, {back="Evasionist's Cape"})
	sets.latent_refresh = {waist="Fucho-no-obi"}
	
	-- Orgnizer set
	organizer_items = {
	  -- Weapons
	  greatsword1="Lionheart",
	  greatsword2="Aettir",
	  greatsword3="Epeolatry",
	  -- Food
	  sushi="Sublime Sushi",
	  atkfood="Red Curry Bun",
	  -- Meds
	  holyw="Holy Water",
	  echos="Echo Drops",
	  remedy="Remedy",
	  -- Util
	  warpr="Warp Ring"
	}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------


function job_precast(spell, action, spellMap, eventArgs)
    if state.PhysicalDefenseMode.value == 'HP' then
        eventArgs.handled = true
        if spell.action_type == 'Magic' then
        --    if spell.English == 'Flash' or spell.English == 'Foil' or spell.English == 'Stun'
        --        or blue_magic_maps.Enmity:contains(spell.english) then
        --        equip(sets.Enmity.HP)
        --    else
                equip(sets.precast.FC.HP)
        --    end
        elseif spell.action_type == 'Ability' then
            equip(sets.Enmity.HP)
        end
    end
    if spell.english == 'Lunge' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Swipe" <t>')
--            add_to_chat(122, '***Lunge Aborted: Timer on Cooldown -- Downgrading to Swipe.***')
            eventArgs.cancel = true
            return
        end
    end
    if spell.english == 'Valiance' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Vallation" <me>')
            eventArgs.cancel = true
            return
        elseif spell.english == 'Valiance' and buffactive['vallation'] then
            cast_delay(0.2)
            send_command('cancel Vallation') -- command requires 'cancel' add-on to work
        end
    end
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.PhysicalDefenseMode.value == 'HP' and spell.action_type == 'Magic' then
        eventArgs.handled = true
        equip(sets.Enmity.HP)
    end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        local obi = get_obi(get_rune_obi_element())
        if obi then
            equip({waist=obi})
        end
    end
	
	if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
	
    if spell.english == 'Phalanx' and buffactive['Embolden'] then
        equip(sets.midcast.EnhancingDuration)
    end
	
	
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.name == 'Rayke' and not spell.interrupted then
        send_command('@timers c "Rayke ['..spell.target.name..']" '..rayke_duration..' down spells/00136.png')
        send_command('wait '..rayke_duration..';input /p Rayke: OFF <call21>;')
    elseif spell.name == 'Gambit' and not spell.interrupted then
        send_command('@timers c "Gambit ['..spell.target.name..']" '..gambit_duration..' down spells/00136.png')
        send_command('wait '..gambit_duration..';input /p Gambit: OFF <call21>;')
    end
	
	
	
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	local msg = '[ Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value 
    end
    msg = msg .. ' ][ WS: ' .. state.WeaponskillMode.value .. ' ]'
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
    end
    
    if state.Kiting.value then
        msg = msg .. '[ Kiting Mode ]'
    end
    
    msg = msg .. '[ *' .. state.Runes.current .. '* ]'
    
    add_to_chat(060, msg)

    eventArgs.handled = true
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end


function job_self_command(cmdParams, eventArgs)
	if cmdParams[1]:lower() == 'rune' then
		send_command('@input /ja '..state.Runes.value..' <me>')
	end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
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
	
	if buff == "doom" then
        if gain then           
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

    if buff == 'Embolden' then
        if gain then 
            equip(sets.Embolden)
            disable('head','legs','back')
        else
            enable('head','legs','back')
            status_change(player.status)
        end
    end

	if buff == 'Battuta' and gain then
		handle_equipping_gear(player.status)
	elseif buff == 'Battuta' and not gain then
        status_change(player.status)
    end
	
end

-- Provide details on the haste level
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
        elseif ((buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba']) then
            add_to_chat(122, 'Magic Haste Level: 35%')
        elseif ((buffactive[580] or buffactive[33] or buffactive.march == 2) or
            (buffactive.march == 1 and buffactive[604])) then
            add_to_chat(122, 'Magic Haste Level: 30%')
        elseif (buffactive.march == 1 or buffactive[604]) then
            add_to_chat(122, 'Magic Haste Level: 15%')
        end
    else
        if (buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or
            (buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604])) or
            (buffactive.march == 2 and (buffactive[33] or buffactive[604])) or
            (buffactive[33] and buffactive[604] and buffactive.march ) or buffactive.march == 3 then
            add_to_chat(122, 'Magic Haste Level: 43%')
        elseif ((buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or
            (buffactive.march == 2 and buffactive['haste samba']) or
            (buffactive[580] and buffactive['haste samba'] ) then
            add_to_chat(122, 'Magic Haste Level: 35%')
        elseif (buffactive.march == 2 ) or
            ((buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
            (buffactive[580] ) or  -- geo haste
            (buffactive[33] and buffactive[604]) then
            add_to_chat(122, 'Magic Haste Level: 30%')
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            add_to_chat(122, 'Magic Haste Level: 15%')
        end
    end
end

function get_rune_obi_element()
    weather_rune = buffactive[elements.rune_of[world.weather_element] or '']
    day_rune = buffactive[elements.rune_of[world.day_element] or '']
    
    local found_rune_element
    
    if weather_rune and day_rune then
        if weather_rune > day_rune then
            found_rune_element = world.weather_element
        else
            found_rune_element = world.day_element
        end
    elseif weather_rune then
        found_rune_element = world.weather_element
    elseif day_rune then
        found_rune_element = world.day_element
    end
    
    return found_rune_element
end

function get_obi(element)
    if element and elements.obi_of[element] then
        return (player.inventory[elements.obi_of[element]] or player.wardrobe[elements.obi_of[element]]) and elements.obi_of[element]
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet  = set_combine(idleSet, sets.latent_refresh)
    end
	
	return handle_weapon(idleSet)
end


function customize_melee_set(meleeSet)
    return handle_weapon(meleeSet)
end


function handle_weapon(set)
	-- Equip current GS/grip
	if state.DefenseMode.value ~= 'None' then 
		set  = set_combine(set, {main=state.Greatsword.current,sub="Refined Grip +1"})
	else
		set = set_combine(set, {main=state.Greatsword.current,sub="Utu Grip"})
	end
	
	return set
end

function customize_defense_set(defenseSet)
    if buffactive['Battuta'] then
        defenseSet = set_combine(defenseSet, sets.defense.Parry)
    end
	
	if state.Greatsword.current == 'Epeolatry' then
        equip({main="Epeolatry"})
    elseif state.Greatsword.current == 'Lionheart' then
        equip({main="Lionheart"})
    elseif state.Greatsword.current == 'Aettir' then
        equip({main="Aettir"})
    end
    return defenseSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    determine_haste_group()
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
    set_macro_page(2, 15)
end

function set_lockstyle()
	send_command('wait 2; input /lockstyleset 18')
end
