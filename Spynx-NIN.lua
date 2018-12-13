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
    -- Buffs: state.Buff.<BUFF_NAME> = buffactive.<BUFF_NAME> or false
	run_sj = player.sub_job == 'RUN' or false	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'MidAcc','HighAcc','Crit')
    state.WeaponskillMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
	  
	state.CapacityMode = M(false, 'Capacity Point Mantle')
	state.MagicBurst = M(false, 'Magic Burst')
	state.AbyProc = M(false, 'Abyssea Proc')
	state.AbyProcWeapons = M{['description']='Abyssea Proc Weapon', 'Dagger', 'Sword', 'Scythe', 'Polearm', 'Katana', 'Great Katana', 'Club','Staff'}
	AbyProcWeaponsGear = { 
		["Dagger"] = {main="Twilight Knife",sub="Kunai"},
		["Sword"] = {main="Excalipoor",sub="Kunai"},
		["Scythe"] = {main="Ark Scythe",sub="Bloodrain Strap"},
		["Polearm"] = {main="Pitchfork +1",sub="Bloodrain Strap"},
		["Katana"] = {main="Kunai",sub="Excalipoor"},
		["Great Katana"] = {main="Sukesada",sub="Bloodrain Strap"},
		["Club"] = {main="Nomad moogle rod",sub="Kunai"},
		["Staff"] = {main="Terra's Staff",sub="Bloodrain Strap"}
	}
	
	-- COMMANDS BINDING
	-- ! = alt, ^ = ctrl, @ = windows key, # = menu key/app key
	send_command('bind ^c gs c toggle CapacityMode')
	send_command('bind ^m gs c toggle MagicBurst')
	send_command('bind !h gs c cycle HasteMode')
	
	send_command('bind ^p gs c toggle AbyProc')
	send_command('bind ^- gs c cycleback AbyProcWeapons')
	send_command('bind ^= gs c cycle AbyProcWeapons')
	
	
	gear.default.obi_waist = "Refoccilation Stone"
	
	state.HasteMode = M{['description']='Haste Mode', 'Haste II', 'Haste I'}
	
	select_default_macro_book()
end

