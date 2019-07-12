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
    state.Buff['Hasso'] = buffactive['hasso'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('DT')


    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = "Caudata Belt"
	
	gear.Valor_TP_body = { name="Valorous Mail", augments={'Accuracy+26','"Store TP"+6','DEX+10','Attack+15',}}
	gear.Ryuo_TP_legs = { name="Ryuo Hakama", augments={'Accuracy+20','"Store TP"+4','Phys. dmg. taken -3',}}

	-- Additional local binds
    send_command('bind ^z input /ja "Spirit Jump" <t>')
	send_command('bind ^x input /ja "Soul Jump" <t>')
    
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

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Knobkierrie",
		head=gear.Valor_WSD_head,
		body="Sakonji Domaru +3",
		hands=gear.Valor_WSD_hands,
		legs="Wakido Haidate +3",
		feet=gear.Valor_WSD_feet,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
		ring1="Karieyh Ring +1",
		ring2="Epaminondas's Ring",
		back=gear.SAM_WS_Cape,
	}

	sets.precast.WS.Acc = set_combine(sets.precast.WS,{ring2="Regal Ring"})
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Tachi: Jinpu'] = {
		ammo="Knobkierrie",
		head=gear.Valor_WSD_head,
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body="Found. Breastplate",
		hands="Founder's Gauntlets",
		ring1="Karieyh Ring +1",
		ring2="Epaminondas's Ring",
		waist="Fotia Belt",
		legs="Wakido Haidate +3",
		feet="Founder's Greaves",
		back=gear.SAM_WS_Cape,
	}
	
    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {						--	PDT		MDT
		ammo="Staunch Tathlum +1",		--	2		2
		head="Loess Barbuta +1",		--	10		10
		neck="Loricate Torque +1",		--	6		6
		left_ear="Etiolation Earring",	-- 			3
		right_ear="Odnowa Earring +1",	--			2
		body="Chozoron Coselete",		--	8		8
		hands="Macabre Gauntlets +1",	--	4
		ring1="Defending Ring",			--	10		10	
		ring2=gear.dark_ring,			--	6		4
		legs=gear.Ryuo_TP_legs,			--	3
		feet="Loyalist Sabatons",		--	5
		waist="Flume Belt +1",			--	4
		back="Moonbeam Cape",			--	5		5
	}									--	63		50	
	
    -- Defense sets
    sets.defense.DT = sets.idle
	sets.defense.MDT = sets.idle
    
    -- Melee sets
    sets.DT = {
		ammo="Staunch Tathlum +1",	--	2		2
		neck="Loricate Torque +1",	--	6		6
		ring1="Regal Ring",
		ring2="Defending Ring",		--	10		10	
		back=gear.SAM_TP_Cape,		--	10		
	}								--	34		22
	
	
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
	
	sets.engaged.MidAcc = set_combine(sets.engaged,{
		body="Kendatsuba Samue +1",
		legs="Kendatsuba Hakama +1",
		feet="Flam. Gambieras +2",
	})
	
	sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc,{
		ear1="Cessance Earring",
		ring2="Regal Ring"
	})
	
	
	sets.idle.Town = set_combine(sets.engaged.MidAcc,{})
		
	sets.engaged.DT = set_combine(sets.engaged,sets.DT)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc,sets.DT)
	sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc,sets.DT)
	
	
	sets.WakeSleep = {neck="Vim Torque +1"}
	
	-- Orgnizer set
	organizer_items = {
		gkt1="Masamune",
		gkt2="Dojikiri Yasutsuna",
		gkt3="Norifusa +1",
		polearm="Shining One",
		grip="Utu Grip",
		acc_food="Sublime Sushi",
		atk_food="Red Curry Bun",
		remedy="Remedy"
	}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    
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
	
	if gain and status == "sleep" then  
		add_to_chat(4,'Swapping in Vim Torque to take you up!')
		equip(sets.WakeSleep)
	elseif not gain and status == "sleep" then
		add_to_chat(4,'Removing Vim Torque')
		handle_equipping_gear(player.status)
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

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 17)
end

function set_lockstyle()
	send_command('wait 2; input /lockstyleset 17')
end
