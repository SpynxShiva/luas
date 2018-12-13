-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan)
-------------------------------------------------------------------------------------------------------------------

--[[	Custom Features:
		
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
	state.Buff.Saboteur = buffactive.Saboteur or false
	
	enfeebling_magic_acc = S{'Bind', 'Break', 'Dispel', 'Distract', 'Distract II', 'Frazzle',
        'Frazzle II',  'Gravity', 'Gravity II', 'Silence', 'Sleep', 'Sleep II', 'Sleepga'}
    enfeebling_magic_skill = S{'Distract III', 'Frazzle III', 'Poison II'}
    enfeebling_magic_effect = S{'Dia', 'Dia II', 'Dia III', 'Diaga'}

    skill_spells = S{
        'Temper', 'Temper II', 'Enfire', 'Enfire II', 'Enblizzard', 'Enblizzard II', 'Enaero', 'Enaero II',
        'Enstone', 'Enstone II', 'Enthunder', 'Enthunder II', 'Enwater', 'Enwater II'}

end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Seidr', 'Resistant')
	state.IdleMode:options('Normal', 'DT')

	state.WeaponLock = M(false, 'Weapon Lock')	
	state.MagicBurst = M(false, 'Magic Burst')

	-- Additional local binds
	send_command('bind ^m gs c toggle MagicBurst')
	send_command('bind ^c gs c toggle CP')
	send_command('bind ^l gs c toggle WeaponLock')
	
	update_offense_mode()	
	select_default_macro_book()
	set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	
	send_command('unbind ^m')
	send_command('unbind ^c')
	send_command('unbind ^l')
	
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	
	------------------------------------------------------------------------------------------------
	---------------------------------------- Precast Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = {} -- body="Viti. Tabard +1"
	
	-- Fast cast sets for spells
	sets.precast.FC = {
									--FC	QC
		-- Base						  30
		ammo="Impatiens", 			-- 	 	 2
		head="Carmine Mask +1", 	--14
		hands="Leyline Gloves", 	-- 8
		legs="Psycloth Lappas", 	-- 7
		feet=gear.Merl_FC_feet, 	--11 
		neck="Orunmila's Torque", 	-- 5
		ring1="Kishar Ring", 		-- 4
		back="Perimede Cape", 		-- 		 4
		waist="Witful Belt", 		-- 3	 3
	}								-- 82	 9
	
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,{waist="Siegel Sash"})

	sets.precast.FC.Cure = sets.precast.FC
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	sets.precast.FC['Healing Magic'] = sets.precast.FC.Cure
	sets.precast.FC['Elemental Magic'] = sets.precast.FC
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})
	sets.precast.Storm = sets.precast.FC


	------------------------------------------------------------------------------------------------
	------------------------------------- Weapon Skill Sets ----------------------------------------
	------------------------------------------------------------------------------------------------
	
	--[[
	sets.precast.WS = {
		ammo="Yetshila",
        head="Jhakri Coronal +1",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Sherida Earring",
        body="Ayanmo Corazza +2",
		hands="Jhakri Cuffs +2",
		ring1="Begrudging Ring",
		ring2="Hetairoi Ring", 
        back="Kayapa Cape",
		waist="Fotia Belt",
		legs="Jhakri Slops +2",
		feet="Thereoid Greaves"
	}
	
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Savage Blade'] = {
		ammo="Amar Cluster",
        head="Jhakri Coronal +1",
		neck="Caro Necklace",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
        body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		ring1="Rufescent Ring",
		ring2="Ifrit Ring", 
        back="Buquwik Cape",
		waist="Prosilio Belt +1",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2"
	}
	
	sets.precast.WS['Death Blossom'] = 	sets.precast.WS['Savage Blade']
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Sanguine Blade'] = sets.midcast['Elemental Magic']
	
	]]--
	
	------------------------------------------------------------------------------------------------
	---------------------------------------- Midcast Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	
	sets.midcast.FastRecast = sets.precast.FC

	sets.midcast.SpellInterrupt = {}

	sets.midcast.Cure = {
										-- CP	CPR
		head="Gendewitha caubeen +1",	-- 10
		neck="Phalaina Locket",			--	4	  4
		ear2="Mendi. Earring",			--  5
        body="Heka's Kalasiris",		-- 15
		hands="Buremte Gloves",			-- 		 13
		ring1="Kunaji Ring",			--		  5
        waist="Gishdubar Sash",			-- 		 10
		legs="Gyve Trousers",			-- 10
		feet="Medium's sabots"			--  9
	}									-- 53	 32
	
	sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {waist="Hachirin-no-Obi",})

	sets.midcast.CureSelf = sets.midcast.Cure
	
	sets.midcast.Curaga = sets.midcast.Cure

	sets.midcast.StatusRemoval = {neck="Incanter's Torque",}
		
	sets.midcast.Cursna = {waist="Gishdubar Sash",ring1="Purity Ring"}
	
	sets.midcast['Enhancing Magic'] = { 
		-- Base + merit = 			-- 420
		main="Gada",				-- 18
		sub="Ammurapi Shield",	
		head="Befouled Crown", 		-- 16
		neck="Incanter's Torque",	-- 10
		body="Telchine chasuble",	-- 12 
		hands="Chironic Gloves",	-- 15
		ring1="Stikini Ring +1",	-- 8
		ring2="Stikini Ring +1",	-- 8
		ear2="Andoaa Earring",		-- 5
		back="Ghostfyre Cape",		-- 6
		waist="Olympus Sash",		-- 5
		legs="Carmine Cuisses +1", 	-- 18
		feet="Lethargy Houseaux +1",-- 25
									-- 566
	}
	
	sets.midcast.EnhancingDuration = {
		main="Gada",
		sub="Ammurapi Shield",
		head="Telchine Cap",
		body="Telchine chasuble", 
		hands="Atrophy Gloves +2",
		back="Sucellos's Cape",
		legs="Telchine Braconi",
		feet="Lethargy Houseaux +1"
	}
	
	sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
		main="Bolelabunga",
		sub="Ammurapi Shield",
	})

	sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration,{
		head="Amalric Coif",		-- +1
		body="Atrophy Tabard +2",	-- +2
		legs="Leth. Fuseau +1", 	-- +2
	})
	
	sets.midcast.RefreshSelf = set_combine(sets.midcast.Refresh,{
		waist="Gishdubar Sash",
	})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",waist="Siegel Sash",})

	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		main="Vadose Rod",
		sub="Ammurapi Shield",
		head="Amalric Coif",
		waist="Emphatikos Rope"
	})

	sets.midcast.Storm = sets.midcast.EnhancingDuration

	sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {})
	sets.midcast.Protectra = sets.midcast.Protect
	sets.midcast.Shell = sets.midcast.Protect
	sets.midcast.Shellra = sets.midcast.Shell

	-- Custom spell classes
	sets.midcast.MndEnfeebles = {
		main=gear.Grio_enf,sub="Enki Strap",ammo="Pemphredo Tathlum",
        head="Carmine Mask +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Dignitary's Earring",
        body="Lethargy Sayon +1",hands=gear.Chir_nuke_hands,ring1="Kishar Ring",ring2="Stikini Ring +1",
        back=gear.RDM_MND_Cape,waist="Luminary Sash",legs="Chironic Hose",feet="Medium's Sabots"
	}

	sets.midcast.MndEnfeeblesAcc = set_combine(sets.midcast.MndEnfeebles, {body="Atrophy Tabard +2"})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {back=gear.RDM_INT_Cape})

	sets.midcast.IntEnfeeblesAcc = set_combine(sets.midcast.IntEnfeebles, {body="Atrophy Tabard +2"})

	sets.midcast.SkillEnfeebles = set_combine(sets.midcast.MndEnfeebles,{
		sub="Mephitis Grip",
		head="Befouled Crown",
		body="Lethargy Sayon +1",
		hands="Leth. Gantherots +1",
		neck="Incanter's Torque",
		ring1="Stikini Ring +1",
		waist="Rumination Sash",
	})
	
	sets.midcast.SkillEnfeeblesAcc = set_combine(sets.midcast.SkillEnfeebles,{
		body="Atrophy Tabard +2",
	})

	sets.midcast.EffectEnfeebles = {
		body="Lethargy Sayon +1",
		back=gear.RDM_MND_Cape,
	}
	
	sets.midcast.EffectEnfeeblesAcc = {
		body="Atrophy Tabard +2",
		back=gear.RDM_MND_Cape,
	}
	
	sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles

	sets.midcast['Dia III'] = set_combine(sets.midcast.SkillEnfeeblesAcc, {head="Viti. Chapeau +1"})
	sets.midcast['Paralyze II'] = set_combine(sets.midcast.MndEnfeebles, {}) --head="Vitivation Boots +1"
	sets.midcast['Slow II'] = set_combine(sets.midcast.MndEnfeebles, {head="Viti. Chapeau +1"})
	
	sets.midcast['Paralyze II'].Resistant = set_combine(sets.midcast['Paralyze II'], {body="Atrophy Tabard +2"})
	sets.midcast['Slow II'].Resistant = set_combine(sets.midcast['Slow II'], {body="Atrophy Tabard +2"})

	sets.midcast['Dark Magic'] = set_combine(sets.midcast.MndEnfeebles,{
		main="Rubicundity",sub="Genmei Shield",
		neck="Erra Pendant",
		body="Shango Robe",ring1="Evanescence Ring",ring2="Archon Ring",
		back="Perimede Cape",waist="Fucho-No-Obi",feet=gear.Merl_dark_feet
	})
	
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {})
	
	sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Stun = sets.midcast.IntEnfeebles

	sets.midcast['Elemental Magic'] = {
		main=gear.Grio_nuke,
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head=gear.Merl_nuke_head,
		body="Merlinic Jubbah",
		hands=gear.Chir_nuke_hands,
		legs=gear.Merl_nuke_legs,
		feet=gear.Merl_nuke_feet,
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Regal Earring",
		ring1="Shiva Ring +1",
		ring2="Shiva Ring +1",
		back=gear.RDM_INT_Cape,
		waist="Refoccilation Stone",
	}

	sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'], {body="Seidr Cotehardie"})

	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		neck="Sanctity Necklace",ear1="Hermetic Earring"
	})
		
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
		head=empty,
		body="Twilight Cloak",
	})
	
	sets.midcast.Utsusemi = sets.midcast.SpellInterrupt
	
	-- Initializes trusts at iLvl 119
	sets.midcast.Trust = sets.precast.FC
		
	-- Job-specific buff sets
	sets.buff.ComposureOther = {
		--head="Leth. Chappel +1",
		body="Lethargy Sayon +1",
		--hands="Leth. Gantherots +1",
		legs="Leth. Fuseau +1",
		feet="Leth. Houseaux +1",
	}

	sets.buff.Saboteur = {} --hands="Leth. Gantherots +1"

	
	------------------------------------------------------------------------------------------------
	----------------------------------------- Idle Sets --------------------------------------------
	------------------------------------------------------------------------------------------------
	
	sets.idle = {
		main="Bolelabunga",
		sub="Beatific Shield +1",
		ammo="Homiliary",
		head="Viti. Chapeau +1",
		body="Jhakri Robe +2",
		hands=gear.Chir_ref_hands,
		legs="Carmine Cuisses +1",
		feet="Chironic Slippers",
		neck="Loricate Torque +1",
		ear1="Genmei Earring",
		ear2="Etiolation Earring",
		ring1="Defending Ring",
		ring2="Dark Ring",
		back="Moonbeam Cape",
		waist="Flume Belt +1",
	}

	
	sets.idle.DT = set_combine(sets.idle,{
									-- 	PDT	MDT
		ammo="Staunch Tathlum +1",		--	2	2
		head="Gende. Caubeen +1",	--	4	4		
		neck="Loricate Torque +1",	--	6	6
		ear1="Etiolation Earring",	--		3
		ear2="Odnowa Earring +1",	--		2
		body="Ayanmo Corazza +2",	--	5	5
		hands="Gende. Gages +1",	--	4	3
		ring1="Dark Ring",			--	6	4
		ring2="Defending Ring",		--	10	10
		back="Moonbeam Cape",		--	5	5
		legs="Aya. Cosciales +1",	--	4	4
		feet="Gende. Galosh. +1"	--	4	4
	})								--	50	52
	
	
	sets.idle.Town = set_combine(sets.idle, {
		main="Almace",
	})

	sets.idle.Town.DT = set_combine(sets.idle.Town,sets.idle.DT)
	
	sets.idle.Weak = sets.idle.DT

	--[[sets.resting = set_combine(sets.idle, {
		main="Chatoyant Staff",
		waist="Shinjutsu-no-Obi +1",
	})]]--
	
	------------------------------------------------------------------------------------------------
	---------------------------------------- Defense Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	
	sets.defense.PDT = sets.idle.DT
	sets.defense.MDT = sets.idle.DT	
	sets.magic_burst = { 
									--	MB1		MB2
		head=gear.Merl_MB_head,		--	 10
		body="Merlinic Jubbah",		--	  8
		hands="Amalric Gages", 		--			  5
		legs=gear.Merl_MB_legs, 		--	  5
		feet=gear.Merl_MB_feet, 		--	  8
		neck="Mizu. Kubikazari", 	--	 10
		ring1="Mujin Band", 		--			  5
	}								--	 41		 10
	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.latent_refresh = {waist="Fucho-no-obi"}


	------------------------------------------------------------------------------------------------
	---------------------------------------- Engaged Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	
	sets.engaged = {
		main="Almace",
		sub="Beatific Shield +1",
		ammo="Ginsen",
		head="Blistering Sallet +1",
		body="Ayanmo Corazza +2",
		hands="Ayanmo Manopolas +1",
		legs="Carmine Cuisses +1",
		feet="Carmine Greaves +1",
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Sherida Earring",
		ring1="Petrov Ring",
		ring2="Hetairoi Ring",
		back="Bleating Mantle",
		waist="Windbuffet Belt +1",
	}

	sets.engaged.Acc = sets.engaged
	
	-- Assuming capped haste, need 21DW to cap /DNC and 11DW to cap /NIN
	-- Assuming only haste2,  need 41DW to cap /DNC and 31DW to cap /NIN
	sets.engaged.DW = set_combine(sets.engaged, {
		sub="Ternion Dagger +1",		
		legs="Carmine Cuisses +1",	-- 6
		--waist="Reiki Yotai", 		-- 7
		ear1="Suppanomimi",			-- 5
									-- 18
		
	})

	sets.engaged.DW.Acc = sets.engaged.DW
	
	sets.buff.Doom = {waist="Gishdubar Sash"}

	sets.Obi = {waist="Hachirin-no-Obi"}
	sets.CP = {back="Mecisto. Mantle"}
	
	-- Organizer set
	organizer_items = {
	  -- Weapons
	  --Food
	  food="Pear Crepe",
	  -- Meds
	  echos="Echo Drops",
	  remedy="Remedy",
	  --Utils
	  warpr="Warp Ring",
	  teler="Dim. Ring (Dem)",
	  -- Others
	  eobi="Hachirin-No-Obi",
	  ecape="Twilight Cape",
	  ering="Zodiac Ring"
	}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.name == 'Impact' then
		equip(sets.precast.FC.Impact)
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	
	if spell.skill == 'Enfeebling Magic' then
		if enfeebling_magic_skill:contains(spell.english) then
			if state.CastingMode.value == 'Resistant' then
				equip(sets.midcast.SkillEnfeeblesAcc)
			else
				equip(sets.midcast.SkillEnfeebles)
			end
		elseif enfeebling_magic_effect:contains(spell.english) then
            if state.CastingMode.value == 'Resistant' then
				equip(sets.midcast.EffectEnfeebles)
			else
				equip(sets.midcast.EffectEnfeeblesAcc)
			end
			
        end
		
		
		if state.Buff.Saboteur then
			equip(sets.buff.Saboteur)
		end
	end
	
	if spell.skill == 'Enhancing Magic' then
		if classes.NoSkillSpells:contains(spellMap) then
			equip(sets.midcast.EnhancingDuration)
			if spellMap == 'Refresh' then
				equip(sets.midcast.Refresh)
				if spell.target.type == 'SELF' then
					equip (sets.midcast.RefreshSelf)
				end
			end
		end
		if (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and buffactive.Composure then
			equip(sets.buff.ComposureOther)
		end
	end
	
	if spellMap == 'Cure' and spell.target.type == 'SELF' then
		equip(sets.midcast.CureSelf)
	end
	
	if spell.skill == 'Elemental Magic' then
		if state.MagicBurst.value and spell.english ~= 'Death' then
			equip(sets.magic_burst)
			if spell.english == "Impact" then
				equip(sets.midcast.Impact)
			end
		end
		if (spell.element == world.day_element or spell.element == world.weather_element) then
			equip(sets.Obi)
		end
	end
end

function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if spell.english == "Sleep II" then
			send_command('@timers c "Sleep II ['..spell.target.name..']" 120 down spells/00259.png')
		elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
			send_command('@timers c "Sleep ['..spell.target.name..']" 90 down spells/00253.png')
		elseif spell.english == "Break" then
			send_command('@timers c "Break ['..spell.target.name..']" 30 down spells/00255.png')
		end 
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)

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

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	if state.WeaponLock.value == true then
		disable('main','sub')
	else
		enable('main','sub')
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
	if cmdParams[1]:lower() == 'scholar' then
		handle_strategems(cmdParams)
		eventArgs.handled = true
	elseif cmdParams[1]:lower() == 'nuke' then
		handle_nuking(cmdParams)
		eventArgs.handled = true
	end
