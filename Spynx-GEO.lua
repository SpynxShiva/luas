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
    indi_timer = ''
    indi_duration = 285
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant','Exp')
    state.IdleMode:options('Normal', 'DT')
 
	state.MagicBurst = M(false, 'Magic Burst')
    
	-- Commands binding
	--  ! = alt, ^ = ctrl, @ = windows key, # = menu key/app key
	
	-- Modes toggle
	send_command('bind ^m gs c toggle MagicBurst')
 
 
    gear.default.obi_waist = "Refoccilation Stone" -- Default obi, will automatically use elemental ones if applicable
	gear.default.obi_ring = "Shiva Ring +1" -- Default ring, will automatically use zodiac ring if applicable
	gear.default.obi_back = gear.GEO_nuke_Cape -- Default cape, will automatically use twilight cape if applicable
 
    select_default_macro_book()
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
 
    --------------------------------------
    -- Precast sets
    --------------------------------------
 
    -- Precast sets to enhance JAs-
    sets.precast.JA.Bolster = {body="Bagua Tunic +1"}
    sets.precast.JA['Life cycle'] = {body="Geomancy Tunic"}
    sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1"}
    sets.precast.JA['Curative Recantation'] = {hands="Bagua Mitaines"}
    sets.precast.JA['Mending Halation'] = {legs="Bagua Pants"}
    sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals"}
     
    -- Fast cast sets for spells
 
    sets.precast.FC = {				-- FC
		sub="Chanter's Shield",		-- 3
        head=gear.Merl_FC_head,		-- 13
		neck="Orunmila's Torque",	-- 5
		ear1="Etiolation Earring",	-- 1
		ear2="Loquacious Earring",	-- 2
        body="Anhur Robe",			-- 10
        ring1="Kishar Ring",		-- 4
		ring2="Prolix Ring",		-- 2
		back="Lifestream Cape",		-- 7
		waist="Witful Belt",		-- 3
		legs="Geomancy Pants",		-- 10
		feet=gear.Merl_FC_feet		-- 11
		-- /RDM						-- 15
	}								-- 86
 
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
 
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {hands="Bagua Mitaines"})
 
     
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    --------------------------------------
    -- Midcast sets
    --------------------------------------
 
    -- Base fast recast for spells
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
	sets.midcast.Bolster = {body="Bagua Tunic +1"}
	sets.midcast.Bolster.Pet = {body="Bagua Tunic +1"}
	sets.midcast.Bolster.Pet.Indi = {body="Bagua Tunic +1"}
 
    sets.midcast.Geomancy = {
		main="Idris", sub="Genmei Shield", range="Dunna",
		head="Azimuth Hood +1",neck="Incanter's Torque",
		body="Bagua Tunic +1",hands="Geomancy Mitaines +2",
        back="Lifestream Cape",waist="Austerity Belt +1",legs="Bagua Pants",feet="Medium's Sabots"}
     
    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {feet="Azimuth Gaiters"}) 
     
    sets.midcast.Cure = {
		body="Heka's Kalasiris",		-- 15
		hands=gear.Telchine_CPR_hands,	-- 10 (7)
		legs="Gyve Trousers", 			-- 10
		feet="Medium's Sabots", 		-- 9
		neck="Phalaina Locket", 		-- 4 (4)
		ring1="Kunaji Ring",			-- 0 (5)
		back="Solemnity Cape",			-- 7
		waist="Gishdubar Sash" 			-- 0 (10)
	}
										-- 55 (26)
     
    sets.midcast.Curaga = sets.midcast.Cure
 
	-- Elemental Magic sets
     
    sets.midcast['Elemental Magic'] = {
		main=gear.Grio_nuke,sub="Enki Strap",ammo="Pemphredo Tathlum",
        head=gear.Merl_nuke_head, neck="Sanctity Necklace", ear1="Barkaro. Earring", ear2="Regal Earring",
		body=gear.Amal_nuke_body, hands=gear.Amal_nuke_hands, ring1=gear.ElementalRing, ring2="Shiva Ring +1",
		back=gear.GEO_nuke_Cape, waist=gear.ElementalObi, legs=gear.Amal_nuke_legs,	feet=gear.Amal_nuke_feet,
	}
	
	sets.midcast['Elemental Magic'].Exp = set_combine(sets.midcast['Elemental Magic'],{body="Seidr Cotehardie"})
 
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		legs=gear.Merl_nuke_legs,
		feet=gear.Merl_nuke_feet,
		waist="Eschan Stone",
	})
	
	
	sets.magic_burst = {
		main=gear.Grio_MB,			-- 8
		sub="Enki Strap",
		neck="Mizu. Kubikazari",	-- 10
		head=gear.Merl_MB_head,		-- 10
		hands=gear.Amal_nuke_hands, -- 0 (6)
		feet=gear.Merl_MB_feet,		-- 8
		ring1="Mujin Band", 		-- 0 (5)
		ring2="Locus Ring",			-- 5
	} 
									-- 41 (11) -> capped
	
	
	-- Custom Spell Classes
    sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Elemental Magic'], {
		main=gear.Grio_enf,sub="Enki Strap",ammo="Pemphredo Tathlum",
		head="Amalric Coif +1",neck="Incanter's Torque",ear1="Regal Earring",ear2="Dignitary's Earring",
        body=gear.Amal_nuke_body,hands="Jhakri Cuffs +2",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.GEO_nuke_Cape,waist="Luminary Sash",legs="Psycloth Lappas",feet=gear.Merl_nuke_feet
	})
	
	sets.midcast['Enhancing Magic'] = {
		main="Gada",sub="Ammurapi Shield",
		head=gear.Telchine_enh_head,neck="Incanter's Torque",
		body=gear.Telchine_enh_body, hands=gear.Telchine_enh_hands,
		back="Perimede Cape",waist="Olympus Sash",legs=gear.Telchine_enh_legs, feet=gear.Telchine_enh_feet
	}
	
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
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		main="Vadose Rod",		--	1
		sub="Ammurapi Shield",
		head="Amalric Coif +1",	--	2
		legs="Shedir Seraweels",--	1
		waist="Emphatikos Rope",--	1
	})
	
	sets.midcast['Dark Magic'] = set_combine(sets.midcast['Enfeebling Magic'],{
		main="Rubicundity",sub="Genmei Shield",
		head="Bagua Galero",neck="Erra Pendant",
		body=gear.Amal_dark_body,hands=gear.Amal_dark_hands,ring1="Evanescence Ring",ring2="Archon Ring",
		waist="Fucho-No-Obi",legs=gear.Amal_dark_legs,feet=gear.Merl_dark_feet
	})
	
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {})
	
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})
	
	--------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
	
	sets.DT = {
		sub="Genmei Shield",		--10
		neck="Loricate Torque +1",	-- 6	6
		body="Mallquis Saio +2",	-- 8	8
		ring1="Defending Ring",		--10	10
		ring2="Dark Ring",			-- 6	4
		legs="Artsieq Hose",		-- 5
		back="Moonbeam Cape"		-- 5	5
		-- Shell2					--		14
									--50	47
	}
 
    -- Resting sets
    sets.resting = {}

    -- Idle sets
    sets.idle = {
		main="Bolelabunga", sub="Genmei Shield",range="Dunna",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Jhakri Robe +2",hands="Bagua Mitaines",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Moonbeam Cape",waist="Witful Belt",legs="Assiduity Pants +1",feet="Geomancy Sandals +1"
	}
 
	sets.idle.DT = set_combine(sets.idle,sets.DT)
	
	sets.idle.Town = set_combine(sets.idle, {
        main="Idris", sub="Ammurapi Shield",
		head="Azimuth Hood +1",neck="Incanter's Torque",
		body="Bagua Tunic +1"    
    })
    
	sets.idle.Weak = set_combine(sets.idle, {})

	-- .Pet sets are for when Luopan is present.
    sets.idle.Pet = set_combine(sets.idle, {
        main="Idris", sub="Genmei Shield",
		head="Azimuth Hood +1",ear1="Handler's Earring",ear2="Handler's Earring +1",
        hands="Geomancy Mitaines +2",
        back=gear.GEO_pet_Cape,waist="Isa Belt",feet="Bagua Sandals"
    })

    sets.idle.DT.Pet = set_combine(sets.idle.Pet,sets.DT)

    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = set_combine(sets.idle, {
        main="Idris", sub="Genmei Shield",
		legs="Bagua Pants", 
        back=gear.GEO_pet_Cape,
        feet="Azimuth Gaiters"
    })
	sets.idle.DT.Indi = set_combine(sets.idle.Indi,sets.DT)
	
    -- .Pet sets are for when Luopan is present.
	sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {legs="Bagua Pants"})
    sets.idle.DT.Pet.Indi = set_combine(sets.idle.Pet.Indi, sets.DT)

    -- Defense sets
    sets.defense.PDT = set_combine(sets.idle, {})
	sets.defense.MDT = set_combine(sets.idle, {})
    sets.Kiting = {feet="Geomancy Sandals +1"}
 
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
    --------------------------------------
    -- Engaged sets
    --------------------------------------
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
 
    -- Normal melee group
    sets.engaged = set_combine(sets.idle, {main="Idris",hands="Geomancy Mitaines +2"})
 
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
 
	organizer_items = {
	  echos="Echo Drops",
	  remedy="Remedy",
	  warpr="Warp Ring",
	  teler="Dim. Ring (Dem)",
	  food="Pear Crepe",
	  obi_waist = "Refoccilation Stone",
	  obi_ring = "Shiva Ring +1"
	}
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Equip MB gear if MB status flagged
	if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
	
end
 
 
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end
 
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        end
    end
end
 
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
	
	return idleSet
end
 
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end
 
-- Function to display the current relevant user state when doing an update.
-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    -- Display MB status
	if state.MagicBurst.value == true then
        add_to_chat(122, 'Magic Burst: [On]')
    elseif state.MagicBurst.value == false then
        add_to_chat(122, 'Magic Burst: [Off]')
    end

	display_current_caster_state()
    eventArgs.handled = true
end


--- ..:: Luopan Notifier ::.. ---
function pet_change(pet,gain_or_loss)
	status_change(player.status)
	if not gain_or_loss then
		add_to_chat(123,'Your luopan has vanished.')
	end
end

 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 9)
end
