-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:

    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
    
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime

--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	include('Mote-TreasureHunter')

    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    
	state.HasteMode = M{['description']='Haste Mode', 'Haste II', 'Haste I'}
	send_command('bind @h gs c cycle HasteMode')
	
    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')


    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = "Caudata Belt"
	
    -- Additional local binds
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
	send_command('unbind @h')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

    sets.TreasureHunter = {hands="Plunderer's Armlets +1", waist="Chaac Belt", feet="Skulker's Poulaines +1"}
    sets.ExtraRegen = {head="Ocelomeh Headpiece +1"}
    sets.Kiting = {feet="Jute Boots +1"}

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Raider's Bonnet +2"}
    sets.precast.JA['Accomplice'] = {head="Raider's Bonnet +2"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +1"}
    sets.precast.JA['Hide'] = {body="Pillager's Vest +1"}
    sets.precast.JA['Conspirator'] = {} -- {body="Raider's Vest +2"}
    sets.precast.JA['Steal'] = {head="Plunderer's Bonnet",hands="Pillager's Armlets +1",legs="Pillager's Culottes +1",feet="Pillager's Poulaines +1"}
    sets.precast.JA['Despoil'] = {legs="Raider's Culottes +2",feet="Raider's Poulaines +2"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}

	sets.buff['Sneak Attack'] = {
		ammo="Yetshila",
        head="Dampening Tam",
        neck="Caro Necklace",
		ear1="Mache Earring +1",
		ear2="Mache Earring +1",
		body=gear.Adhemar_TP_body, 
        hands=gear.Adhemar_TP_hands,
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
		back=gear.THF_TP_Cape,
		waist="Grunfeld Rope",
		legs="Lustr. Subligar",
        feet="Meghanada Jambeaux +2",
	}
    sets.buff['Trick Attack'] = set_combine(sets.buff['Sneak Attack'],{
		neck="Magoraga Beads",
		ear2="Suppanomimi",
		ring1="Regal Ring",
        ring2="Ilabrat Ring",
		back="Canny Cape",
		waist="Yemaya Belt",
		legs="Meg. Chausses +2",
	})
	sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']
	
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC =  {
		ammo="Sapience Orb",		--	 2
		head=gear.Herc_MAB_head, 	--	 7
		neck="Orunmila's Torque",  	--	 5
		body=gear.Taeon_FC_body,	--	 8
		hands="Leyline Gloves", 	--	 8
		ear1="Loquacious Earring", 	--	 2
	}								--  32
	
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Jukukik Feather",
		head=gear.Adhemar_TP_head,neck="Fotia Gorget", ear1="Moonshade Earring",ear2="Sherida Earring",
		body="Meghanada Cuirie +2",hands="Meg. Gloves +2", ring1="Regal Ring",ring2="Ilabrat Ring",
		back=gear.THF_WS_Cape,waist="Fotia Belt", legs="Samnuha Tights", feet="Meghanada Jambeaux +2"
	}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {back="Canny Cape"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {ammo="Honed Tathlum"})
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'], {ammo="Yetshila"})
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'], {ammo="Yetshila"})
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'], {ammo="Yetshila"})

    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {ammo="Honed Tathlum"})
    sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'], {ammo="Yetshila"})
    sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'], {ammo="Yetshila"})
    sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'], {ammo="Yetshila"})

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Honed Tathlum"})
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'], {})

    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
		ammo="Yetshila",
		neck="Caro Necklace",ear1="Sherida Earring",ear2="Moonshade Earring",
		waist="Grunfeld Rope",legs="Lustratio Subligar +1",feet="Lustratio Leggings +1"
	})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Honed Tathlum", back})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"], {})

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {ear1="Sherida Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {ammo="Honed Tathlum"})
    sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'], {})
    sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'], {})
    sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'], {})

    sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {ear1="Sherida Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {ammo="Honed Tathlum"})
    sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'], {})
    sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'], {})
    sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'], {})

    sets.precast.WS['Aeolian Edge'] = {
		ammo="Ghastly Tathlum +1",
		head=gear.Herc_MAB_head, neck="Sanctity Necklace", ear1="Friomisi Earring", ear2="Hecate's Earring",
		body="Samnuha Coat", hands=gear.Herc_MAB_hands, ring1="Shiva Ring +1", ring2="Shiva Ring +1",
		back="Izdubar Mantle",waist="Eschan Stone",legs=gear.Herc_MAB_legs, feet=gear.Herc_MAB_feet
	}

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

    -- Midcast sets
    sets.midcast.FastRecast = {ear2="Loquacious Earring"}
	sets.midcast.Utsusemi = {ear2="Loquacious Earring"}

    -- Ranged gear
    sets.midcast.RA = {}
    sets.midcast.RA.Acc = {}

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {neck="Wiglen Gorget",ring1="Sheltered Ring",ring2="Paguroidea Ring"}


    -- Idle sets 
    sets.idle = {						-- PDT	MDT
		ammo="Staunch Tathlum +1",			--	2	2
		head="Dampening Tam",			--		4
		body="Meg. Cuirie +2",			--	7
		hands="Meg. Gloves +2",			--	4	
		legs="Meghanada Chausses +2",	--	6
		feet="Jute Boots +1",
		neck="Loricate Torque +1",		--	6	6
		waist="Flume Belt +1",			--	4
		ear1="Genmei Earring",			-- 	2
		ear2="Etiolation Earring",		--		3
		ring1="Defending Ring",			--	10	10
		ring2="Moonlight Ring",			--	4	4
		back="Moonbeam Cape"			--	5	5
	}									--	50	34 capped with Shell 3+
	
	
	sets.idle.Town = set_combine(sets.idle,{})

    -- Defense sets
    sets.defense.Evasion = {}
    sets.defense.PDT = {}
    sets.defense.MDT = {}

	
    -- Melee sets
    
	-- 0 haste - DW req: 49(DW3) - 5 (gift) = 44
	sets.engaged = {				--	DW
		ammo="Yamarang",
		head="Skulker's Bonnet +1",
		neck="Erudition Necklace",
		ear1="Eabani Earring", 		--	4
		ear2="Suppanomimi", 		--	5
		body=gear.Adhemar_TP_body,	--	5
		hands="Floral Gauntlets",	--	5
		ring1="Hetairoi Ring",
		ring2="Epona's Ring",
		back=gear.THF_TP_Cape,
		waist="Reiki Yotai", 		--	7
		legs="Samnuha Tights",
		feet=gear.Herc_TP_feet,
	}								--	26
	sets.engaged.Acc = set_combine(sets.engaged,{
		head="Dampening Tam",
		neck="Combatant's Torque",
		ear1="Telos Earring",
		ring1="Ilabrat Ring",
		legs="Meghanada Chausses +2",
	})
	
	-- 15% haste - DW req: 42(DW3) - 5 (gift) = 37
	sets.engaged.LowHaste = set_combine(sets.engaged,{})
	sets.engaged.Acc.LowHaste = set_combine(sets.engaged.Acc,{})
	
	-- 30% Haste - DW req: 31(DW3) - 5 (gift) = 26
	sets.engaged.HighHaste = set_combine(sets.engaged.LowHaste,{})
	sets.engaged.Acc.HighHaste = set_combine(sets.engaged.Acc.LowHaste,{})
	
	-- Cap Haste - DW req: 11(DW3) - 5 (gift) = 6
	sets.engaged.MaxHaste = set_combine(sets.engaged.HighHaste,{
		ear1="Sherida Earring",
		ear2="Cessance Earring",
		hands=gear.Adhemar_TP_hands,
		waist="Windbuffet Belt +1",
	})
	
	sets.engaged.Acc.MaxHaste = set_combine(sets.engaged.Acc.HighHaste,{
		hands=gear.Adhemar_TP_hands,
		ear2="Cessance Earring",
		waist="Kentarch Belt +1",
	})
	
	--	Hybrid
	sets.engaged.Hybrid = {
		ear2="Suppanomimi",
		body="Meghanada Cuirie +2",		--	7	5
		legs="Meghanada Chausses +2",	--	6
		ammo="Staunch Tathlum +1", 		--	2	2
		neck="Loricate Torque +1", 		--	6	6
		ring1="Defending Ring", 		--	10	10
		ring2="Moonlight Ring",			--	4   4
	}									--	35	27
	
	sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

    sets.engaged.DT.LowHaste = set_combine(sets.engaged.LowHaste, sets.engaged.Hybrid)
    sets.engaged.Acc.DT.LowHaste = set_combine(sets.engaged.Acc.LowHaste, sets.engaged.Hybrid)
    
    sets.engaged.DT.HighHaste = set_combine(sets.engaged.HighHaste, sets.engaged.Hybrid)
    sets.engaged.Acc.DT.HighHaste = set_combine(sets.engaged.Acc.HighHaste, sets.engaged.Hybrid)
    
    sets.engaged.DT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.Acc.DT.MaxHaste = set_combine(sets.engaged.Acc.MaxHaste, sets.engaged.Hybrid)
	
	
	-- Orgnizer set
	organizer_items = {
		-- Weapons
		dagger0="Aeneas",
		dagger1="Jugo Kukri +1",
		dagger2="Taming Sari",
		ranged="Wingcutter",
		-- Meds
		echos="Echo Drops",
		remedy="Remedy",
		-- Food
		sushi="Sublime Sushi",
		atkfood="Red Curry Bun",
		-- Utils
		warpr="Warp Ring",
		teler="Dim. Ring (Dem)",
		-- Ninja tools
		shihei="Shihei",
		sneaktools="Sanjaku-tenugui",
		invisibletools="Shinobi-tabi"
	}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

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
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
--function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    --check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    --check_buff('Sneak Attack', eventArgs)
    --check_buff('Trick Attack', eventArgs)
--end


function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    determine_haste_group()
	th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
    
    msg = msg .. ', TH: ' .. state.TreasureMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
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

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
		equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(2, 8)
end