-- All the bound keys should be unbound here
function user_unload()
	-- Unbind for CP cape: send_command('unbind ^c')
	-- Unbind for MB :send_command('unbind ^m')
	send_command('unbind ^c')
	send_command('unbind ^m')
	send_command('unbind !h')
	send_command('unbind ^p')
	send_command('unbind ^-')
	send_command('unbind ^=')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	------------------
	-- PRECAST
	------------------
	
    -- JA PRECAST
    -- Job Ability: 
	sets.precast.JA['Futae'] = { hands="Iga Tekko +2" }
    sets.precast.JA['Provoke'] = { 
		ear1="Friomisi Earring",ring1="Petrov Ring"
	}
	
    -- FC PRECAST
	-- Spell FC
    sets.precast.FC = {
		-- Kanaria offhand			-- 5
		ammo="Sapience Orb",		-- 2
		head=gear.Herc_MAB_head,	-- 7
		neck="Orunmila's Torque",	-- 5
		ear1="Etiolation Earring",	-- 1
		ear2="Loquacious Earring",	-- 2
        body=gear.Taeon_FC_body,	-- 8
		hands="Leyline Gloves",		-- 8
		ring1="Kishar Ring",		-- 4
		legs="Gyve Trousers"		-- 4 
	}								--46	
	-- Spell-type specific FC
    sets.precast.FC['Ninjutsu'] = sets.precast.FC
	-- Spell-specific FC (based on english-name)
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads"})
	
	-- Spell Fast Recast (for magic that do not need any buff except casting time)
	sets.midcast.FastRecast = sets.precast.FC
	
	------------------
	-- MIDCAST MAGIC
	------------------
	-- skill ++ 
    sets.midcast.Ninjutsu = {
        head=gear.Herc_MAB_head,neck="Incanter's Torque",ear1="Dignitary's Earring",ear2="Hermetic Earring",
        body="Samnuha Coat",hands="Leyline Gloves", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
        back="Yokaze Mantle",legs=gear.Herc_MAB_legs,feet=gear.Herc_MAB_feet
    }
    
	-- any ninjutsu cast on self
    sets.midcast.SelfNinjutsu = sets.midcast.Ninjutsu
    
	sets.midcast.Utsusemi = {
        hands="Mochizuki Tekko", 
        back="Andartia's Mantle",
        feet="Hattori Kyahan"
    }
	
    sets.midcast.Migawari = set_combine(sets.midcast.Ninjutsu, {body="Iga Ningi +2"})

    -- Nuking Ninjutsu (skill & magic attack)
    sets.midcast.ElementalNinjutsu = {
        ammo="Pemphredo Tathlum",
		head=gear.Herc_MAB_head, neck="Incanter's Torque", ear1="Friomisi Earring", ear2="Hecate's Earring",
		body="Samnuha Coat", hands="Leyline Gloves", ring1="Shiva Ring +1", ring2="Shiva Ring +1",
		back="Izdubar Mantle", waist=gear.ElementalObi, legs=gear.Herc_MAB_legs, feet=gear.Herc_MAB_feet
    }

	sets.magic_burst = { 
		ring1="Mujin Band",
		waist=gear.ElementalObi
	}
	
	-- Effusions
    sets.precast.Effusion = {}
    sets.precast.Effusion.Lunge = sets.midcast.ElementalNinjutsu
    sets.precast.Effusion.Swipe = sets.midcast.ElementalNinjutsu
	
	------------------
	-- IDLE
	------------------
	sets.idle.Town = set_combine(sets.engaged,{feet="Danzo Sune-ate"})
	
	sets.idle.Field = sets.idle.Town
    sets.idle.Field.PDT = set_combine(sets.idle.Field,{})
    sets.idle.Weak = sets.idle.Field.PDT
	sets.resting = {}
	
	------------------
	-- RANGE ATK
	------------------
	sets.precast.RA = {}
    sets.midcast.RA = {}
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {})
	
	------------------
	-- ENGAGED
	------------------	
	
	-- Reference
	-- 1DEX = 0.75acc
	-- 1STR = 0.75atk
	
	-- No haste, 39DW to cap
	sets.engaged = {				--	Acc		Atk		DA		TA		QA		STP		Haste	DW
		ammo="Seki Shuriken",		--	5		5
		head=gear.Adhemar_TP_head,		--	28		63				3
		neck="Moonlight Nodowa",	
		ear1="Suppanomimi",			--															5							
		ear2="Brutal Earring",		--					5						1
		body="Kendatsuba Samue +1",	--	79		44 				3						4		5
		hands="Floral Gauntlets",	--															5
		ring1="Petrov Ring", 		--	3		3		1						5
		ring2="Epona's Ring",		-- 					3		3
		back="Andartia's Mantle",	--	38		20		10
		waist="Reiki Yotai",		--															7
		legs="Kendatsuba Hakama +1",		--	29		36		3		3				7		6
		feet=gear.Herc_TP_feet		--	53  	43 				6 						4
	}	--																						22
		
		--	head="Ryuo Somen"		--															8
		--  feet="Hizamaru sune-ate +1"--														7
		
	sets.engaged.MidAcc =  set_combine(sets.engaged,{head="Dampening Tam",ring1="Chirich Ring",ear2="Cessance Earring",feet=gear.Herc_acc_feet})
	sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc,{ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",legs="Hiza. Hizayoroi +1"})
	
	-- Haste I, 32DW to cap
	sets.engaged.LowHaste = {
		ammo="Seki Shuriken",		--	5		5
		head=gear.Adhemar_TP_head,		--	28		63				3
		neck="Moonlight Nodowa",	--			10								6		8
		ear1="Suppanomimi",			--															5							
		ear2="Brutal Earring",		--	10		10		1						5
		body="Kendatsuba Samue +1",	--	79		44 				3						4		5
		hands="Floral Gauntlets",	--															5
		ring1="Petrov Ring", 		--	3		3		1						5
		ring2="Epona's Ring",		-- 					3		3
		back="Andartia's Mantle",	--	38		20		10
		waist="Reiki Yotai",		--															7
		legs="Samnuha Tights",		--	29		36		3		3				7		6
		feet=gear.Herc_TP_feet		--	53  	43 				6 						4
	}	--																						22
	sets.engaged.MidAcc.LowHaste =  set_combine(sets.engaged.LowHaste,{head="Dampening Tam",ring1="Chirich Ring",ear2="Cessance Earring",feet=gear.Herc_acc_feet})
	sets.engaged.HighAcc.LowHaste = set_combine(sets.engaged.MidAcc.LowHaste,{ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",legs="Hiza. Hizayoroi +1"})
	
	
	
	-- Haste II, 21DW to cap
	sets.engaged.HighHaste = {		--	Acc		Atk		DA		TA		QA		STP		Haste	DW
		ammo="Seki Shuriken",		--	5		5
		head=gear.Adhemar_TP_head,		--	28		63				3
		neck="Moonlight Nodowa",	--			10								6		8
		ear1="Suppanomimi",			--															5							
		ear2="Brutal Earring",		--	10		10		1						5
		body="Kendatsuba Samue +1",		--	79		44 				3						4		5
		hands="Floral Gauntlets",	--															5
		ring1="Ilabrat Ring", 		--	3		3		1						5
		ring2="Epona's Ring",		-- 					3		3
		back="Andartia's Mantle",	--	38		20		10
		waist="Reiki Yotai",		--															7
		legs="Samnuha Tights",		--	29		36		3		3				7		6
		feet=gear.Herc_TP_feet		--	53  	43 				6 						4
	}	--																						22
	
	sets.engaged.MidAcc.HighHaste =  set_combine(sets.engaged.HighHaste,{head="Dampening Tam",ring1="Chirich Ring",ear2="Cessance Earring",feet=gear.Herc_acc_feet})
	sets.engaged.HighAcc.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste,{ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",legs="Hiza. Hizayoroi +1"})
	
	-- Capped haste, 1DW to cap
	sets.engaged.MaxHaste = {		--	Acc		Atk		DA		TA		QA		STP		Haste	DW
		ammo="Seki Shuriken",		--	5		5
		head=gear.Adhemar_TP_head,	--	28		63				3
		neck="Moonlight Nodowa",		--			10								6		8
		ear1="Dedition Earring",	--	-10		-10								8		
		ear2="Brutal Earring",		--	10		10		1						5
		body="Kendatsuba Samue +1",	--	75 		36 				3				3		4
		hands=gear.Adhemar_TP_hands,--	84 		11				3				6		5
		ring1="Ilabrat Ring", 		--	3		3		1						5
		ring2="Epona's Ring",		-- 					3		3
		back="Andartia's Mantle",	--	38		20		10
		waist="Windbuffet Belt +1",	--	2						2		2
		legs="Samnuha Tights",		--	29		36		3		3				7		6
		feet=gear.Herc_TP_feet		--	53  	43 				6 						4
	}
	
	sets.engaged.MidAcc.MaxHaste =  set_combine(sets.engaged.MaxHaste,{head="Dampening Tam",ring1="Chirich Ring",ear1="Cessance Earring",feet=gear.Herc_acc_feet,waist="Kentarch Belt +1"})
	sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste,{ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",legs="Hiza. Hizayoroi +1",ear2="Telos Earring"})
	
	------------------
	-- WS
	------------------	
	sets.precast.WS = {
		ammo="Jukukik Feather",
        head=gear.Adhemar_TP_head,neck="Fotia Gorget",ear2="Brutal Earring",ear1="Moonshade Earring",
        body=gear.Herc_CDC_body,hands=gear.Herc_CDC_hands,ring1="Begrudging Ring",ring2="Epona's Ring",
        back="Andartia's Mantle",waist="Fotia Belt",legs="Jokushu Haidate",feet=gear.Herc_TP_feet
	}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS,{})
	
	-- WS Specific
	sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Blade: Jin'].Acc = set_combine(sets.precast.WS['Blade: Jin'], {})
	
	sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {ear1="Lugra Earring",ear2="Lugra Earring +1"})
    sets.precast.WS['Blade: Shun'].Acc = set_combine(sets.precast.WS['Blade: Shun'], {})
	
	sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, {
		ammo="Seeth. Bomblet +1",
		neck="Caro Necklace",
		ear1="Ishvara Earring",
		ring1="Regal Ring",
		ring2="Ilabrat Ring",
		waist="Grunfeld Rope",
		legs="Hiza. Hizayoroi +1",
	})
	
    sets.precast.WS['Blade: Ten'].Acc = set_combine(sets.precast.WS['Blade: Ten'], {})
	
	sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS['Blade: Ten'], {})
	sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS['Blade: Hi'], {})
	
	
	------------------
	-- MISC
	------------------	
	-- Organizer items to always have in inventory:
	organizer_items = {
        -- Weapons
		weapon1="Heishi Shorinken",
		weapon2={ name="Kanaria", augments={'"Triple Atk."+3','STR+4','Accuracy+11','Attack+16','DMG:+12',}},
		weapon3="Ochu",
		weapon4="Ochu",
		-- Meds
		echos="Echo Drops",
		remedy="Remedy",
		-- Food
		sushi="Sublime Sushi",
		hqsushi="Sublime Sushi +1",
		atkfood="Red Curry Bun",
		-- Utils
		warpr="Warp Ring",
		teler="Dim. Ring (Dem)",
		-- Ninja tools
		shihei="Shihei",
        inoshi="Inoshishinofuda",
        shika="Shikanofuda",
        chono="Chonofuda",
		-- Aby proc
		daggerAbyProc="Twilight Knife",
		swordAbyProc="Excalipoor",
		scytheAbyProc="Ark Scythe",
		polearmAbyProc="Pitchfork +1",
		katanaAbyProc="Kunai",
		GkatanaAbyProc="Sukesada",
		clubAbyProc="Nomad moogle rod",
		staffAbyProc="Terra's Staff",
		strapAbyProc="Bloodrain Strap"
    }
