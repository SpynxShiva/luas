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

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')


    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = "Caudata Belt"

	
	herc_head_melee={ name="Herculean Helm", augments={'Accuracy+19 Attack+19','Weapon skill damage +2%','DEX+7','Accuracy+6','Attack+10',}}
	herc_head_magic={ name="Herculean Helm", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','INT+7','Mag. Acc.+10','"Mag.Atk.Bns."+13',}}
	herc_hands_dd={ name="Herculean Gloves", augments={'Accuracy+20','"Triple Atk."+3','DEX+7','Attack+7',}}
	herc_feet_magic={ name="Herculean Boots", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +2%','MND+5','"Mag.Atk.Bns."+14',}}
	herc_feet_melee={ name="Herculean Boots", augments={'Accuracy+21 Attack+21','"Triple Atk."+4','VIT+4',}}
	
	
    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()

end

-- Define sets and vars used by this job file.
function init_gear_sets()
    
	--------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    --sets.precast.JA['Hasso'] = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Jukukik Feather",
		head="Adhemar Bonnet",neck="Fotia Gorget", ear1="Moonshade Earring",ear2="Sherida Earring",
		body="Meghanada Cuirie +1",hands="Meg. Gloves +2", ring1="Regal Ring",ring2="Ilabrat Ring",
		back=back_ws,waist="Fotia Belt", legs="Samnuha Tights", feet="Meghanada Jambeaux +2"
	}
	
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		
	})

	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
		ammo="Yetshila",
		neck="Caro Necklace",ear1="Sherida Earring",ear2="Moonshade Earring",
		waist="Grunfeld Rope",legs="Lustratio Subligar"
	})
	
    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
		ammo="Yamarang",
		head="Meghanada Visor +1",
		body="Meg. Cuirie +1",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +1",
		feet="Meg. Jam. +2",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		ear1="Genmei Earring",
		ear2="Etiolation Earring",
		ring1="Defending Ring",
		ring2="Dark Ring",
		back="Solemnity Cape"
	}
	
	sets.idle.Town = set_combine(sets.idle,{})

    -- Defense sets
    sets.defense.Evasion = {}
    sets.defense.PDT = {}
    sets.defense.MDT = {}

    -- Melee sets
    sets.engaged = {
		ammo="Yamarang",
		head="Adhemar Bonnet",
		neck="Asperity Necklace",
		ear1="Sherida Earring",ear2="Cessance Earring",
		body="Adhemar Jacket",hands=herc_hands_dd, ring1="Petrov Ring",ring2="Epona's Ring",
		back="",waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=herc_feet_melee
	}
	sets.engaged.Acc = set_combine(sets.engaged,{	})
    sets.engaged.PDT = {}
    sets.engaged.Acc.PDT = {}
	
	
	-- Orgnizer set
	organizer_items = {
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


