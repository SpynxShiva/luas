-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
	include('Mote-TreasureHunter')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Hasso'] = buffactive['hasso'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')


	send_command('bind ^t gs c cycle TreasureMode')

    select_default_macro_book()
	set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^z')
    send_command('unbind ^x')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

	sets.TreasureHunter = {
		body="Volte Jupon",		-- 2
		waist="Chaac Belt", 	-- 1
	}
    
	--------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    --sets.precast.JA['Hasso'] = {}
    sets.precast.JA['Meditate'] = {
		head="Wakido Kabuto +1",
		hands="Sakonji Kote +1",
		back=gear.SAM_TP_Cape,
	}

    -- Weaponskill sets
  sets.precast.WS = {
		ammo="Knobkierrie",
		head=gear.Valor_WSD_head,
		body="Sakonji Domaru +3",
		hands=gear.Valor_WSD_hands,
		legs="Wakido Haidate +3",
		feet=gear.Valor_WSD_feet,
		neck="Sam. Nodowa +2",
		waist="Fotia Belt",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
		ring1="Karieyh Ring +1",
		ring2="Epaminondas's Ring",
		back=gear.SAM_WS_Cape,
	}

	sets.precast.WS.Acc = set_combine(sets.precast.WS,{ring2="Regal Ring"})
	
    -- Specific weaponskill sets.
    sets.precast.WS['Tachi: Jinpu'] = {
		ammo="Knobkierrie",
		head=gear.Valor_WSD_head,
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
		body="Found. Breastplate",
		hands="Founder's Gauntlets",
		ring1="Karieyh Ring +1",
		ring2="Epaminondas's Ring",
		waist="Fotia Belt",
		legs="Wakido Haidate +3",
		feet="Founder's Greaves",
		back=gear.SAM_WS_Cape,
	}
	
	sets.precast.WS['Tachi: Shoha'] = {
		ammo="Knobkierrie",
		head="Flamma Zucchetto +2",
		neck="Sam. Nodowa +2",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
		body="Sakonji Domaru +3",
		hands=gear.Valor_WSD_hands,
		ring1="Flamma Ring",
		ring2="Niqmaddu Ring",
		waist="Fotia Belt",
		legs="Wakido Haidate +3",
		feet="Flam. Gambieras +2",
		back=gear.SAM_WS_Cape,
	}
	
	sets.precast.WS['Stardiver'] = sets.precast.WS['Tachi: Shoha']
	
	sets.WSfullTP = {ear1='Odnowa Earring +1'}
	sets.WSfullTPnight = {ear1='Lugra Earring +1'}
	
	
    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------
    -- Idle sets
    sets.idle = {						--	PDT		MDT
		ammo="Staunch Tathlum +1",		--	3		3
		head="Kendatsuba Jinpachi +1",	--			
		neck="Loricate Torque +1",		--	6		6
		left_ear="Etiolation Earring",	-- 			3
		right_ear="Genmei Earring",		--	2
		body="Wakido Domaru +3",		--	8		8
		hands="Wakido Kote +3",			--	
		ring1="Defending Ring",			--	10		10	
		ring2="Gelatinous Ring +1",		--	7		-1
		legs="Kendatsuba Hakama +1",	--	
		feet="Kendatsuba Sune-ate +1",	--	
		waist="Flume Belt +1",			--	4
		back=gear.SAM_TP_Cape,			--	10		
	}									--	50		29	
	
    -- Defense sets
    sets.defense.PDT = sets.idle
	sets.defense.MDT = sets.idle
    
	sets.engaged = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Kasuga Domaru +1",
		hands="Wakido Kote +3",
		legs="Ryuo Hakama +1",
		feet="Ryuo Sune-Ate +1",
		neck="Moonlight Nodowa",
		waist="Ioskeha Belt +1",
		ear1="Dedition Earring",
		ear2="Telos Earring",
		ring1="Flamma Ring",
		ring2="Niqmaddu Ring",
		back=gear.SAM_TP_Cape
	}
	
	sets.engaged.LowAcc = set_combine(sets.engaged,{
		neck="Sam. Nodowa +2",
		body="Ken. Samue +1",
		legs="Ken. Hakama +1"
	})
	
	sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc,{
		ear1="Cessance Earring",
		feet="Flam. Gambieras +2"
	})
	
	sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc,{
		head="Ken. Jinpachi +1",
		ring1="Regal Ring",
		feet="Ken. Sune-Ate +1"
	})
	
	sets.idle.Town = sets.engaged.MidAcc
		
	sets.engaged.DT = sets.idle
	sets.engaged.LowAcc.DT = sets.idle
	sets.engaged.MidAcc.DT = sets.idle
	sets.engaged.HighAcc.DT = sets.idle
	
	
	sets.WakeSleep = {neck="Vim Torque +1"}
	
	-- Orgnizer set
	organizer_items = {
		-- Weapons
		gkt1="Masamune",
		gkt2="Dojikiri Yasutsuna",
		gkt3="Norifusa +1",
		polearm="Shining One",
		grip="Utu Grip",
		-- Food and meds
		acc_food="Sublime Sushi",
		atk_food="Red Curry Bun",
		remedy="Remedy"
	}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
		-- Already full tp -> swap moonshade out
		if player.tp > 2900 or ( player.tp > 2400 and player.equipment.main == 'Dojikiri Yasutsuna') then
			if world.time >= (17*60) or world.time <= (7*60) then
                add_to_chat(122, 'WS on Full TP + Dusk to Dawn')
				equip(sets.WSfullTPnight)
            else
				add_to_chat(122, 'WS on Full TP')
				equip(sets.WSfullTP)
            end
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
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
	
	if gain and buff:lower() == "sleep" then  
		add_to_chat(4,'Swapping in Vim Torque to wake you up!')
		equip(sets.WakeSleep)
		disable('neck')
	elseif not gain and buff:lower() == "sleep" then
		add_to_chat(4,'Removing Vim Torque')
		handle_equipping_gear(player.status)
		enable('neck')
	end

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 17)
end

function set_lockstyle()
	send_command('wait 2; input /lockstyleset 17')
end