end

-------------------------------------------------------------------------------------------------------------------
-- Precast/Midcast/Aftercast functions
-------------------------------------------------------------------------------------------------------------------

-- Runs after the general precast; can be used to equip custom gear after the standard precast is done
function job_post_precast(spell, action, spellMap, eventArgs)
	
    if spell.name == 'Spectral Jig' and buffactive.sneak then
        -- If sneak is active when using, cancel before completion
        send_command('cancel 71')
    end
    
	--if string.find(spell.english, 'Utsusemi') then
    --    if buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
    --        cancel_spell()
    --        eventArgs.cancel = true
    --        return
    --    end
    --end
end

-- Runs after the general midcast
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spellMap == "ElementalNinjutsu" and state.MagicBurst.value then
        equip(sets.magic_burst)
	end	
	
	if spell.action_type == 'Magic' then
        equip(sets.midcast.FastRecast)
    end
	
    if spell.english == "Monomi: Ichi" then
        if buffactive['Sneak'] then
            send_command('@wait 1.7;cancel sneak')
        end
    end
	
	if string.find(spell.english, 'Utsusemi') then
		equip({hands="Koga tekko +2"})
	end
	
end

-- Runs after the general aftercast
function job_post_aftercast(spell, action, spellMap, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Idle set customization
-------------------------------------------------------------------------------------------------------------------
function customize_idle_set(idleSet)
    -- Example: Latent refresh based on MP% 
	if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
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
    end
end

-- Function triggered by any state change
function job_state_change(stateField, newValue, oldValue)
    -- Aby proc management
	if state.AbyProc.value and state.AbyProcWeapons.current then
        equip(AbyProcWeaponsGear[state.AbyProcWeapons.current])
	else 
		equip({
			main="Heishi Shorinken",
			sub="Ochu"--{ name="Kanaria", augments={'"Triple Atk."+3','STR+4','Accuracy+11','Attack+16','DMG:+12',}}
		})
	end
end

function job_update(cmdParams, eventArgs)
    determine_haste_group()
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


-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    -- Display MB status upon change
	if state.MagicBurst.value == true then
        add_to_chat(122, 'Magic Burst: [On]')
    elseif state.MagicBurst.value == false then
        add_to_chat(122, 'Magic Burst: [Off]')
    end

	-- Display MB status upon change
	if state.AbyProc.value == true then
        add_to_chat(122, 'Aby Proc: [On]')
    elseif state.AbyProc.value == false then
        add_to_chat(122, 'Aby Proc: [Off]')
    end
	
	if state.AbyProcWeapons.current ~= nil then
		add_to_chat(104, 'Current Abyssea Proc Weapon:'..state.AbyProc.current)
	end
	
	-- Display haste level
	if state.AbyProc.value == true then
        add_to_chat(122, 'Aby Proc: [On]')
    elseif state.AbyProc.value == false then
        add_to_chat(122, 'Aby Proc: [Off]')
    end
	msg = msg .. '[ ' .. state.HasteMode.value .. ' ]'

    msg = msg .. '[ *'..state.Mainqd.current
	
    eventArgs.handled = true
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
	set_macro_page(1, 4)
end