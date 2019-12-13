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
    state.OffenseMode:options('Normal', 'Acc','HighAcc')
    state.HybridMode:options('Normal', 'DT','HighHP')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')


    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = "Caudata Belt"

	-- Additional local binds
    send_command('bind ^z input /ja "Spirit Jump" <t>')
	send_command('bind ^x input /ja "Soul Jump" <t>')
    
    select_default_macro_book()
	
	send_command('bind ^t gs c cycle TreasureMode')
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^z')
    send_command('unbind ^x')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    
	 sets.TreasureHunter = {
        head="Wh. Rarab Cap +1", --1
		waist="Chaac Belt",		-- 1
        body="Volte Jupon",		-- 2
  	}
	
	--------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Angon = {ammo="Angon",hands="Pteroslaver finger gauntlets"}

	sets.precast.FC = {
		ammo="Sapience Orb",		--   2
		head="Carmine Mask +1", 	--	14
		neck="Orunmila's Torque",  	--	 5
		body=gear.Taeon_FC_body,	--	 8
		hands="Leyline Gloves", 	--	 8
		ear1="Loquacious Earring", 	--	 2
		ear2="Etiolation Earring",	-- 	 1
		feet="Carmine Greaves +1",	--	 8
	}								--  48

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",
		body="Dagon breastplate",	
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Flam. Gambieras +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		ring1="Flamma Ring",
		ring2="Niqmaddu Ring",
		back=gear.DRG_WSDA_Cape
	}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	sets.precast.WS.WSD = {
		ammo="Knobkierrie",
		head=gear.Valor_WSD_head,
		body=gear.Valor_WSD_body,
		hands=gear.Valor_WSD_hands,
		legs="Vishap Brais +2",
		feet="Sulevia's Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ear1={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
		ear2="Ishvara Earring",
		ring1="Flamma Ring",
		ring2="Regal Ring",
		back=gear.DRG_WSD_Cape,
	}
	
	sets.precast.WS.WSDACC = set_combine(sets.precast.WS.WSD, {})
    
	sets.precast.WS["Stardiver"] = sets.precast.WS
	sets.precast.WS["Stardiver"].Acc = sets.precast.WS.Acc
	
    sets.precast.WS["Camlann's Torment"] = sets.precast.WS.WSD
    sets.precast.WS["Camlann's Torment"].Acc = set_combine(sets.precast.WS["Camlann's Torment"] , {})

	sets.precast.WS["Sonic Thrust"] = sets.precast.WS.WSD
	sets.precast.WS["Sonic Thrust"].Acc = set_combine(sets.precast.WS["Sonic Thrust"] , {})
	
	sets.precast.WS["Drakesbane"] = set_combine(sets.precast.WS,{
		ear2="Brutal Earring",
		ring1="Begrudging Ring"
	})
    
    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {						--	PDT		MDT
		main="Trishula",			
		sub="Utu Grip",
		ammo="Staunch Tathlum +1",		--	2		2
		head="Hjarrandi Helm",
		body="Hjarrandi Breastplate",	--	8		8
		hands="Sulev. Gauntlets +2",	--	5		5
		legs="Sulev. Cuisses +2",		--	7		7
		feet="Sulevia's Leggings +2",	--	4		4
		neck="Loricate Torque +1",		--	6		6
		waist="Flume Belt +1",			--	4
		ear1="Etiolation Earring",		--			3
		ear2="Odnowa Earring +1",		--			2
		ring1="Moonlight Ring",			--	5		5
		ring2="Defending Ring",			--	10		10
		back=gear.DRG_TP_Cape
	}									--	51		50
	
	sets.idle.Town = set_combine(sets.idle,{})

    -- Defense sets
    sets.defense.Evasion = {}
    sets.defense.PDT = {}
    sets.defense.MDT = {}

    -- Melee sets
    sets.engaged = {
		main="Trishula",
		sub="Utu Grip",
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Dagon breastplate",
		hands="Acro Gauntlets",
		legs=gear.Valor_STP_legs,
		feet="Flam. Gambieras +2",
		neck="Anu Torque",
		waist="Ioskeha Belt +1",
		ear1="Sherida Earring",
		ear2="Dedition Earring",
		ring1="Flamma Ring",
		ring2="Niqmaddu Ring",
		back=gear.DRG_TP_Cape
	}
	
	sets.engaged.Acc = set_combine(sets.engaged,{
		hands="Sulevia's Gauntlets +2",
		legs="Sulev. Cuisses +2",
	})
	
	sets.engaged.HighAcc = set_combine(sets.engaged.Acc,{
		neck="Combatant's Torque",
		ear1="Telos Earring",
		ear2="Cessance Earring",
	})
	
	
	sets.DT = {
		head="Hjarrandi Helm",
		ear2="Brutal Earring",
		body="Hjarrandi Breastplate",
		ring1="Moonlight Ring",	
		hands="Sulev. Gauntlets +2",
		
	}
	
	sets.engaged.DT = set_combine(sets.engaged,sets.DT)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc,sets.DT)
	sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc,sets.DT)
	
	sets.engaged.HighHP = {
		main="Trishula",
		sub="Utu Grip",
		ammo="Egoist's Tathlum",
		head="Flam. Zucchetto +2",
		body="Pelt. Plackart +1",
		hands="Sulev. Gauntlets +2",
		legs={ name="Valor. Hose", augments={'Accuracy+30','"Dbl.Atk."+4','STR+7',}},
		feet="Flam. Gambieras +2",
		neck="Anu Torque",
		waist="Ioskeha Belt +1",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Meridian Ring",
		back="Moonbeam Cape",
	}
	
	sets.engaged.Acc.HighHP = sets.engaged.HighHP
	sets.engaged.HighAcc.HighHP = sets.engaged.HighHP
	
	sets.WakeSleep = {neck="Vim Torque +1"}
	
	-- Orgnizer set
	organizer_items = {
	  polearm1="Trishula",
	  polearm2="Koresuke",
	  grip="Utu Grip",
	  sushi="Sublime Sushi",
	  atkfood="Red Curry Bun",
	  warpr="Warp Ring",
	  cpring="Capacity Ring",
	  cmantle="Mecisto. Mantle"
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
    set_macro_page(2, 11)
end