end

-- Custom spell mapping.
-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return 'CureWeather'
            end
        end
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == "WhiteMagic" then
                if  enfeebling_magic_effect:contains(spell.english) then
                    return "EffectEnfeebles"
                elseif not enfeebling_magic_skill:contains(spell.english) then
                    if (enfeebling_magic_acc:contains(spell.english) and not buffactive.Stymie) or state.CastingMode.value == 'Resistant' then
                        return "MndEnfeeblesAcc"
                    else
                        return "MndEnfeebles"
                    end
                end
            elseif spell.type == "BlackMagic" then
                if  enfeebling_magic_effect:contains(spell.english) then
                    return "EffectEnfeebles"
                elseif not enfeebling_magic_skill:contains(spell.english) then
                    if (enfeebling_magic_acc:contains(spell.english) and not buffactive.Stymie) or state.CastingMode.value == 'Resistant' then
                        return "IntEnfeeblesAcc"
                    else
                        return "IntEnfeebles"
                    end
                end
            else
                return "MndEnfeebles"
            end 
        end
    end
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	update_offense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if player.mpp < 51 then
		idleSet = set_combine(idleSet, sets.latent_refresh)
 	elseif state.CP.current == 'on' then
		equip(sets.CP)
		disable('back')
	else
		enable('back')
	end
	
	return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
	display_current_caster_state()
	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
	-- cmdParams[1] == 'scholar'
	-- cmdParams[2] == strategem to use

	if not cmdParams[2] then
		add_to_chat(123,'Error: No strategem command given.')
		return
	end
	local strategem = cmdParams[2]:lower()

	if strategem == 'light' then
		if buffactive['light arts'] then
			send_command('input /ja "Addendum: White" <me>')
		elseif buffactive['addendum: white'] then
			add_to_chat(122,'Error: Addendum: White is already active.')
		else
			send_command('input /ja "Light Arts" <me>')
		end
	elseif strategem == 'dark' then
		if buffactive['dark arts'] then
			send_command('input /ja "Addendum: Black" <me>')
		elseif buffactive['addendum: black'] then
			add_to_chat(122,'Error: Addendum: Black is already active.')
		else
			send_command('input /ja "Dark Arts" <me>')
		end
	elseif buffactive['light arts'] or buffactive['addendum: white'] then
		if strategem == 'cost' then
			send_command('input /ja Penury <me>')
		elseif strategem == 'speed' then
			send_command('input /ja Celerity <me>')
		elseif strategem == 'aoe' then
			send_command('input /ja Accession <me>')
		elseif strategem == 'addendum' then
			send_command('input /ja "Addendum: White" <me>')
		else
			add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
		end
	elseif buffactive['dark arts']  or buffactive['addendum: black'] then
		if strategem == 'cost' then
			send_command('input /ja Parsimony <me>')
		elseif strategem == 'speed' then
			send_command('input /ja Alacrity <me>')
		elseif strategem == 'aoe' then
			send_command('input /ja Manifestation <me>')
		elseif strategem == 'addendum' then
			send_command('input /ja "Addendum: Black" <me>')
		else
			add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
		end
	else
		add_to_chat(123,'No arts has been activated yet.')
	end
end

function update_offense_mode()  
	if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
		state.CombatForm:set('DW')
	else
		state.CombatForm:reset()
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(1, 13)
end

function set_lockstyle()
	--send_command('wait 2; input /lockstyleset 14')
end